function G=G_poly(k,H)
%This function computes the coefficients of the even G polynomial.
%G(-p2)=g(p)g(-p)=h(p)h(-p)+f(p)f(-p)=H(-p2)+p**(2k)
%Here k=0 corresponds to no zero of transmission at DC
% H(p^2) is not a standard MatLab Polynomial rather it is Hn1*p^2(n)+H(n-1)*p^2(n-2)+...+H2*P^2+H1
% Notice that n1=n+1; where n is the degree of polynomial h(p)
n1=length(H);
for j=1:n1
    G(j)=H(j);
end
    G(k+1)=H(k+1)+(-1)^k;
if k==n1-1;G(n1)=H(n1)+(-1)^k;end
end
