% get the result from IBEA optimizer
% modified from Sayyad, Abdel Salam, Tim Menzies, and Hany Ammar. "On the value of user preferences in search-based software engineering: A case study in software product lines." Software engineering (ICSE), 2013 35th international conference on. IEEE, 2013.

function [parent,f,evoluationRecord,featureRecord] = IBEA(gen_max)

global totalLeavesNum;  %set up the total number of leaves, which should be determined
global k;
global Problem;
global ObjectiveDimension;


%% set up IBEA parameters
alpha = 100; % population size
beta = 30; % mating pool size
D = totalLeavesNum; % decision space dimension
k = 1; % fitness scaling factor. Defaultly 1.


evoluationRecord = zeros(gen_max,ObjectiveDimension);
featureRecord = zeros(gen_max,alpha);
%% step 1: Initializaiton
P = randi([0 1],alpha,D); % initialize an initial population P of size alpha
PP = randi([0 1],beta,D); % mating pool, randomly initialized. size equals alpha
P = [P;PP]; % append mating pool to initialization pool

obj = zeros(size(P,1),ObjectiveDimension);
for i = 1:size(P,1)
    obj(i,:) = Problem(P(i,:),D);
end

%% step 2: Fitness assignment
F = Fitness(P,obj);

%%
gen  = 1;
while (gen <= gen_max)
    gen
    F = Fitness(P,obj);
    %% step 3: Environment selection
    while (size(P,1) > alpha)
        xstar = find(F==min(F));
        for i = 1:size(F,2)
            F(1,i) = F(1,i)+exp(-epsAddIndicator(obj(xstar,:),obj(i,:),ObjectiveDimension)/k);
        end
        P = [P(1:xstar-1,:);P(xstar+1:end,:)]; % remove xstar from P
        obj = [obj(1:xstar-1,:);obj(xstar+1:end,:)]; % always let obj follows the change of P
        F = [F(1,1:xstar-1),F(1,xstar+1:end)];
    end
    for i = 1:ObjectiveDimension
        evoluationRecord(gen,i) = median(obj(:,i));
    end
    featureRecord(gen,:) = obj(:,2)';
    %% step 5: Mating selection
    % binary tournament selection
    PP = zeros(beta,D);
    for i = 1 : beta
        a = randi(alpha);
        b = randi(alpha);
        if F(a) < F(b)
            a = b;
        end
        PP(i,:) = P(a,:);
    end
    %% step 6: Variation
    for i = 1:beta
        % crossover
        p1 = randi(beta);
        p2 = randi(beta);
        offspring = TwoPointCrossover(PP(p1,:),PP(p2,:));
        % mutate
        if(rand()<0.9)
            m = randi(D);
            offspring(m) = ~offspring(m);
        end
        P = [P;offspring];
    end
    for i = 1:size(P,1)
        obj(i,:) = Problem(P(i,:),D);
    end
    gen = gen+1;
end

parent = P(1:alpha,:);
f = obj(1:alpha,:);

%% draw the evaluation record
% Map to the unit interval
% for i = 1 : ObjectiveDimension
%     a = max(evoluationRecord(:,i));
%     b = min(evoluationRecord(:,i));
%     delta = a - b;
%     evoluationRecord(:,i) = (evoluationRecord(:,i)-b)/delta;
% end
%plot(evoluationRecord);figure(gcf);
%%

end
