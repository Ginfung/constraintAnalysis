function [ offspring ] = TwoPointCrossover( parent1,parent2 )
len = length(parent1);
p1 = 1;
p2 = 1;
while p1 >= p2
    p1 = randi(len);
    p2 = randi(len);
end
offspring = [parent1(1:p1),parent2(p1+1:p2),parent1(p2+1:end)];
end