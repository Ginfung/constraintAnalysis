function [ f ] = SXFM_e1( x,n)
    f = zeros(1,2);
    C = zeros(1,5);
    g = zeros(1,2);
    %%set groups
    g(1) = x(6)+x(7)+x(8)>=1;
    g(2) = x(9)+x(10)==1;
    %%constraints
    C(1) = x(4)==g(1);
    C(2) = x(5)==g(2);
    C(3) = x(1)==x(2)&x(4);
    C(4) = ~x(3)|~x(6);
    C(5) = ~x(8)|x(9);
    %%objectives
    f(1) = n - sum(x);
    f(2) = length(C)-sum(C);
end

