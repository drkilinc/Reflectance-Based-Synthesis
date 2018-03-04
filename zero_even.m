function r=zero_even(x)
%Finds the roots of a given even polynomail
%vector x is the coefficients of the even polynomial
%Q(p)=q(p).q(-p)=X(n+1)P^n+X(n)p^(n-1)+...+X(2)+X(1)
%Mat Lab root function will be used
n1=length(x);
for j=1:n1
    C(j)=x(n1+1-j);
end
    r=roots(C);
end
    