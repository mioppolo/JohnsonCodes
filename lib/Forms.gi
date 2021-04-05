###############################################################################
#	Quadratic form definitions
###############################################################################

# Returns the gram matrix of the standard nondegenerate epsilon-quadratic form
JCStandardGram := function(dimV, epsilon)
	#	Computes a gram matrix for the standard quadratic form
	local
		block,		# 2x2 Gram matrix block
		blockmat,	# 2n x 2n Gram matrix
		diagpart;	# Used to create an elliptic form if epsilon is negative

	# Construct a block matrix for the standard hyperbolic form
	block := [[0,0],[1,0]];
	blockmat := BlockMatrix(
					List([1..dimV/2], i -> [i,i,block]),
					dimV/2,dimV/2) * Z(2);

	# Construct a block matrix for the standard elliptic form, if necessary
	if epsilon = 1 then;
		return blockmat;
	elif epsilon = -1 then;
		diagpart := Z(2)*NullMat(dimV, dimV);
		diagpart[1][1] := Z(2);
		diagpart[2][2] := Z(2);
		return blockmat + diagpart;
	else
		Error("Quadratic form must be of type +1 or -1");
	fi;
end;

# Returns the standard nondegenerate epsilon-quadratic form
JCStandardForm := function(dimV, epsilon)
	#	Computes the standard quadratic form
	return QuadraticFormByMatrix(JCStandardGram(dimV, epsilon));
end;

JCSingularVectors := function(phi)
	#	Computes the singular vectors of a form phi
	#	V is undefined right now
	local
		dimV, V;
		dimV := Size(GramMatrix(phi)); # Fix: access from record directly
		V := GF(2)^dimV;
	return Filtered( V, vec -> vec^phi = 0*Z(2));
end;

JCNonsingualrVectors := function(phi)
	#	Computes the singular vectors of a form phi
	#	V is undefined right now
	local
		dimV, V;
		dimV := Size(GramMatrix(phi)); # Fix: access from record directly
		V := GF(2)^dimV;
	return Filtered(V, vec -> vec^phi = Z(2));
end;

JCQuadForms := function(form)
	#	Returns the set of all epsilon-quadratic forms on V which
	#	polarise to a fixed symplectic form

	#   Local variables are dtermined by the input form
	local
		dimV,		# Dimension of V
		V,			# The vector space V(2n,2)
		gram,		# Gram matrix for the given form
		sing,		# Singular vectors of the given form
		Qeps,		# The set of epsilon quadratic forms which polarise to B
		vec;		# Used to construct diagonal matrices

	# Local variables
	gram := GramMatrix(form);
	dimV := Size(gram);
	V := GF(2)^dimV;
	sing := JCSingularVectors(form);

	# The gram matrix for every quadratic form which polarises to B can be
	# expressed as a sum of the gram matrix of the given form
	# and a diagonal matrix
	Qeps := List(sing, vec ->
				QuadraticFormByMatrix(DiagonalMat(vec) + gram));

	return AsSet(Qeps);
end;
