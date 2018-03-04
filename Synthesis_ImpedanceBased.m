function [ CT CV ] = Synthesis_ImpedanceBased( a,b,R0,f0 )
% This function completes the impedance based synthesis
%   F(p)=a(p)/b(p) is an impedance.
n1=length(a);zero=1e-12;norma=norm(a);normb=norm(b);
%--------------------------------------------------------------------------
% Case 1:a(1)=0,b(1)>0. Then, F(p) is a minimum
% reactance function. Therefore we set KFlag=1.
[ ndc] = DCZeros_Evenpart( a,b )
if abs(a(1))/norma<=zero   
        if abs(b(1))/normb>zero
            if abs(b(n1))/normb>zero
                KFlag=1;
                
                [CT,CV] = CircuitPlot_Yarman(KFlag,R0,f0,a,b,ndc);
Case='Case 1> a(1)=0,b(1)>0,b(n1)>0: Minimum Reactance Input Impedance F(p)'
            end
        end  
end
%End of Case 1
%--------------------------------------------------------------------------
% Case 2:a(1)>0, or b(1)=0, b(n1)=0. Then, F(p) is a minimum
% suseptance function. Therefore we set KFlag=0 and flip over
% F(p) as H(p)=b(p)/a(p)=1/F(p).
if abs(a(1))/norma>zero
        if abs(b(1))/normb<=zero
            if abs(b(n1))/normb<=zero
                KFlag=0;
                %[ ndc] = DCZeros_Evenpart( b,a )
                [CT,CV] = CircuitPlot_Yarman(KFlag,R0,f0,b,a,ndc);
Case='Case 2> a(1)>0,b(1)=0,b(n1)=0: Minimum Suseptance Input Impedance F(p)'
            end
        end
end
%End of Case 2
%--------------------------------------------------------------------------
% Case 3:a(1)>0, b(1)=0, b(n1)>0. Then, F(p) is not a minimum
%  reactance. It has a pole only at infinity. Therefore, we extract the
%  pole.
if abs(a(1))/norma>zero
        if abs(b(1))/normb<=zero
            if abs(b(n1))/normb>zero
                [L0,a1,b1]=removepole_atinfinity(a,b);
                L_Act=L0*R0/2/pi/f0;
                KFlag=1;
                %[ ndc] = DCZeros_Evenpart( a1,b1 )
                [CT,CV] = CircuitPlot_Yarman(KFlag,R0,f0,a1,b1,ndc);
                CT=[1 CT]; CV=[L_Act CV];
Case='Case 3> a(1)>0,b(1)=0,b(n1)>0: F(p) has a pole at infinity'
            end  
        end
end
%End of Case 3
%--------------------------------------------------------------------------
% Case 4:a(1)=0, or b(1)>0, b(n1)=0. Then, F(p) is not a minimum
%  reactance function. It has pole at p=0. Therefore, we extract the
%  pole at p=0.
if abs(a(1))/norma<=zero
        if abs(b(1))/normb>zero
            if abs(b(n1))/normb<=zero
                [C0,a1,b1]=removepole_atzero(a,b);
                C_Act=C0/R0/2/pi/f0;
                KFlag=1;
                ndc1=ndc-1;
                %[ ndc1] = DCZeros_Evenpart( a1,b1 )
                [CT,CV] = CircuitPlot_Yarman(KFlag,R0,f0,a1,b1,ndc1);
                CT=[2 CT]; CV=[C_Act CV];
Case='Case 4> a(1)=0,b(1)>0,b(n1)=0: F(p) has a pole at p=0'

            end  
        end
end
%End of Case 4
%--------------------------------------------------------------------------
% Case 5:F(p)>Highpass Circuit Structure as a minimum suseptance function
if abs(a(1))>zero
    if abs(b(1))>zero
        if abs(b(n1))/normb<=zero
            KFlag=0;
            %[ ndc] = DCZeros_Evenpart( b,a )
            [CT,CV] = CircuitPlot_Yarman(KFlag,R0,f0,b,a,ndc);                
Case='Case 5> a(1)>0,b(1)>0,b(n1)=0: Highpass F(p) as Minimum Suseptance'
        end
    end
end
% End of Case 5
%--------------------------------------------------------------------------
% Case 6:F(p)> Highpass Circuit Structure as a minimum reactance function
if abs(a(1))>zero
    if abs(b(1))>zero
        if abs(a(n1))/norma<=zero
            KFlag=1;
            %[ ndc] = DCZeros_Evenpart( a,b )
            [CT,CV] = CircuitPlot_Yarman(KFlag,R0,f0,a,b,ndc);                
Case='Case 6> a(1)=0,b(1)>0,a(n1)=0: Highpass F(p) as Minimum Reactance'
        end
    end
end
% End of Case 6
%--------------------------------------------------------------------------
Plot_Circuitv1(CT,CV);
end
%End of function