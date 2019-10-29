form := JCStandardForm(6,1);
gram := GramMatrix(form);
syp := BilinearFormByMatrix(gram + TransposedMat(gram));
Display(syp);
w := PolarSpace(syp);
g := IsometryGroup(w);
bigQ := Orbit(g,form,OnQuadraticForms);


s := SylowSubgroup(g,2);
OrbitLengths(s,bigQ,OnQuadraticForms);
