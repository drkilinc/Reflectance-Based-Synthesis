% Program Main_SParBasedSynthesis.m 
% This program tests the sacattring parameters based synthesis
clc
clear
close all
f0=1/2/pi;  R0=1;
format short

h=input(' Enter coefficients of h(p) in MatLab Format: h=[...]=')
ndc=input(' Enter transmission zeros of the lossless LC ladder at DC ndc=')

%--------------------------------------------------------------------------
% Swap h(p)as a text book polynomial vector in hF(p)=hF0+hF1p+hF2p^2+...+hFnp^n
nF=length(h);
for i=1:nF
hF(i)=h(nF-i+1);
end
% Generate gF as a text book polynomial:gF(p)=gF0+gF1p+gF2p^2+...+gFnp^n
    gF=poly_g(ndc,hF)
% Generate standard MatLab polynomial g(p):
for i=1:nF
g(i)=gF(nF-i+1);
end
% Computation of the actual element values of the lossless LC Ladder       
    a=g+h;
    b=g-h;
%Swap a(p) and b(p) to end up with standard MatLab Polynomials
%
%----------------------------------------------------
[ CT CV ] = Synthesis_ImpedanceBased( a,b,R0,f0 );
%--------------------------------------------------------------------------
format short
