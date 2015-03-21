function [ result ] = CompareByXtile( DataSet, setCount, width, showQuartiles  )
% Compare different data sets by the Xtile
% Each set in one row

low = min(DataSet);
high = max(DataSet);
result = '';

for i = 1:setCount
    result = [result Xtile(DataSet(i,:),low,high,width,showQuartiles) char(10) ];
end
end

