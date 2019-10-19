# Read all the necessary libraries
Read("/home/mark/Dropbox/Research/code/JordanSteiner/read.g");

##### Sp(6,2) on 28 points (Elliptic)
elliptic_generators := [(2,3)(6,7)(9,10)(12,14)(17,19)(20,22), (1,2,3,4,5,6,8)(7,9,11,13,16,18,14)(10,12,15,17,20,19,21)(22,23,24,25,26,27,28)];;
esp := Group(elliptic_generators);;
e_anal := AnalyseGroup2(esp, fail);

for examp in e_anal do;
    summary(examp);
    od;

##### Sp(6,2) on 36 points (Hyperbolic)
hyperbolic_generators := [(1,2)(4,6)(8,11)(9,13)(15,18)(16,20)(17,21)(26,29)(27,31)(28,33), (1,3,5,8,12,17,22)(2,4,7,10,15,11,16)(6,9,14,19,24,27,32)(13,18,23,26,30,34,36)(20,25,28,31,29,33,35)];
hsp := Group(hyperbolic_generators);;
h_anal := AnalyseGroup2(hsp, fail);

for examp in h_anal do;
    summary(examp);
    od;



########### Output for later
for examp in e_anal do;
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
