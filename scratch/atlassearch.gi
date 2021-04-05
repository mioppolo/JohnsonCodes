# This session is saved as ListedTables

# Be careful about n=2,eps=- : you need to select the right 6 point action!

LoadPackage("JohnsonCodes");

# We start with some helper functions
nam := function(n) return Concatenation("S",String(2*n),"(2)"); end;
jsSize := function(n,e) return 2^(n-1)*(2^n+e); end;
jsDisplay := function(n,e) DisplayAtlasInfo(nam(n),NrMovedPoints,jsSize(n,e)); end;
jsGrp := function(n,e) return AtlasGroup(nam(n),NrMovedPoints,jsSize(n,e));end;

AnalCase := function(n,e)
  local results, cr;
  results := AnalyseGroup2(jsGrp(n,e),fail);;
  Print("Case summary: n = ", n, "\t eps = ", e, "\t v = ", results[1].domainsize, "\n");
  Print("k\t", "minDis\t", "numCodewords\n");
  for cr in results do
    Print(cr.k, "\t", cr.mindist, "\t", cr.codesize, "\n");
  od;
  return results;
end;



# Create records to store in GAP sessions. Naming: cne with n and e the parameters, p = plus, m=minus
# Eg: c4p is the record of codes arising from the 4d JS actions of plus type
c2p := AnalCase(2,1);
c3p := AnalCase(3,1);
c3m := AnalCase(3,-1);
c4p := AnalCase(4,1);
c4m := AnalCase(4,-1);
c5p := AnalCase(5,1);
c5m := AnalCase(5,-1);
c6p := AnalCase(6,1);
c6m := AnalCase(6,-1);












# For n = 2, e = -
g1 := AtlasGroup("S4(2)",Position,1);
g2 := AtlasGroup("S4(2)",Position,2);
anal1 := AnalyseGroup2(g1,fail);
anal2 := AnalyseGroup2(g2,fail);

Print("Case summary: n = ", 2, "\t eps = ", -1, "\t v = ", 6, "\n");
Print("k\t", "minDis\t", "numCodewords\n");
for cr in anal2 do
  Print(cr.k, "\t", cr.mindist, "\t", cr.codesize, "\n");
od;
