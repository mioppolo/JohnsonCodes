# JCAffine.gi
# Returns a permutation representation for AGL(n,q) on AG(n,q)

JCAffineGroup := function(n,q)
    local
        V,              # Vector space of dimension n + 1
        hInfBasis,      # Basis for hInf
        hInf,           # Hyperplane at infinity (last coordinate zero)
        affinePts,      # Points of affine geometry
        gl,             # GL(n+1,q)
        agl,            # agl as stabiliser of hInf
        permRep         # Image of permutation rep
        ;

    # Construct the hyperplane at infinity and affine points
    V := GF(q)^(n+1);
    hInfBasis := List([1..n], i -> Z(q)^0*IdentityMat(n+1)[i]);
    hInf := Subspace(V,hInfBasis);
    affinePts := Filtered(V, vec -> not vec[n+1] = 0*Z(q));

    # Construct the affine group as the stabiliser of hInf
    gl := GL(n+1,q);
    agl := Stabiliser(gl,hInf);

    # Construct a permutation representation of agl
    permRep := Action(agl, affinePts);

    return permRep;
end;
