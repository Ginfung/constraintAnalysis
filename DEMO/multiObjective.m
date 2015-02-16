%trial version for multi objective
%modified based on DEB et al.: A fast and elitist multiobjective GA:NSGA-II
clear all
Problem = @DTLZ1;
NP = 80; % MUAT LARGER THAN OBJECTIVEMIMENSION AND D!
CR = 0.3;
F = 0.3;
gen_max = 10;
D = 7;
ObjectiveDimension = 3;
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
               % trial(j) = mod(trial(j),1);
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
    if(length(f)>NP) %pruning
        rank = fastNonDominatedSort(f,length(f),ObjectiveDimension);
        I = crowdDistanceAssignment(f,length(f),ObjectiveDimension);
        parent2 = zeros(NP,D);
        f2 = zeros(NP,ObjectiveDimension);
        i = 1;
        renew_count = 0;
        while 1
            qqq = find(rank(:)==i);
            if renew_count+length(qqq) > NP %basing on the distance
                needC = (1:NP-renew_count);
                alpha = sortrows([I(qqq);1:length(qqq)']',-1);
                alpha = alpha(needC,2);
                parent2(renew_count+1:NP,:) = parent(alpha,:);
                f2(renew_count+1:NP,:) = f(alpha,:);
                f = f2;
                parent = parent2;
               break;
            end
            parent2(renew_count+1:renew_count+length(qqq),:) = parent(qqq,:);
            f2(renew_count+1:renew_count+length(qqq),:) = f(qqq,:);
            renew_count = renew_count+length(qqq);
            i = i+1;
        end
        
    end
    count  = count + 1
end

for i = 1:NP
    f(i,:) = Problem(parent(i,:),D);
end



