function [ f ] = SXFM_web_protal_2obj( x,n )
ff = SXFM_web_portal(x,n);
f(1) = ff(4);
f(2) = ff(5);
end

