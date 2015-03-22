% return the epsAddIndicator
% reference: Zitzler, Eckart, and Simon Künzli. "Indicator-based selection in multiobjective search." Parallel Problem Solving from Nature-PPSN VIII. Springer Berlin Heidelberg, 2004.
function [ indicator ] = epsAddIndicator( f_A,f_B,objectiveDimension )
global objBound_Min;
global objBound_Max;

indicator = (f_A(1) - f_B(1))/(objBound_Max(1) - objBound_Min(1));
for i = 2:objectiveDimension
    temp = (f_A(i) - f_B(i))/(objBound_Max(i) - objBound_Min(i));
    if(temp > indicator)
        indicator = temp;
    end
end
end

