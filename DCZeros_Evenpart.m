function [ ndc] = DCZeros_Evenpart( a,b )
% Given F(p)=a(p)/b(p)as a positive real function
% Find the total number of transmission zeros at DC of S21(p)=p^(ndc)/g(p)
% Here, even if there is a pole at DC in F(p)=a(p)/b(p),it is also counted among the
% transmission zeros at DC. Therefore, in this context, ndc is total number
% of transmission zeros of s21(p)=p^ndc/g(p). 
% The tricky issue is that, in our numerical computations
% A(p^2)=a(p)*b(-p)+a(-p)*b(p) reveals ndc of S21(p) when the position of
% the non-zero term is counted.
%--------------------------------------------------------------------------
% Computation of Numerator of Even Part
    [A,B]=even_part(a,b);
% Here A(p^2)=A(1)p^2n+A(2)p^2(n-1)+...^+A(i)p^2(n+1-i)+...+A(n)p^2+A(n+1)
% Determine the location of non-zero term of A(p^2)
    n_A=length(A);% Notice that n_A=n+1
    AA=abs(A);
    amax=max(AA);
    for i=1:n_A
        if abs(AA(i))==amax
            ndc=n_A-i;% Notice that ndc=n+1-i
        end
    end
    

end

