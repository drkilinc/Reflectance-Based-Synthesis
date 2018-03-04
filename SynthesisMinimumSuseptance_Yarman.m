function [CT,CV] = SynthesisMinimumSuseptance_Yarman(R0,f0,a,b,ndc)
% Minimum Suseptance Case
% This function generates the circuit code vector for a given Component matrix
% CVal(i,j) describes the rows and columns of CVal in actual element values
% -------------------------------------------------------------------------
% Series Capacitors(CHP)    Shunt Inductors(LHP)      Shunt Capacitors(CLP)    Series Inductors(LLP)        Termination
% -------------------------------------------------------------------------
% j=1> First Column of CVal gives the the series capacitors C_HP; CT=2
% j=2> Second Column of CVal gives the shunt inductors L_HP; CT=7
% j=3> Third Column of CVal(:;3) gives the shunt capacitors C_LP; CT=8
% j=4> Fourth Column of CVal(:;4) gives the series inductors L_LP; CT=1
% j=5> First Row (i=1) and Fitfh Column (j=5) gives the termination Ter=9
% -------------------------------------------------------------------------
nb=length(b);% Total number elements with termination 
nL=nb-1-ndc;% Total number of lowpass elements (q)
% Step 1; Generate CVal which is the matrix consist of actual element
%--------------------------------------------------------------------------
% Case B: Minimum Reactance Design
% 
KFlag=0; % Minimum Reactance Design start with shunt inductor j=2
             % Start with 1=1, j=2 then go to C(2,1).
             % Notice that here, inductors are odd rows, capacitors are even rows.  
% -------------------------------------------------------------------------
% values:
[A,CVal] = LadderSysnthesis_BSYarman( KFlag,R0,f0,ndc,a,b ); 

%             Extraction of Actual Highpass Elements
% For inductors use odd values of CT; for capacirors use even values of CT
%--------------------------------------------------------------------------
% j=1; % extraction starts with a series capacitor (CT=2); first column of CVal
% Extraction of Highpass Elements
if ndc==1; CT(1)=2; CV(1)=CVal(1,1);% First element is a series capacitor
    if ndc==nb-1;CT(2)=9;G=1/R0; G1=G*a(1)/b(1); CV(2)=1/G1;end;% Here, however, termination is given as a resistor in ohms
end
if ndc>1
    k=even_odd(ndc); 
  if k==0; % ndc=even case
    for i=1:ndc/2
        CT(2*i-1)=2;% Start with a series highpass capacitor C_HP
        CV(2*i-1)=CVal(2*i-1,1);% Value of the series capacitor
        CT(2*i)=7;% Second element is a shunt inductor (CT=7)
        CV(2*i)=CVal(2*i,2);% Value of the shunt inductor
    end
 
    if (ndc==nb-1);CT(ndc+1)=9; G=1/R0;G1=G*a(1)/b(1);CV(ndc+1)=1/G1;end; % Termination is conductor but we use Resistor in ohms
  end
  if k==1; % ndc=odd case
 %    
     for i=1:(ndc-1)/2+1
        CT(2*i-1)=2;% Start with a highpass series capacitor C_HP
        CV(2*i-1)=CVal(2*i-1,1);% Value of the shunt inductor
        if (2*i)<ndc
        CT(2*i)=7;% Second element is a shunt inductor 
        CV(2*i)=CVal(2*i,2);% Value of the shunt inductor
        end
     end
%
      if ndc==1; CT(1)=2; CV(1)=CVal(1,1);end;% First element is a series capacitor
 if (ndc==nb-1);CT(ndc+1)=9; G=1/R0;G1=G*a(1)/b(1);CV(ndc+1)=1/G1;end; % Termination is conductor but we use Resistor in ohms
  end
end
%
% End of extraction of highpass elements.
%
% KFlag is zero and ndc is greater than zero: extraction of lowpass elements
        %j=4;% extraction starts with a series inductor CT=1
        if nL==1;
            CT(ndc+1)=1; CV(ndc+1)=CVal(1,4);
            CT(ndc+2)=9; CV(ndc+2)=CVal(1,5);
        end; % Here CV(ndc+2) is a resistor in ohms. 
        if nL>1
            k=even_odd(nL); 
          if k==0; % nL=even case
            for i=1:nL/2
                CT(ndc+2*i-1)=1;% First Lowpass element is a series inductor
                CV(ndc+2*i-1)=CVal(2*i-1,4);% Value of the series inductor 
                %
                CT(ndc+2*i)=8; % Code of a shunt capacitor
                CV(ndc+2*i)=CVal(2*i,3);% Value of the shunt capacitor 
                
            end
            % Extract of the termination
            CT(ndc+nL+1)=9;R=CVal(1,5);
            CV(ndc+nL+1)=R;% Termination is always given as a resistor in ohms
          end
           if k==1; % nL=odd case
            for i=1:(nL-1)/2+1
                CT(ndc+2*i-1)=1;% First Lowpass element is a series inductor
                CV(ndc+2*i-1)=CVal(2*i-1,4);% Value of the series inductor
                if (2*i)<nL
                CT(ndc+2*i)=8; % Code of a shunt capacitor
                CV(ndc+2*i)=CVal(2*i,3);% Value of the series inductor
                end
            end
            % Extract the termination
            CT(ndc+nL+1)=9;R=CVal(1,5);
            CV(ndc+nL+1)=R;% Termination is always given as a resistor in ohm
           end
          
        end
     %Plot_Circuitv1(CT,CV)   
     
end



