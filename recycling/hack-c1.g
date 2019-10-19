
CharacteristicVector := function( set, subset)
    local i, vec, length;
    length := Size(set);
    vec := List([1..length], t->0);
    for i in [1..length] do
        if set[i] in subset then
            vec[i] := 1;
        fi;
    od;
    return vec;
end;

IncidenceMat := function( points, blocks )
	local block;
	return List(blocks, block -> CharacteristicVector(points, block));
end;

####### Start here

CodeData := function(dimV, dimU, epsilon)
	local r, ellipoly, poly, i, n, w, g, gens, syp, sypgram, zero, formgram, form, orth, ssmat, subspace, stab, orthstab, bigQ, orbs, codeword, code, incmat, lincode, lindim, rate, weights, data;

	##### Symplectic and Parabolic Definitions
w:=SymplecticSpace(dimV-1,2);
g:=IsometryGroup(w);
gens:=List(GeneratorsOfGroup(g), i->Unpack(i!.mat));
syp:=PreservedSesquilinearForms(Group(gens))[1];
sypgram:=GramMatrix(syp);
zero:=List([1..dimV],i->0*Z(2));
formgram:=List(sypgram, i->ShallowCopy(i));
n := dimV/2;
for i in [1..n] do formgram[2*i] := zero; od;
form:=QuadraticFormByMatrix(formgram);
#### TO make it elliptic
if epsilon = -1 then
r:=PolynomialRing(GF(2),dimV);
ellipoly := r.1*r.1 + r.2*r.2;
poly :=PolynomialOfForm(form)+ellipoly;
form:=QuadraticFormByPolynomial(poly,r);
fi;
orth:=IsometryGroup(PolarSpace(form));

##### Defining the subspace
ssmat := List([1..dimU], i -> sypgram[2*i]);
subspace:=VectorSpaceToElement(w,ssmat);
stab:=Stabilizer(g,subspace);
orthstab:=Intersection(stab,orth);

##### Codeword Construction
bigQ:=AsSet(Orbit(g,form,OnQuadraticForms));
orbs:=Orbits(stab,bigQ,OnQuadraticForms);
codeword:=AsSet(orbs[1]);
code := Orbit(g, codeword, OnCodewords);

##### Linear code
incmat := IncidenceMat(bigQ, code);
lincode := VectorSpace(GF(2), Z(2)*incmat);
lindim := Dimension(lincode);
rate := 1.0*Dimension(lincode)/Size(bigQ);
#weights := AsSet(List(lincode, i -> WeightVecFFE(i)));


data := [
["length", Size(bigQ)],
["block length", lindim],
["Rate",rate]
#["weights",weights],
];

return data;
end;








######## FOR CHANGING BASIS (squish your matrix)


cobgap:=[[1,0,0,0,0,0],
	 [0,0,0,1,0,0],
	 [0,1,0,0,0,0],
	 [0,0,0,0,1,0],
	 [0,0,1,0,0,0],
	 [0,0,0,0,0,1]]*Z(2);

cobt:=CollineationOfProjectiveSpace(cobgap,GF(2));
cob:=CollineationOfProjectiveSpace(TransposedMat(cobgap),GF(2));




########################################################################
#                       Code Construction                              #
########################################################################

codespace:=Combinations(bigQ,6);
code:=AsSet(Orbit(g,codeword,OnCodewords));
notcode:=Difference(codespace,code);


StabSet := function(g, s, act, pts)
  local hom, u, omega, imgs, stab, gens;
  hom := ActionHomomorphism(g, pts, act);
  u := UnderlyingExternalSet(hom);;
  omega := HomeEnumerator(u);;
  imgs := Filtered([1..Size(omega)], x -> omega[x] in s);;
  stab := Stabilizer(Image(hom), imgs, OnSets);
  if IsTrivial(stab) then
     return Kernel(hom);
  else
     gens := GeneratorsOfGroup(stab);
     gens := List(gens, x -> PreImagesRepresentative(hom, x));
     return GroupWithGenerators(gens);
  fi;
end;

codeaut := StabSet(g, code, OnCodewords, codespace);















# Sizecal
f := function( n, d )
	local answer;
	answer:=2^d * (2^(2*(n-d)-1)+2^(n-d-1));
	return answer;
end;




# Stabsize
f := function( n, d )
	local gl, glsize, syp, sypsize, answer;
	gl:=GL(d,2);
	glsize:=Size(gl);
	syp:=Sp(2*(n-d),2);
	sypsize:=Size(syp);
	answer:= 2^(d*(d+1)/2) * 2^(2*d*(n-d)) * sypsize * glsize;
	return answer;
end;

