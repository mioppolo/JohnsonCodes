# Constructs designs related to Gamma(n,d,+,+) or Gamma(n,d,-,-) using group actions
# Codeword is produced naively; might get k or v-k sized codewords
NDDesign := function(dimV, dimU, epsilon)
    local
        gram,       # gram matrix for a seed nodegenerate quadratic form
        form,       # seed nondegenerate quadratic form with gram matrix gram
        B,          # symplectic form induced by form
        g,          # isometry group of g
        stab,       # stabiliser of a nondegenerate subspace
        Q,          # quadratic forms which polarise to B
        orbs,       # orbits of stab on Q
        hom_g,      # permutation rep for g
        hom_stab,   # permutation rep for stab
        omega,      # underlying set for permutation reps
        orb,        # orbit
        codeword,   # codeword
        code,     # codewords
        des       # Design
        ;

    # definitions of quadratic forms
    form := JCStandardForm(dimV, epsilon);
    gram := GramMatrix(form);
    Q := JCQuadForms(form);

    # definitions of groups
    B := BilinearFormByMatrix(gram + TransposedMat(gram), GF(2));
    g := IsometryGroup(PolarSpace(B));
    stab := NDSubgroup(dimV,dimU);

    # action homomorphisms
    hom_g := Image(ActionHomomorphism(g,Q,OnQuadraticForms));
    hom_stab := Image(ActionHomomorphism(stab,Q,OnQuadraticForms));
    omega := MovedPoints(hom_g);

    # Naively construct a codeword using a unknown seed, return design
    codeword := Orbit(hom_stab,1);
    code := Orbit(hom_g,codeword,OnSets);
    des := DesignFromPointsAndBlocks(omega, code);
    return des;
end;
