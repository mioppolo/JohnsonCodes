# dimV - choose an even number, 6 or more
# eps - choose 1 or -1
# Other options will yield unexpected results
dimV := 8;
eps := 1;
deg := dimV+2;
mats := FullyDeletedPermutationRep( deg, GF(2) );
sypdetector:=PreservedSesquilinearForms(Group(mats));
syp:=sypdetector[1];
gens:=List(mats, matrix -> CollineationOfProjectiveSpace( matrix, GF(2) ));
s:=Group(gens);
hform := FDPMHyperbolicForm(dimV);
eform := FDPMEllipticForm(dimV);
w:=PolarSpace(syp);
g:=IsometryGroup(w);

if eps=1 then;
    bigQ := Filtered(FDPMForms(dimV),IsHyperbolicForm);
elif eps = -1 then;
    bigQ := Filtered(FDPMForms(dimV),IsEllipticForm);
else
    Print("epsilon must be plus or minus 1");
fi;



form:=QuadraticFormByMatrix(quadgram);
quad:=PolarSpace(form);
orth:=IsometryGroup(quad);
pstab:=Intersection(orth,s);
