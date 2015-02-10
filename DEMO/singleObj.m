clear all

NP = 10;
CR = 0.3;
F = 0.9;
gen_max = 100;
D = 1;
x1 = rand(NP,D)*2*50-50; %initial population
x2 = zeros(1,D);
trial = zeros(1,D);

cost = zeros(NP,1);
%initialize the cost
for i = 1:NP
    cost(i) = evaluate(x1(i,:));
end

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
                trial(j) = x1(c,j) + F*(x1(a,j)-x1(b,j));
            else
                trial(j) = x1(i,j);
            end
            j = mod(j+1,D)+1;
        end
        
        score = evaluate(trial(1,:));
        if score <= cost(i)
            x2 = trial;
            cost(i) = score;
        else
            x2 = x1(i,:);
        end          
    end
    x1(i,:) = x2;
    count  = count + 1;
end
