# Print Tables of codes

# Read all the necessary libraries
Read("/home/mark/Dropbox/Code/JordanSteiner/read.g");

for n in [1..3] do;
    for epsilon in [1,-1] do;


        dimV := 2*n;;
        gram := Phi0Gram(dimV, epsilon);;
        form := QuadraticFormByMatrix(gram);; # just use forms here

        B := BilinearFormByMatrix(gram + TransposedMat(gram), GF(2));;
        g := IsometryGroup(PolarSpace(B));;

        Q := QuadForms(form);;

        gg := PermutationRep(g, Q, OnQuadraticForms);;

        anal := AnalyseGroup2(gg, fail);;		# Fail instead of atlas name



        for examp in anal do;
            AppendTo("/home/mark/dim8.gap", 
                n, " ",
                epsilon, " ",
                examp.k, " ",
                examp.domainsize, " ",
                Size(examp.m), " ",
		        Size(examp.g), " ",
                examp.codesize, " ",
                examp.mindist, "\n" );
        od;



    od; # Close the episolon for loop
od; # Close the dimV/2 for loop
