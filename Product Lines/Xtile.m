% reference : http://unbox.org/open/trunk/472/14/spring/var/code/do.html
% 10-30% and 70-90% are marked as dashes('-')

function [ tile ] = Xtile( lst,low,high,width )

slst = sort(lst);
len  = length(lst);
low = min(low,slst(1));
high = max(high,slst(len));


    function v = getposvalue (p)
        v = slst(int64((len*p)+0.5));
    end
    
    function place = locate(x)
        place = int64(width * (x-low)/(high-low) +0.5);
    end

    v1 = getposvalue(0.1);
    v3 = getposvalue(0.3);
   % v5 = getposvalue(0.5);
    v7 = getposvalue(0.7);
    v9 = getposvalue(0.9);
    
    p1 = locate(v1);
    p3 = locate(v3);
    %p5 = locate(v5);
    p7 = locate(v7);
    p9 = locate(v9);
    pmedian = locate(median(lst));

    tile = '(';
    for i = 1:p1-1
        tile = strcat(tile,'~');
    end
    for i = p1:p3-1
        tile = strcat(tile,'-');
    end
    for i = p3:p7-1
        tile = strcat(tile,'~');
    end
    for i = p7:p9-1
        tile = strcat(tile,'-');
    end
    for i = p9:width
        tile = strcat(tile,'~');
    end
    
    tile(pmedian+1) = '*';
    tile = strcat(tile,')');
    tile = strcat(tile(1:int64(width/2)+1),'|',tile(int64(width/2)+2:width+2));
    tile = strrep(tile,'~',' ');
end

