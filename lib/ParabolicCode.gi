ParabolicCode := function(dimV, dimU, epsilon)
    local
        gram,       # gram matrix for a nodegenerate quadratic form
        form,       # nondegenerate quadratic form with gram matrix gram
        B,          # symplectic form induced by form
        g,          # isometry group of g
        stab,       # stabiliser of a totally isotropic space
        Q,          # quadratic forms which polarise to B
        orbs,       # orbits of stab on Q
        hom_g,      # permutation rep for g
        hom_stab,   # permutation rep for stab
        omega      # underlying set for permutation reps
        ;

    # definitions of quadratic forms
    form := JCStandardForm(dimV, epsilon);
    gram := GramMatrix(form);
    Q := JCQuadForms(form);

    # definitions of groups
    B := BilinearFormByMatrix(gram + TransposedMat(gram), GF(2));
    g := IsometryGroup(PolarSpace(B));
    stab := ParabolicSubgroup(dimV,dimU);

    # action homomorphisms
    hom_g := Image(ActionHomomorphism(g,Q,OnQuadraticForms));
    hom_stab := Image(ActionHomomorphism(stab,Q,OnQuadraticForms));
    omega := MovedPoints(hom_g);

    return InvestigateNeighbourTransitiveCode(hom_g,hom_stab);
end;
