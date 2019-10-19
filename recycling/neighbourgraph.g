# Written by Max
# Edited by Mark
# Names of functions:
# MaximalSubgroupsOfGroup2 := function(r)
# InvestigateSubgroup2 := function(G,H)
# AnalyseGroup2 := function(G,hints)

InvestigateSubgroup2 := function(G,H)
  # Calculate numbers for SIT testing.
  # G a transitive permutation group on D
  # H a subgroup of G
  # Do the following:
  # 1.  Compute the number of orbits of H in D
  # 2.  If it is two, compute the point stabilizer S of a point
  #     in the first (smaller) orbit and then the number of orbits of S on
  #     the second orbit.
  # Return value is a record containing:
  #    G : the group G
  #    H : the group H
  #    Horbitlens : OrbitLengths of H in D
  #    S : stabiliser in H of the first point of the first orbit
  #    Sorbits : number of S orbits on the second H orbit on D

  # Local variables
  local 
    dom,    #
    o,      #
    nr,     #
    nrs,    #
    S,      #
    oo      #
    ;

  if not(IsTransitive(G)) then
     Error("G must be transitive");
  fi;

  dom := MovedPoints(G);
  o := Orbits(H,dom);
  nrs := List(o,Length);
  nr := Length(o);
  
  if nr <> 2 then return 
      rec( G := G, H := H, Horbitlens := nrs ); 
  fi;
  if Length(o[1]) > Length(o[2]) then
      o := o{[2,1]};
      nrs := List(o,Length);
  fi;
  # Stabiliser a point in orbit 1 and compute stabiliser orbits in orbit 2
  S := Stabilizer(H,o[1][1]);
  oo := Orbits(S,o[2]);

  return rec(   G := G,
                H := H, 
                Horbitlens := nrs, 
                S := S, 
                Sorbitnr := Length(oo),
                Sorbitlens := List(oo,Length) 
            );
end; 

InvestigateNeighbourTransitiveCode := function(g,m)
  # g a transitive permutation group
  # m a subgroup (usually maximal, but this is not needed)
  # The group m must have exactly two orbits on the MovedPoints(g)
  # and must be the setwise stabiliser of these two orbits, usually
  # m will be maximal in g. Let n be the size of MovedPoints(g) and
  # k be the size of the smaller of the two m-orbits.
  # This function then investigates the code which is the g orbit of
  # the smaller m-orbit acting on k-sets. This is a subset of the Johnson
  # graph (consisting of k-sets) with [g:m] elements, or alternatively, 
  # it is a non-linear binary code in F_2^n whose code words all have
  # exactly k ones. g is then a subgroup of the automorphism group of
  # this code.
  # In particular, we compute the minimal distance in the Johnson graph.
  # Note that this is half the minimum distance in the Hamming-distance,
  # if we view the code as a binary code.
  local code,d,dist,i,isstrongincidencetransitive,o,oo,r,s,size,starttime,sub;
  starttime := Runtime();
  
  # Sanitycheck: Is g transitive?
  if not(IsTransitive(g)) then 
    return [fail,"g is not transitive"]; 
  fi;
  d := MovedPoints(g);
  o := Orbits(m,d);
  
  # If m does not have 2 orbits then we are done
  if Length(o) <> 2 then
    return [fail,"m does not have two orbits on MovedPoints(g)"];
  fi;
  # The first orbit is the smaller one
  if Length(o[1]) > Length(o[2]) then
    o := o{[2,1]};
  fi;
  # Fix a point in the smaller orbit and check if still transitive on other orbit
  s := Stabilizer(m,o[1][1]);
  oo := Orbits(s,o[2]);
  isstrongincidencetransitive := Length(oo) = 1;
  # Size of the code is the index |g:m|
  size := Size(g)/Size(m);
  Print("Expected orbit length (size of code): ",size,".\n");
  code := Orb(g,Set(o[1]),OnSets,rec( treehashsize := NextPrimeInt(2*size),
                                      report := 10000,
                                      storenumbers := true ));
  Print("Enumerating code...\n");
  Enumerate(code);
  Print("Done, have ",Length(code)," code sets.\n");
  if Length(code) <> size then
    Print("Warning: m was not the setwise stabiliser of the smaller orbit!\n");
  fi;
  # Now for the minimum distance:
  # Note that g is a subgroup of the automorphism group of the code simply
  # by construction, usually it will be the full automorphism group.
  # Also, since we are acting with g on k-sets, g is a subgroup of the
  # automorphism group of the Johnson graph, therefore it preserves
  # incidence there. The distance between two k-sets in the Johnson graph
  # is k-Size(intersection), since in every step in the Johnson graph we can
  # exchange one number by another. m is a subgroup of the setwise stabiliser
  # of the first code set, therefore we only have to actually compute distances
  # between the first code word and some code word in each m-suborbit.
  sub := FindSuborbits(code,GeneratorsOfGroup(m));
  dist := List([1..sub.nrsuborbits],
               i->Length(code[1])
                  -Length(Intersection(code[sub.reps[1]],code[sub.reps[i]])));
  # This now contains the distances from the start code word to all the
  # other code words, it has one number for each m-suborbit.
  r := rec();
  r.code := code;
  r.setsize := Length(code[1]);
  r.k := Length(code[1]);
  r.n := Length(d);
  r.domainsize := Length(d);
  r.isstrongincidencetransitive := isstrongincidencetransitive;
  r.g := g;
  r.m := m;
  r.missetwisestab := Length(code) = size;
  r.weightenum := rec( 0 := 1 );
  for i in [2..sub.nrsuborbits] do
      if not(IsBound(r.weightenum.(dist[i]))) then
          r.weightenum.(dist[i]) := 0;
      fi;
      r.weightenum.(dist[i]) := r.weightenum.(dist[i]) + sub.lens[i];
  od;
  r.codesize := Length(code);
  Sort(dist);
  r.runtime := Runtime() - starttime;
  r.mindist := dist[2];
  r.hammingmindist := 2*dist[2];
  return r;
