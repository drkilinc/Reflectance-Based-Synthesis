function B=fullvector_topdown(n,A)
na=length(A);
for i=1:na
    B(i)=A(i);
end
for i=1:(n-na)
        B(na+i)=0;
end
