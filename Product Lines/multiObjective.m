function [parent, f, evoluationRecord] = multiObjective(gen_max)

global totalLeavesNum;  %set up the total number of leaves, which should be determined
global Problem;
global ObjectiveDimension;

NP = 100; % MUAT LARGER THAN OBJECTIVEMIMENSION AND D!
CR = 0.3;
F = 0.3;
D = totalLeavesNum;

parent = randi([0 1],NP,D); %initialize in the binary space
f = zeros(NP,ObjectiveDimension);

evoluationRecord = zeros(ObjectiveDimension,gen_max);

%get the objective for initial parent
for i = 1:NP
    f(i,:) = Problem(parent(i,:),D);
end

trial = zeros(1,D);
trial_objective = zeros(1,ObjectiveDimension);

gen = 1;
while (gen <= gen_max)
    gen
    for i = 1:length(f)
        %get distinct a,b,c
        rev = randperm(length(f));
        a = rev(1);
        b = rev(2);
        c = rev(3);
        
        %% Mutation begin
        %modified from the idea of continuous differential evaluation
        %!!ALERT: DO NOT take the "amount" of dominance into conderation!!
        %(Solved in IBEA-- Indicator)
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
        %%
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
            else
                parent2(renew_count+1:renew_count+length(qqq),:) = parent(qqq,:);
                f2(renew_count+1:renew_count+length(qqq),:) = f(qqq,:);
                renew_count = renew_count+length(qqq);
                i = i+1;
            end
        end
    end
%     for i = 1:NP
%         f(i,:) = Problem(parent(i,:),D);
%     end
    for i = 1:ObjectiveDimension
        evoluationRecord(i,gen) = mean(f(1:NP,i));
    end
    gen  = gen + 1;
end

%% draw the evaluation record
% Map to the unit interval
evoluationRecord = evoluationRecord';
% for i = 1 : ObjectiveDimension
%     a = max(evoluationRecord(:,i));
%     b = min(evoluationRecord(:,i));
%     delta = a - b;
%     evoluationRecord(:,i) = (evoluationRecord(:,i)-b)/delta;
% end
%plot(evoluationRecord);figure(gcf);
%%

end
