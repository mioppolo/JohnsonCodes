############################################################################
#          John's Permutation Module                     #
############################################################################

FullyDeletedPermutationRep := function( n, gf )
  ## This function returns the (generators for the) representation
  ## of Sym(n) in GL(d,q), induced by the fully deleted permutation module.

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
  ConvertToMatrixRep(m1, gf); ConvertToMatrixRep(m2, gf);
  return [m1, m2];
end;
