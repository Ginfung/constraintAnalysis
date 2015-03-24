function [ f ] = SXFM_web_portal_4obj( x,n )
global ori_Problem;
q = ori_Problem(x,n);
f = zeros(1,4);
f(1) = q(4);
f(2) = q(5);
f(3) = q(1);
f(4) = q(2);
end

