####NORMALFORM CVECS

cVec := function( qform )
  local gram, vec;
  gram := GramMatrix(qform);
  vec:=[gram[2][2],gram[1][1],gram[4][4],gram[3][3],gram[6][6],gram[5][5],gram[8][8],gram[7][7]]*Z(2);
  return vec;
end;

### Requires cVec
cVector := function( qform, qform0 )
local vec;
  vec:= cVec(qform) + cVec(qform0);
  return vec;
end;



ParamVector := function(form1, form2)
	local
		gram1,
		gram2;

	gram1 := GramMatrix(form1);
	gram2 := GramMatrix(form2);

	vec:=[gram[2][2],gram[1][1],gram[4][4],gram[3][3],gram[6][6],gram[5][5],gram[8][8],gram[7][7]]*Z(2);

	return vec;
end;
