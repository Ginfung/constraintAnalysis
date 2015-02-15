%trial version for multi objective
%modified based on DEB et al.: A fast and elitist multiobjective GA:NSGA-II
clear all
Problem = @Fonseca;
NP = 50;
CR = 0.3;
F = 0.3;
gen_max = 100;
D = 3;
ObjectiveDimension = 2;
domain_a = 0;
domain_b = 1;

parent = rand(NP,D)*(domain_b-domain_a)+domain_a; %initial population. x in [?,?]
f = zeros(NP,ObjectiveDimension);

%get the objective for initial parent
for i = 1:NP
    f(i,:) = Problem(parent(i,:),D);
end

trial = zeros(1,D);
trial_objective = zeros(1,ObjectiveDimension);

count = 1;
while (count <= gen_max)
    for i = 1:NP
        %get distinct a,b,c
        while (1)
            a = randi(NP);
            if a ~=  i
                break;
            end
        end
        while (1)
            b = randi(NP);
            if b~= i && b ~= a
                break;
            end
        end
        while(1)
            c = randi(NP);
            if (c~= i) && (c ~= a) && (c~= b)
                break;
            end
        end
        
        j = randi(D); 
        
        for k = 1:D
            if (rand()<CR || k == D)
                trial(j) = parent(c,j) + F*(parent(a,j)-parent(b,j));
            else
                trial(j) = parent(i,j);
            end
            j = j+1;
            if j>D
                j=1;
            end 
        end
        
        trial_objective = Problem(trial,D);
        
        if testDominate(trial_objective,f(i,:),ObjectiveDimension)
            parent(i,:) = trial;
            f(i,:) = trial_objective;
        else
            if (~testDominate(f(i,:),trial_objective,ObjectiveDimension)) %indifferent. add to NP
                parent = [parent;trial];
                f = [f;trial_objective];
            end
        end         
    end
    %TODO sort the f, s.t. length(parent or f) equals to NP
    
    count  = count + 1;
end

for i = 1:NP
    f(i,:) = Problem(parent(i,:),D);
end

