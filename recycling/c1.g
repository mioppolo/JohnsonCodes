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

	gram := Phi0Gram(dimV, 1);
	w := SymplecticSpace(dimV-1, 2);
	g := IsometryGroup(w);
	basis := List([1..dimU], i -> gram[2*i]);
	subspace := VectorSpaceToElement(w, basis);
	parabolic := FiningStabiliser(g, subspace);

	return parabolic;
end;
