# Constructs the code Gam(n,d,e,e')
# Codewords are nondegenerate subspaces of dimension 2d in V(2n,2)
# A quadratic form is incident with a nd-space iff restriction has type e'
# e' is determined by the use of JCStandardForm and choice of subspace NDSubgroup
# Hyperbolic: phi = x1y1 + x2y2 + ... + xnyn
# Elliptic:   phi = x1y1 + x2y2 + ... + xnyn + x1^2 + y1^2
# U: <e1,f1,e2,f2,...,ed,fd>
# Therefore, Gam(n,d,+,+) and Gam(n,d,-,-) are produced
NDCode := function(dimV, dimU, epsilon)
    local
        gram,       # gram matrix for a nodegenerate quadratic form
        form,       # nondegenerate quadratic form with gram matrix gram
        B,          # symplectic form induced by form
        g,          # isometry group of g
        stab,       # stabiliser of a nondegenerate space
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
    stab := NDSubgroup(dimV,dimU);

    # action homomorphisms
    hom_g := Image(ActionHomomorphism(g,Q,OnQuadraticForms));
    hom_stab := Image(ActionHomomorphism(stab,Q,OnQuadraticForms));
    omega := MovedPoints(hom_g);

    return InvestigateNeighbourTransitiveCode(hom_g,hom_stab);
end;
