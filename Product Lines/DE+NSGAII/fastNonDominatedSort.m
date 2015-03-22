%Sorting the population
%Based on DEB et al.: A FAST AND ELITIST MULTIOBJECTIVE GA: NSGA-II
function [rank] = fastNonDominatedSort( P, size, ObjectiveDimension )
n = zeros(1,size);
S = ones(size,size);
S = S.*-1;
rank = ones(1,size);
rank = rank.*-1;
for p = 1:size
    for q = 1:size
        if testDominate(P(p,:),P(q,:),ObjectiveDimension)
            %record the index q in to S_p
            x = 1;
            while(S(p,x)>0)
                x = x+1;
            end
            S(p,x) = q;
            %===end of recording===
        else
            if testDominate(P(q,:),P(p,:),ObjectiveDimension)
                n(p) = n(p)+1;
            end
        end
    end
    if n(p) == 0
        rank(p)=1;
    end
end
i = 1;
M = max(n);
while i <= M
    for t = 1:size
        if(rank(t) == i)
            for u = 1:size
                if S(t,u)>0
                    n(S(t,u)) = n(S(t,u))-1;
                    if n(S(t,u)) == 0
                        rank(S(t,u)) = i+1;
                    end
                end
            end
        end
    end
    i = i+1;
end
end