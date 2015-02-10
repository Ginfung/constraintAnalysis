clear all
Problem = @DTLZ1;
NP = 80;
CR = 0.9;
F = 0.8;
gen_max = 500;
D = 8;
ObjectiveDimension = 4;
domain_a = 0;
domain_b = 1;


parent = rand(NP,D)*(domain_b-domain_a)+domain_a; %initial population. x in [?,?]
desire = NP;
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
                trial(j) = mod(trial(j),1);
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
%         else
%             if testDominate(f(i,:),trial_objective,ObjectiveDimension)
%                 parent(i,:) = (parent(i,:) + trial).*0.5;
%                 f(i,:) = (f(i,:) + trial_objective).*0.5;
%end
         end         
    end
    count  = count + 1;
end

for i = 1:NP
    f(i,:) = Problem(parent(i,:),D);
end


