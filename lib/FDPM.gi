#############################################################################
#          John's Permutation Module Gens - modified by Mark                #
#############################################################################

FullyDeletedPermutationGens := function(n, gf)
  ## Generators for the fully deleted permutation module of Sym(n) in GL(d,q)
  local p, d, id, one, zero, vec, vec2, m1, m2;
  p := Characteristic(gf);
  one := One(gf);
  zero := Zero(gf);

  if n mod p = 0 then
    # Basis e1 - e2, e2 - e3, e3 - e4, ..., e(n-2) - e(n-1)
    d := n - 2;
    vec := List([1..d], t -> (n-t)*-one);
    vec2 := List([1..d-1], t -> zero);
    id := MutableCopyMat(IdentityMat(d-1, gf));
    m1 := TransposedMat(Concatenation([vec2], id));
    m1 := Concatenation(m1, [vec]);
    m2 := MutableCopyMat(IdentityMat(d, gf));
    m2[1][1] := -one;
    m2[2][1] := one;
  else
    # Basis e1 - e2, e1 - e3, ..., e1 - en
    d := n - 1;
    vec := List([1..d-1],t->-one);
    vec2 := Concatenation([-one], List([1..d-1], t -> zero));
    id := MutableCopyMat(IdentityMat(d-1, gf));
    m1 := TransposedMat(Concatenation([vec], id));
    m2 := Concatenation([vec2], m1);  ## transposition
    m1 := Concatenation(m1, [vec2]); ## n-cycle
  fi;
  ConvertToMatrixRep(m1, gf);
  ConvertToMatrixRep(m2, gf);
  return [m1, m2];
end;

FullyDeletedPermutationGens2 := function(n, gf)
    ## Change of basis, please
    local mats, sypdetector, syp, bc;
    mats := FullyDeletedPermutationGens(n, gf);
    sypdetector:=PreservedSesquilinearForms(Group(mats));
    syp:=sypdetector[1];
    bc:=BaseChangeToCanonical(syp);
    mats:= List(mats,t->bc*t*Inverse(bc));
    return mats;
end;

FullyDeletedPermutationModule := function(n, gf)
    local gens, matrix;
    gens := FullyDeletedPermutationGens2(n, gf);
    gens := List(gens, matrix -> CollineationOfProjectiveSpace( matrix, gf ));
    return Group(gens);
end;

# Gram matrix for a hyperbolic quadratic form preserved by the fully deleted permutation module for Sn
FDPMHyperbolicGram := function(dimV)
	#	Computes a gram matrix for the alternate quadratic form
	local
		zero,	# Zero vector
		id,		# Identity matrix
		gram;	# Gram matrix

	zero := List([1..dimV-1], i -> 0);
	id := IdentityMat(dimV-1);
	gram := Concatenation([zero], id);
	zero := List([1..dimV], i -> 0);
	gram := Z(2)*Concatenation(TransposedMat(gram), [zero]);

	return gram;
end;

FDPMHyperbolicForm := function(dimV)
    return QuadraticFormByMatrix(FDPMHyperbolicGram(dimV));
end;

FDPMEllipticGram := function(dimV)
    # Start from a hyperboic gram matrix and add elements on the diagonal
    # FDPMHyperbolicForm(e1+e2)=1, so the form below is elliptic
    local hypgram, diag, coord;
    hypgram := FDPMHyperbolicGram(dimV);
    diag := List([1..dimV], coord -> Z(2)*0);
    diag[1] := Z(2);
    diag[2] := Z(2);
    return hypgram+DiagonalMat(diag);
end;

FDPMEllipticForm := function(dimV)
    return QuadraticFormByMatrix(FDPMEllipticGram(dimV));
end; 

FDPMForms := function(dimV)
	#	Computes a gram matrix for the alternate quadratic form
	local hypgram, v, vec, forms;
    v := GF(2)^dimV;
	hypgram := FDPMHyperbolicGram(dimV);
	forms := List(v, vec -> QuadraticFormByMatrix(DiagonalMat(vec)+hypgram));
	return AsSet(forms);
end;
