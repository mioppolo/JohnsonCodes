# JCAnalyseGroup
#
# Input:    Transitive permutation group G
#
# Output:   A list of all SIT codes induced by G acting on MovedPoints(G)
#           Each code is stored in a record with orbit and group data
#
# Notes:    analysis.______ is used to access record components from output of JCAnalyseSubroup
#
JCAnalyseGroup := function(G)
    local
        codes,      # A list of SIT codes
        db,         # Database of analysis results
        ls,         # List of subgroups awaiting testing
        H,          # Current subgroup of G being tested
        M,          # Maximal subgroup of H
        i,          # Index for DB
        reps,       # Representatives of conjugacy classes of maximal subgroups of H
        IsInDB,     # Check if a subgroup is in DB
        analysis    # Stores information about current subgroup analysis
        ;

    ls := [G];
    db := rec(groups := [], orders := []);
    codes := [];

    # Checks whether a conjugate of H is in the database and adds if needed
    IsInDB := function(H)
        local i, j, order, pos;
        order := Size(H);
        pos := PositionSorted(db.orders,order);
        if pos > Length(db.orders) or db.orders[pos] <> order then
            Add(db.orders,order,pos);
            Add(db.groups,H,pos);
            return false;
        fi;
		j := pos;
        while db.orders[j] = order do
            if IsConjugate(G,H,db.groups[j]) then
                return true;
            fi;
		j := j + 1;
        od;
    Add(db.groups,H,pos);
    return false;
    end;

    # Now we begin our analysis
    i := 1;
    while i <= Length(ls) do
        H := ls[i];
        if not(IsInDB(H)) then
            analysis := JCAnalyseSubgroup(G,H);

            if analysis.Htransitive then
                reps := List(ConjugacyClassesMaximalSubgroups(H), Representative);
                Append(ls,reps);

            elif analysis.isSITCode then
                Add(codes,analysis);
            fi;
        fi;
        i := i+1;
    od;
    return codes;
end;

# JCAnalyseSubgroup
#
# Input:    Transitive permutation group G
#           Subgroup H of G
#
# Output:   We test for strong incidence-transitivity and return results as a record
#           Record has components:
#
# Structure:    - Is G transitive?
#               - Does H have two orbits in omega?
#               - Does one of the orbits have length 1?
#               - Does one stabiliser act transitively on the other orbit?
#               - Return a summary
#
JCAnalyseSubgroup := function(G,H)
    #input: A group G and a subgroup H <= G
    #output: A record with the tags Horbits, numOrbits, lenOrbits,
    #           Htransitive, conclusion, Htransitive, isSITCode, ptStab
    local
        omega,      # Moved points of G
        Gintrans,   # Checks if G is intransitive on omega
        outcomes,   # Acceptable results
        HOrbits,    # H-orbits in omega
        numOrbits,  # Number of H-orbits in omega
        lenOrbits,  # List of H-orbit lengths
        ptStab,     # Stabiliser of first point in first orbit
        transNCW,   # True if and only if ptStab is transitive on second orbit
        Htransitive,# True if and only if H is transitive on omega
        conclusion, # Our results summarised as a string
        results     # Record containing our results
        ;

    omega := MovedPoints(G);
    results := rec();
    results.isSITCode := false;     # False until true
    results.Htransitive := false;   # False until true
    outcomes := [
        "H is transitive on Omega",
        "H has more than two orbits in Omega",
        "H has two orbits but one has length 1",
        "H has two orbits but doesn't yield a SIT code",
        "H yields a SIT code with 1<k<|Omega|"
        ];

    # Is G transitive?
    Gintrans := not IsTransitive(G,omega);
    if Gintrans then
        Error("G must act transitively on Omega");
    fi;

    # Investigate the number of H-orbits in omega and store in results record
    HOrbits := Orbits(H,omega);
    numOrbits := Size(HOrbits);
    lenOrbits := List(HOrbits,Size);
    results.HOrbits := HOrbits;
    results.numOrbits := numOrbits;
    results.lenOrbits := lenOrbits;

    if numOrbits < 1 then
        Error("The number of H-orbits must be a positive integer. Something has gone horribly wrong.");
    elif numOrbits = 1 then
        # H is transitive on Omega
        results.conclusion := outcomes[1];
        results.Htransitive := true;
    elif numOrbits > 2 then
        # H has too many orbits in Omega
        results.conclusion := outcomes[2];
    elif 1 in lenOrbits then
        # I don't want k = 1
        results.conclusion := outcomes[3];
    else
        # H has two orbits in Omega, but is the code SIT?
        ptStab := Stabiliser(H,HOrbits[1][1]);
        results.ptStab := ptStab;
        transNCW := IsTransitive(ptStab,HOrbits[2]);
        if not transNCW then
            # Two orbits but not SIT
            results.conclusion := outcomes[4];
        else
            # Strongly incidence transitive code!
            results.conclusion := outcomes[5];
            results.isSITCode := true;
        fi;
    fi;

    return results;
end;
