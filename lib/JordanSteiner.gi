############################################################################
#          John's method for ordering Quadratic Forms                      #
############################################################################

InstallMethod( \<, "for two forms",
  [IsTrivialForm and IsFormRep, IsTrivialForm and IsFormRep],
  function( a, b )
    return false;
  end );

InstallMethod( \<, "for two forms",
  [IsForm and IsFormRep, IsForm and IsFormRep],
  function( a, b )
    local aa, bb, i;
    if a!.basefield <> b!.basefield then 
       return false;
    fi;
    if a!.type <> b!.type then
       return false;
    fi;
    aa := a!.matrix;
    bb := b!.matrix;
    if Size(aa) <> Size(bb) then 
       return false;
    fi;   
    return aa<bb;
  end );

##########################################################################
#         The Jordan-Steiner actions							         #
##########################################################################

# Input:
#	Quadratic form
#	An isometry of W(2n-1,2)
# Output:
#	New quadratic form
#
# Note:
#	f^g(x) := f(xg^-1) so
#	newgram = g^-T gram g^-1
OnQuadraticForms := function( qform, isom )
  local 
	gram,		# Gram matrix of input form
	x,			# Matrix of isometry (fining & cvec)
	newgram,	# Gram matrix of output form
	field;		# Basefield

	gram := GramMatrix(qform);
	x := Unpack(isom!.mat);
	newgram := TransposedMat(Inverse(x))*gram*Inverse(x);
	field := qform!.basefield;

	return QuadraticFormByMatrix(newgram, field);
end;

# Action on codewords of a Jordan-Steiner code
OnCodewords := function(codeword, isom)
	local qform, newcodeword;
	newcodeword:= List(codeword, qform -> OnQuadraticForms(qform,isom));
return AsSet(newcodeword);
end;

# Permutation representations for the Jordan-steiner actions
JCJordanSteinerPermRep := function(dimV,epsilon)
    local
        form,
        Qeps,
        bil,
        syp,
        permRep         # Image of permutation rep
        ;

    form := JCStandardForm(dimV, epsilon);
    Qeps := JCQuadForms(form);
    bil := BilinearFormByMatrix(GramMatrix(form) + TransposedMat(GramMatrix(form)));
    syp := IsometryGroup(PolarSpace(bil));
    permRep := Action(syp, Qeps, OnQuadraticForms);

    return permRep;
end;
