function g=poly_g(k,h)
%Given h(p) as a polynomial
%Given f(p)=p**k
%compute G(p^2)=h(p)h(-p)+f(p)f(-p)
%find the zeros of G(p^2)
%computes the denominator ploynomial coefficients g(n) in Belevitch sense
%
H=even(h);% H=h(p)h(-p)
n1=length(H);
G=G_poly(k,H);% G(p^2)=g(p)g(-p)=h(p)h(-p)+(-1)^k*p^(2k)
r=zero_even(G);
%Computation of polynomial g from the roots of the even polynomial
z=sqrt(r);
%Compute the first step k=1
n=length(z);
% Initialization of the first loop
             S(1,1)=z(n);
          for j=2:n
            S(1,j)=S(1,(j-1))+z(n-j+1);
          end
          C(n-1)=S(1,n);
%
% Start the second group of loop to compute the normalized coefficients of
% g(p)
  
for i=2:n
  
        for j=1:(n-i+1)
            if j==1
                S(i,j)=z(n-i+1)*S((i-1),j);
                
            end
                        if(j>1)  S(i,j)=S(i,(j-1))+z(n-i-j+2)*S((i-1),j);
                                 C=S(i,j);
                        end
%
        end
 %Define normalized Coefficients with respect to sqrt(H(n))
end
Cnorm=sqrt(abs(G(n1)));        
        for i=1:n
            g(n-i+1)=Cnorm*real(S(i,n-i+1));
        end
        
 g(n1)=Cnorm;
end