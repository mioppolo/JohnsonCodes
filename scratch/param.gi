# Number of points
jsSize := function(n,e) return 2^(n-1)*(2^n+e); end;

# k for construction 1.2
k1_2 := function(n,d,e,eu) return 2^(n-2)*(2^d+eu)*(2^(n-d)+e*eu); end;

# k for construction 1.3
k1_3 := function(n,d,e,cd)
  if cd = 0 then return 2^(n-1)*(2^(n-d)+e);
  elif cd = 1 then return 2^(2*n-d-1)*(2^d-1);
  else Error("last parameter must be 0 or 1");
  fi;
end;


# Expected parameters for construction 1.2, for (n,d,e,eu)
#
