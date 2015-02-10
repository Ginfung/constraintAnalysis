function [ f ] = Fonseca( x,n )
f = zeros(1,2);
qq = 1/sqrt(n);
sum = 0;
for i = 1:n
    sum = sum + (x(i)-qq)^2;
end
f(1) = 1 - exp(-sum);
sum = 0;
for i = 1:n
    sum = sum + (x(i)+qq)^2;
end
f(2) = 1 - exp(-sum);
end

