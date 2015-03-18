function [ tile ] = Xtile( lst,low,high )
function i = findi(m)
i=0;
while m>sig(i+1)
    i = i+1;
end
end
% Showing the percentage in text
tile = '(     |     )';
pos = [2,3,4,5,6,8,9,10,11,12];
lst = sort(lst);
len = length(lst);
sig = zeros(1,11);
sig(1) = low;
for i = 2:11
    sig(i) = low+(high-low)*(i-1)/10;
end

tile(pos(findi(median(lst)))) = '*'; % mark the median
p1 = lst(int64(len*0.1));
p3 = lst(int64(len*0.3));
p5 = lst(int64(len*0.5));
p7 = lst(int64(len*0.7));
p9 = lst(int64(len*0.9));
if p3-p1 > (high-low)/40 % draw 10%~30%
    for i = findi(p1):findi(p3)
        tile(pos(i)) = '-';
    end
end
if p9-p7 > (high-low)/40 % draw 70%~90%
    for i = findi(p7):findi(p9)
        tile(pos(i)) = '-';
    end
end
end

