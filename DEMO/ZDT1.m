function [ f ] = ZDT1( x,n )
f = zeros(1,2);
f(1) = x(1);
g = 1 + 9*(sum(x)-x(1))/(n-1);
f(2) = g*(1-sqrt(x(1)/g));
end