end;

MaximalSubgroupsOfGroup2 := function(r)
  # r a record with grp component a group and hints component hints.
  local checker,find,gens,i,max,maxes,maxgens,name,slp;
  if r.hints <> fail then
      name := r.hints.name;
  else
      name := fail;
  fi;
  while IsStringRep(name) do    # used to jump out via break
      # Try to use the WWW Atlas:
      gens := GeneratorsOfGroup(r.grp);
      checker := AtlasProgram(name,"check");
      if checker = fail then break; fi;
      if ResultOfStraightLineDecision(checker.program,gens) <> true then
          find := AtlasProgram(name,"find");
          if find = fail then break; fi;
          gens := ResultOfBBoxProgram(find.program,r.grp);
          if gens = fail then break; fi;
      fi;
      # If we get here then gens are standard gens for this group
      maxes := [];
      for i in [1..100] do
          slp := AtlasStraightLineProgram(name,i);
          if slp = fail and i <> 1  then break; fi;
          maxgens := ResultOfStraightLineProgram(slp.program,gens);
          max := Group(maxgens);
          if r.hints.hints <> fail and IsBound(r.hints.hints[i]) then
              Add(maxes,rec( grp := max, hints := r.hints.hints[i] ) );
          else
              Add(maxes,rec( grp := max, hints := fail ));
          fi;
      od;
      return maxes;
  od;

  maxes := List(ConjugacyClassesMaximalSubgroups(r.grp),
                c->rec( grp := Representative(c), hints := fail ));
  return maxes;
end;

AnalyseGroup2 := function(G,hints)
# Analyse a complete group by going down maximal subgroups
# Hints is a record with entries "name" and "hints" where name can be fail 
# or a WWW Atlas name.
# If name is a string then hints is either fail or a list of hints which
# are used for the maximal subgroups.
# Requires: InvestigateSubgroup2, MaximalSubgroupsOfGroup2 and InvestigateNeighbourTransitiveCode
    local 
        IsInDB,
        c,
        codes,
        db,
        i,
        l,
        s;

    l := [rec( grp := G, hints := hints )];     # Group being analysed?
    codes := [];                                # List of codes we've found
    i := 1;
    db := rec( orders := [], groups := [] );    # Database of groups

    # A function to check if H we have already done a calculation for H
    IsInDB := function(H)
        local i, order, pos;
        order := Size(H);
        pos := PositionSorted(db.orders,order);
        if pos > Length(db.orders) or db.orders[pos] <> order then
            Add(db.orders,order,pos);
            Add(db.groups,[H],pos);
            return false;
        fi;
        for i in [1..Length(db.groups[pos])] do
            if IsConjugate(G,H,db.groups[pos][i]) then
                return true;
            fi;
        od;
    Add(db.groups[pos],H);
    return false;
    end;

    while i <= Length(l) do
        # Check if we have already done the computation
        if not(IsInDB(l[i].grp)) then
            Print("Considering subgroup #",i,"(",Length(l),")\n");
            # s contains information about the number of orbits and suborbits
            # of a maximal subgroup
            # Note: On first pass we compute InvestigateSubgroup2(G,G)
            # which forces us to evaluate the maximal subgroups
            # of G
            s := InvestigateSubgroup2(G,l[i].grp);
            if Length(s.Horbitlens) = 2 and s.Sorbitnr <= 2 then
                c := InvestigateNeighbourTransitiveCode(G,s.H);
                #
                # EDIT: I allow delta =1 but forbid k=1
                if c.mindist < 2 then
                    Print("Found minimum distance 1. Ignoring.\n");
                elif not(c.missetwisestab) then
                    Print("Found subgroup of setwise stab, ignoring.\n");
                elif not(c.isstrongincidencetransitive) then
                    Print("Found non-sit code. Ignoring. \n");
                else
                    Add(codes,c);
                    Print("Found code, minimal distance is ",c.mindist,".\n");
                fi;
            fi;
            if Length(s.Horbitlens) = 1 or 
                    (Length(s.Horbitlens) = 2 and s.Sorbitnr = 1) then  
                # Need maximal subgroups of this one:
                Append(l,MaximalSubgroupsOfGroup2(l[i]));
            fi;
        else
            Print("Skipping duplicate subgroup #",i,"(",Length(l),")\n");
        fi;
        Unbind(l[i]);   # to save some memory
        i := i + 1;

    od;
    return codes;
end;
