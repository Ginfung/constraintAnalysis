function [ f ] = DTLZ1(x,n)
M = 3; %Here can set up the M
k = 5; %Let k = 5, as suggested. Thus n should be 8
%get g
temp = (x(M:M+k-1)-0.5).*(x(M:M+k-1)-0.5) - cos(20*pi*(x(M:M+k-1)-0.5));
g = 100*(k+sum(temp));
g
%g = 0;
%get f
f = zeros(1,M);
for i = 1:M-1
    f(i) = 0.5*prod(x(1:M-i))*(1+g);
end
f(M) = 0.5*(1-x(1))*(1+g);
end

