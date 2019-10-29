# Hello I will be useful one day but right now I'm broken
# Best wishes,
# fdpm.gi

SummarisePointStabsFDPM := function(dimV, epsilon)
    local form, Qeps, sym, orbs, reps, stabs, pt, struc;
    form := JCStandardForm(dimV, epsilon);
    Qeps := JCQuadForms(form);
    sym := FDPMJordanSteinerPermRep(dimV,epsilon);
    orbs := Orbits(sym);
    reps := List(orbs,Representative);
    stabs := List(reps,pt->Stabilizer(sym,pt));
    struc := List(stabs,StructureDescription);
    numorbs := Size(reps);
    for i in [1..numorbs] do;
        Print("Orbit ", i, " of ", numorbs, " has length ", Size(orbs[i]), " and stabiliser ", struc[i], "\n");
    od;
end;
