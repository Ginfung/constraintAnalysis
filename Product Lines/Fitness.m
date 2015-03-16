function [ Fitness ] = Fitness( P,obj )
global k;
global ObjectiveDimension;

sizeofP = size(P,1);
Fitness = zeros(1,sizeofP);

for  i = 1:sizeofP
    for j = 1:sizeofP
        if j == i
            continue;
        end
        indicator = epsAddIndicator(obj(j,:),obj(i,:),ObjectiveDimension);
        Fitness(i) = Fitness(i) -exp(-indicator/k) ;
    end
end
end

