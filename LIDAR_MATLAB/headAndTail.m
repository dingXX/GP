function [ outpoints ] = headAndTail( points,head )
%headAndTail 判断第一段和最后一段电力线的趋势，去除在最高点时的噪声点
%points 电力线点
% head true为头，false为尾
len=length(points);
a=points(1,3);
b=points(ceil(len/2),3);
c=points(len,3);
trend=0;%两端高中间低
if(a>b&&b>c)
    trend=1; %左高右低
end
if(a<b&&b<c)
    trend=2; %左低右高
end
if(head&&trend~=2)%第一段的头高或两端高
    comparepts=points(1:30,3);
    index=find(comparepts==max(comparepts));
    outpoints=points(index(end):len,:);
elseif(~head&&trend~=1)%最后一段尾高
    comparepts=points(len-29:len,3);
    [maxH,index]=max(comparepts);
    outpoints=points(1:index+len-30,:);
else
    outpoints=points;
end



end

