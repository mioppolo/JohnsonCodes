# Returns a particular nondegenerate subspace of dimension 2d
# V = <e1,f1,..,en,fn>
# U = <e1,f1,..,ed,fd>
NDSubspace := function(n, d)
  local
    dimV,
    dimU,
    pg,       # PG(2n-1,2)
    id,       # Identity Matrix
    basis,    # Basis for subspace
    subspace; # Fining subspace; return value

  dimV := 2*n;
  dimU := 2*d;
  pg := PG(dimV-1, 2);
  id := IdentityMat(dimV);
  basis := List([1..dimU], i -> id[i]);
  subspace := VectorSpaceToElement(pg, basis);
    return subspace;
end;

# Returns set of nondegenerate subspaces in PG(dimV-1,2)
# B is the standard symplectic form
NDSubspaces := function(dimV,dimU)
  local
    pg,				# PG(2n-1,2)
    w,				# W(2n-1,2)
    g,				# Sp(2n,2)
    id,				# Identity matrix
    i,				# Index used to construct basis
    basis,			# Basis for U
    subspace,		# Non-degenerate subspace seed
    spaces;     # Set of nondegenerate subspaces

  # Make sure dimU is even
  if not dimV/2 in Integers then;

  	return fail;

  else;
  	pg := PG(dimV-1, 2);
  	w := SymplecticSpace(dimV-1, 2);
  	g := IsometryGroup(w);
  	id := IdentityMat(dimV);
  	basis := List([1..dimU], i -> id[i]);
  	subspace := VectorSpaceToElement(pg, basis);
    spaces := FiningOrbit(g,subspace);
  fi;
  return spaces;
end;


NDSubgroup := function(dimV, dimU)
	local
		pg,				# PG(2n-1,2)
		w,				# W(2n-1,2)
		g,				# Sp(2n,2)
		id,				# Identity matrix
		i,				# Index used to construct basis
		basis,			# Basis for U
		subspace,		# Non-degenerate subspace
		ndsubgroup;		# Stabiliser of the subspace

	# Make sure dimU is even
	if not dimV/2 in Integers then;

		return fail;

	else;
		pg := PG(dimV-1, 2);
		w := SymplecticSpace(dimV-1, 2);
		g := IsometryGroup(w);
		id := IdentityMat(dimV);
		basis := List([1..dimU], i -> id[i]);
		subspace := VectorSpaceToElement(pg, basis);
		ndsubgroup := FiningStabiliser(g, subspace);

	fi;

		return ndsubgroup;
end;

ParabolicSubgroup := function(dimV, dimU)
	local
		w,				# W(2n-1,2)
		g,				# Sp(2n,2)
		gram,			# Gram Matrix for bulding subspace
		basis,			# Basis for U
		subspace,		# Totally isotropic subspace
		parabolic;		# Parabolic subgroup

	gram := JCStandardGram(dimV, 1);
	w := SymplecticSpace(dimV-1, 2);
	g := IsometryGroup(w);
	# We can pull out a basis for U from the "standard" gram matrix
	basis := List([1..dimU], i -> gram[2*i]);
	subspace := VectorSpaceToElement(w, basis);
	parabolic := FiningStabiliser(g, subspace);

	return parabolic;
end;
