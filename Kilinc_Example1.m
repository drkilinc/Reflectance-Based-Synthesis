% Main Program: Kilinc_Example1.m
clear;clc;close all
f0=1/2/pi;  R0=1;
% Given h(p)=-0.2p^5+0.8p^4-1p^3+0.2p^2-1p-1 and ndc=3.
ndc=3;
h=[-0.2   0.8   -1  0.2 -1    -1    ]; 
%---------------------
%a- Find the realizable strictly Hurwitz polynomial g(p).
    hF=fliplr(h);
    nF=length(hF);
    gF=poly_g(ndc,hF);
    
%b- Find the polynomials a(p) and b(p) for z_in (p)=(a(p))/(b(p))
    g=fliplr(gF);
    a=g+h;
    b=g-h;

%c- Identify the logical values of for the coefficients h_1,g_1,a_1,b_1,
%   h_(n+1),g_(n+1),a_(n+1),b_(n+1) as in Table I and determine the possible
%   synthesis case.

%    'Case 1> a(1)=0,b(1)>0,b(n1)>0: Minimum Reactance Input Impedance F(p)'

%d- Synthesize z_in (p)=(a(p))/(b(p)) and draw the lossless LC-Ladder network
%   in resistive termination.
[ CT CV ] = Synthesis_ImpedanceBased( a,b,R0,f0 );

%-----------------------
