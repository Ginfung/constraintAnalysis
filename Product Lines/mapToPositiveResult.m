%map the evaluation to score

map = evoluationRecord2;
%f(1) is total cost
%f(2) is number of feature that were NOT used before
%f(3) is total number of known defects
%f(4) is # of rule violations
%f(5) is # of feature NOT provided

map(:,1) = (map(:,1)-150)/150;
map(:,2) = 1- map(:,2)/43;
map(:,3) = 1- map(:,3)/60;
map(:,4) = 1- map(:,4)/6;
map(:,5) = 1-map(:,5)/43;