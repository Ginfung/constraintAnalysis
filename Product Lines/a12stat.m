function [ a12 ] = a12stat( lst1,lst2 )
% Return how often we seen larger numbers in X than Y
% Reference: Vargha, András, and Harold D. Delaney. "A critique and improvement 
% of the CL common language effect size statistics of McGraw and Wong." 
% Journal of Educational and Behavioral Statistics 25.2 (2000): 101-132.
more = 0;
same = 0;
lst1 = sort(lst1);
lst2 = sort(lst2);
for x = 1:length(lst1)
    for y = 1:length(lst2)
        if lst1(x) == lst2(y)
            same = same+1;
        else if lst1(x) > lst2(y)
                more = more+1;
            end
        end
    end
end
a12 = (more+0.5*same)/(length(lst1)*length(lst2));
end