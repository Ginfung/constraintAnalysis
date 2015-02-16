function [ f ] = DTLZ2( x,n )
    k = 10;
    M = 6;
    f = zeros(1,6);
    g=(x(M:n)-0.5*ones(1,k))*(x(M:n)-0.5*ones(1,k))';
    g
    Cos=cos(x(1:M-1)*pi/2);
    f(1) = (1+g)*prod(Cos);
    for i = 1:M-1
        f(i+1) = (f(1)/prod(Cos(M-i:M-1)))*sin(x(M-i)*pi/2);
    end
end

