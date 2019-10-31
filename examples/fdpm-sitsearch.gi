# This function checks the claims made in Lemma 5.4.1 of my thesis

SummarisePointStabsFDPM := function(dimV, epsilon)
    local form, Qeps, sym, orbs, reps, stabs, pt, struc, numorbs, i, issit;
    sym := FDPMJordanSteinerPermRep(dimV,epsilon);
    orbs := Orbits(sym);
    reps := List(orbs,Representative);
    stabs := List(reps,pt->Stabilizer(sym,pt));
    struc := List(stabs,StructureDescription);
    numorbs := Size(reps);
    for i in [1..numorbs] do;
        Print("Orbit ", i, " of ", numorbs, " has length ", Size(orbs[i]), " and stabiliser ", struc[i], "\n");
    od;
    if numorbs = 2 then;
            issit := IsTransitive(stabs[1],orbs[2]);
            Print("Do the two orbits yield a strongly incidence-transitive code? ", issit);
    fi;
end;

SummarisePointStabsFDPM(8,1);
SummarisePointStabsFDPM(12,1);
SummarisePointStabsFDPM(8,-1);
SummarisePointStabsFDPM(12,-1);
SummarisePointStabsFDPM(16,-1);
