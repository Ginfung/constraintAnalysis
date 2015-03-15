clear all

global totalFeatureNum; %set up the total number of features
global totalLeavesNum;  %set up the total number of leaves, which should be determined
global cost;
global usedbefore;
global defects;

totalFeatureNum = 43;
totalLeavesNum = 28;

cost = rand(1,totalFeatureNum)*10+5; % cost between 5.0 and 15.0
usedbefore = randi([0 1],1,totalFeatureNum); %usedbefore is a binary random variable
defects = rand(1,totalFeatureNum) * 10; %defects between 0 and 10

for i = 1:totalFeatureNum
    if usedbefore(i) == 0
        defects(i) = 0;
    end
end


Problem = @SXFM_web_portal;
NP = 100; % MUAT LARGER THAN OBJECTIVEMIMENSION AND D!
CR = 0.3;
F = 0.3;
gen_max = 500;
D = totalLeavesNum;
ObjectiveDimension = 5;

parent = randi([0 1],NP,D); %initialize in the binary space
f = zeros(NP,ObjectiveDimension);

test = zeros(ObjectiveDimension,gen_max);

%get the objective for initial parent
for i = 1:NP
    f(i,:) = Problem(parent(i,:),D);
end

trial = zeros(1,D);
trial_objective = zeros(1,ObjectiveDimension);

count = 1;
while (count <= gen_max)
    for i = 1:length(f)
        %get distinct a,b,c
        rev = randperm(length(f));
        a = rev(1);
        b = rev(2);
        c = rev(3);
        
        % Mutation begin
        %modified from the idea of continuous differential evaluation
        %!!ALERT: DO NOT take the "amount" of dominance into conderation!!
        for k = 1:D
            if (rand()<CR || k == D)
                if rand() > F
                    trial(k) = parent(a,k);
                else
                    if rand()>0.5
                        trial(k) = parent(b,k);
                    else
                        trial(k) = parent(c,k);
                    end
                end
            else
                trial(k) = parent(i,k);
            end
        end
        %
        trial_objective = Problem(trial,D);
        
        if testDominate(trial_objective,f(i,:),ObjectiveDimension)
            parent(i,:) = trial;
            f(i,:) = trial_objective;
        elseif (~testDominate(f(i,:),trial_objective,ObjectiveDimension)) %indifferent. add to NP
            parent = [parent;trial];
            f = [f;trial_objective];
        end
    end
    if(length(f) > 4*NP) %pruning s.t. size = 4NP-->NP
        rank = fastNonDominatedSort(f,length(f),ObjectiveDimension);
        parent2 = zeros(NP,D);
        f2 = zeros(NP,ObjectiveDimension);
        i = 1;
        renew_count = 0;
        while 1
            qqq = find(rank(:)==i);
            if renew_count+length(qqq) > NP %basing on the distance
                needC = NP-renew_count;
                pool_f = f(qqq,:);
                pool_p = parent(qqq,:);
                I = crowdDistanceAssignment(pool_f,length(qqq),ObjectiveDimension);
                pool_f = [pool_f,I'];
                pool_p = [pool_p,I'];
                sortrows(pool_f,-(ObjectiveDimension+1));
                f2(renew_count+1:NP,:) = pool_f(1:needC,1:ObjectiveDimension);
                sortrows(pool_p,-(D+1));
                parent2(renew_count+1:NP,:) = pool_p(1:needC,1:D);
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
    for i = 1:NP
        f(i,:) = Problem(parent(i,:),D);
    end
    for i = 1:ObjectiveDimension
        test(i,count) = mean(f(:,i));
    end
    count  = count + 1
end

for i = 1:NP
    f(i,:) = Problem(parent(i,:),D);
end


