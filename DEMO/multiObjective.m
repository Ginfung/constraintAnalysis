%trial version for multi objective
%modified based on DEB et al.: A fast and elitist multiobjective GA:NSGA-II
clear all
Problem = @DTLZ1;
NP = 30; % MUAT LARGER THAN OBJECTIVEMIMENSION AND D!
CR = 0.45;
F = 0.3;
gen_max = 200;
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
        rev = randperm(NP);
        a = rev(1);
        b = rev(2);
        c = rev(3);

        mutant = parent(c,:) + F*(parent(a,:)-parent(b,:));
        for k = 1:D
            if (rand()<CR || k == D)
                trial(k) = mutant(k);
                if trial(k) < domain_a
                    trial(k) = (parent(i,k)+domain_a)/2;
                end
                if trial(k) > domain_b
                    trial(k) = domain_a+(domain_b-parent(i,k))/2;
                end
            else
                trial(k) = parent(i,k);
            end
        end
        
        trial_objective = Problem(trial,D);
        
        if testDominate(trial_objective,f(i,:),ObjectiveDimension)
            parent(i,:) = trial;
            f(i,:) = trial_objective;
        elseif (~testDominate(f(i,:),trial_objective,ObjectiveDimension)) %indifferent. add to NP    
                parent = [parent;trial];
                f = [f;trial_objective];
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
   count = count + 1;
end

for i = 1:NP
    f(i,:) = Problem(parent(i,:),D);
end



