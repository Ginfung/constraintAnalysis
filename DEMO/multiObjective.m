clear all
Problem = @DTLZ1;
NP = 100;
CR = 0.3;
F = 0.9;
gen_max = 100;
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
    desire = NP;
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
                trial(j) = mod(trial(j),4);
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
            if ~testDominate(f(i,:),trial_objective,ObjectiveDimension)
                desire = desire+1;
               parent(desire,:) = trial;
               f(desire,:) = trial_objective;
            end
         end         
    end
    %sort the f(1~desire), and get the first NP results
    f(:,ObjectiveDimension+1) = 0;
    for i = 1:desire
        for j = 1:desire
            if i~= j && testDominate(f(i,:),f(j,:),ObjectiveDimension)
                f(i,ObjectiveDimension+1) = f(i,ObjectiveDimension+1)+1;
            end
        end
    end
    f(:,ObjectiveDimension+2:ObjectiveDimension+1+D) = parent(:,:);
    f = sortrows(f,-(ObjectiveDimension+1));
    parent = f(:,ObjectiveDimension+2:ObjectiveDimension+1+D);
    f = f(1:NP,1:ObjectiveDimension);
    count  = count + 1;
end

for i = 1:NP
    f(i,:) = Problem(parent(i,:),D);
end


