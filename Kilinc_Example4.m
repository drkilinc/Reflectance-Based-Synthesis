% Main Program: Kilinc_Example2.m
clear;clc;close all
f0=1/2/pi; R0=1;

%
% Example 4.
% Let h=[-1 2 3 4 5 6 7 8] with ndc=5.
% 	Find the realizable strictly Hurwitz polynomial g(p).
% 	Find the polynomials a(p) and b(p) for z_in (p)=(a(p))/(b(p))
% 	Identify the logical values of for the coefficients h_1,g_1,a_1,b_1,h_(n+1),g_(n+1),a_(n+1),b_(n+1) as in Table I and determine the possible synthesis case.
% 	Synthesize z_in (p)=(a(p))/(b(p)) and draw the lossless LC-Ladder network in resistive termination
%

h = [ -1   2   3   4   5   6   7   8];
ndc=5;

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

%    Case 4> a(1)=0,b(1)>0,b(n1)=0: F(p) has a pole at p=0

%d- Synthesize z_in (p)=(a(p))/(b(p)) and draw the lossless LC-Ladder network
%   in resistive termination.
[ CT CV ] = Synthesis_ImpedanceBased( a,b,R0,f0 );

%-----------------------
