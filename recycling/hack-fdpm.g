############################################################################
#          John's Permutation Module                     #
############################################################################


## You're dicking around with bases here
mats := FullyDeletedPermutationRep( 10, GF(2) );
sypdetector:=PreservedSesquilinearForms(Group(mats));
syp:=sypdetector[1];
bc:=BaseChangeToCanonical(syp);
mats:= List(mats,t->bc*t*Inverse(bc));
gens:=List(mats, matrix -> CollineationOfProjectiveSpace( matrix, GF(2) ));
s:=Group(gens);


### CHECK AGAIN
sypdetector:=PreservedSesquilinearForms(Group(mats));
syp:=sypdetector[1];
w:=PolarSpace(syp);
g:=IsometryGroup(w);



##### Construct your initial form
quadgram:=[	[0,0,0,0,0,0,0,0],
			[1,0,0,0,0,0,0,0],
			[0,1,0,0,0,0,0,0],
			[0,0,1,0,0,0,0,0],
			[0,0,0,1,0,0,0,0],
			[0,0,0,0,1,0,0,0],
			[0,0,0,0,0,1,0,0],
			[0,0,0,0,0,0,1,0] ]*Z(2);
form:=QuadraticFormByMatrix(quadgram);
quad:=PolarSpace(form);
orth:=IsometryGroup(quad);
pstab:=Intersection(orth,s);





stdbasisvec := function( i, length)
	local vec;
	vec := List([1..length], t-> 0*Z(2));
	vec[i] := Z(2);
return vec;
end;



gram := function( dimV )
	local matrx;
	matrx := [1..dimV];
	matr













spaces := ElementsOfIncidenceStructure(w7,2);
spacesbad := ElementsOfIncidenceStructure(w7,4);
stab := StabSet(g,spread,OnProjSubspaces,spaces);
stabbad := StabSet(g,spreadbad,OnProjSubspaces,spacesbad);

