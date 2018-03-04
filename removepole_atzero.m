function [k0,R,br] = removepole_atzero(a,b)
% This function removes the pole at DC  from a given F(p)=a(p)/[p*br(p)]
% Given F(p)=a(p)/b(p)=a(p)/[p*br(p)]=k0/p+R(p)/br(p)
   [k0,R,br]=Highpass_Remainder(b,a);
end

