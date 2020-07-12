syms a b f;
term1 = -3*a*a+2*b*a*1i+2-f;
term2 = -a*a+1-f+b*a*1i;
term3 = a*a-b*a*1i-1;
expand(term1*term2-term3*term3)