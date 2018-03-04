function H=even(h)
%given coefficients of h(p) polynomial;
%Compute H(-P^2)
%
n=length(h);
sigma=-1;
    for k=1:n
        sigma=-sigma;
        mu=-1;
        sum=0;
     for j=1:(k-1)
            mu=-mu;
        if((2*k-j)<=n)sum=sum+2*mu*h(j)*h(2*k-j);
        end
     end
        H(k)=sigma*h(k)*h(k)+sum;
    end
end