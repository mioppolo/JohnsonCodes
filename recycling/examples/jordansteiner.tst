dimV := 6;;
epsilon := 1;;
gram := Phi0Gram(dimV,epsilon);;
form := QuadraticFormByMatrix(gram);; # just use forms here

Display(gram);
Display(form);

sing := Sing(form);;
Print("Checking if Sing has the correct size");
Size(sing) = 2^(dimV/2-1)*(2^(dimV/2) + epsilon);

nsing := NSing(form);;
Print("Checking if Sing has the correct size");
Size(nsing) = 2^(dimV/2-1)*(2^(dimV/2) - epsilon);

B := BilinearFormByMatrix(gram + TransposedMat(gram), GF(2));
g := IsometryGroup(PolarSpace(B));

Q := QuadForms(form);
IsTransitive(g,Q,OnQuadraticForms);
