function [ f ] = DTLZ1(x,n)
M = 3; %Here can set up the M
k = 5; %Let k = 5, as suggested. Thus n should be 8
%get g
sum = 0;
for i = M:M+k-1
    sum = sum + ((x(i)-0.5)^2-cos(20*pi*(x(i)-0.5)));
end
g = 100 * (k + sum);
%get f
f = zeros(1,M);
f(M) = 0.5*(1+g);
for i = M-1:-1:1
    f(i) = f(i+1)*x(M-i);
end
for i = 2:M
    f(i) = f(i) * (1 - x(M+1-i));
end

end

