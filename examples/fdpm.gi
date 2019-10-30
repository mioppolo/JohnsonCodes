# Hello I will be useful one day but right now I'm broken
# Best wishes,
# fdpm.gi

SummarisePointStabsFDPM := function(dimV, epsilon)
    local form, Qeps, sym, orbs, reps, stabs, pt, struc, numorbs, i;
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

SummarisePointStabsFDPM2 := function(dimV, epsilon)
    local form, Qeps, sym, orbs, reps, orth, stabs, pt, pstab, struc, numorbs, i;
    form := JCStandardForm(dimV, epsilon);
    Qeps := JCQuadForms(form);
    sym := FullyDeletedPermutationModule(dimV+2,GF(2));
    orbs := Orbits(sym,Qeps,OnQuadraticForms);
    reps := List(orbs,Representative);
	orth := List(reps, pt->IsometryGroup(PolarSpace(pt)));
    stabs := List(orth,pstab->Intersection(sym,pstab));
    struc := List(stabs,StructureDescription);
    numorbs := Size(reps);
    for i in [1..numorbs] do;
        Print("Orbit ", i, " of ", numorbs, " has length ", Size(orbs[i]), " and stabiliser ", struc[i], "\n");
    od;
end;

# Testing 
dimV:=8;
epsilon:=1;
form := JCStandardForm(dimV, epsilon);
Qeps := JCQuadForms(form);
sym := FullyDeletedPermutationModule(dimV+2,GF(2));
orbs := Orbits(sym,Qeps,OnQuadraticForms);
reps := List(orbs,Representative);
orth := List(reps, pt->IsometryGroup(PolarSpace(pt)));
stabs := List(orth,pstab->Intersection(sym,pstab));
struc := List(stabs,StructureDescription);
numorbs := Size(reps);
