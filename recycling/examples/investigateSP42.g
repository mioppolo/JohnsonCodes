# Read all the necessary libraries
Read("/home/mark/Dropbox/Code/JordanSteiner/read.g");

dimV := 4;;
epsilon := 1;;
gram := Phi0Gram(dimV, epsilon);;
form := QuadraticFormByMatrix(gram);; # just use forms here
B := BilinearFormByMatrix(gram + TransposedMat(gram), GF(2));
g := IsometryGroup(PolarSpace(B));
Q := QuadForms(form);
gg := PermutationRep(g, Q, OnQuadraticForms);
# Analysis
anal := AnalyseGroup2(gg, fail);		# Fail instead of atlas name
# Print results
for examp in anal do
    summary(anal);
od;
