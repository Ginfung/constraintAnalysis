function [ result ] = testDominate( x,y,n )
mm = 1; %whether all of objective in x and no worse than that of y
nn = 0; %whether exist one objective, st. obj(x) is better than that of y

for i = 1:n
    if x(i) > y(i)
        mm = 0;
        break;
    end
end

for i = 1:n
    if x(i) < y(i)
        nn = 1;
        break;
    end
end

result = mm && nn;
end

