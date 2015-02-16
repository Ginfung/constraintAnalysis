function [ I ] = crowdDistanceAssignment( f,size,ObjectiveDimension )
    I = zeros(1,size);
    for m = 1:ObjectiveDimension %for each objective
        temp = [f(:,m),[1:size]'];
        temp = sortrows(temp,1);
        I(temp(1,2)) = inf;
        I(temp(size,2)) = inf;
        fmin = min(temp(:,1));
        fmax = max(temp(:,1));
        for i = 2:size-1
            I(temp(i,2)) = I(temp(i,2))+(temp(i+1,1)-temp(i-1,1))/(fmax-fmin);
        end
    end
end

