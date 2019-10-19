dimV := 4;;

m := dimV + 2;

generators := FullyDeletedPermutationRep(dimV+2, GF(2));

B := Representative(
		PreservedSesquilinearForms(Group(generators))
		);

generators := List( generators,
					gen -> CollineationOfProjectiveSpace(gen, GF(2)));

g := IsometryGroup(PolarSpace(B));	# Symplectic group
s := Group(generators);				# Symmetric group
a := DerivedSubgroup(s);			# Alternating group	

# Plus type quadratic form
form := QuadraticFormByMatrix(AltGram(dimV));
Qepsilon := QuadForms(form);
omega := [1..Size(Qepsilon)];

ss := PermutationRep(s, Qepsilon, OnQuadraticForms);
aa := PermutationRep(s, Qepsilon, OnQuadraticForms);
