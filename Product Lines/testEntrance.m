% Test entrance
% Compare the performance of Differential evaluation and IBEA w/ same
% initial data set

clear all                                   %Test begin

global totalFeatureNum;                     %set up the total number of features
global totalLeavesNum;                      %set up the total number of leaves, which should be determined
global cost;
global usedbefore;
global defects;
global Problem;
global ObjectiveDimension;
global objBound_Min;    
global objBound_Max;

%% Initial the feature attributes.
Problem = @SXFM_web_portal;                  %problems can be generated by another automatic tool written in Java (see SXFM_Parser)
totalFeatureNum = 43;
totalLeavesNum = 28;
cost = rand(1,totalFeatureNum)*10+5;         %cost between 5.0 and 15.0
usedbefore = randi([0 1],1,totalFeatureNum); %usedbefore is a binary random variable
defects = rand(1,totalFeatureNum) * 10;      %defects between 0 and 10

for i = 1:totalFeatureNum
    if usedbefore(i) == 0
        defects(i) = 0;
    end
end

ObjectiveDimension = 5;                      % objective(goal) space dimension % all goals should be minimized
%f(1) is total cost
%f(2) is number of  feature that were NOT used before
%f(3) is total number of known defects
%f(4) is # of rule violations
%f(5) is # of feature NOT provided
objBound_Min = zeros(1,ObjectiveDimension);
objBound_Max = zeros(1,ObjectiveDimension);
objBound_Min(1) = 0;
objBound_Max(1) = sum(cost);
objBound_Min(2) = 0;
objBound_Max(2) = totalFeatureNum;
objBound_Min(3) = 0;
objBound_Max(3) = sum(defects);
objBound_Min(4) = 0;
objBound_Max(4) = 6;
objBound_Min(5) = 0;
objBound_Max(5) = totalFeatureNum;

%% Execute the testing
[parent, f, evoluationRecord,costRecord] = multiObjective(50);

%% Analysis. Visualization

% score = evoluationRecord;
% for  i = 1: ObjectiveDimension
%     score(:,i) = 1 - (evoluationRecord(:,i)-min(evoluationRecord(:,i)))/(max(evoluationRecord(:,i))-min(evoluationRecord(:,i)));
% end
% score(:,2) = 1 - score(:,2)/totalFeatureNum;
% score(:,3) = 1 - score(:,3)/sum(defects);
% score(:,4) = 1 - score(:,4)/6; %CORRECT CT
% score(:,5) = 1 - score(:,5)/totalFeatureNum;
