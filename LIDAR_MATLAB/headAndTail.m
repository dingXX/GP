function [ outpoints ] = headAndTail( points,head )
%headAndTail �жϵ�һ�κ����һ�ε����ߵ����ƣ�ȥ������ߵ�ʱ��������
%points �����ߵ�
% head trueΪͷ��falseΪβ
len=length(points);
a=points(1,3);
b=points(ceil(len/2),3);
c=points(len,3);
trend=0;%���˸��м��
if(a>b&&b>c)
    trend=1; %����ҵ�
end
if(a<b&&b<c)
    trend=2; %����Ҹ�
end
if(head&&trend~=2)%��һ�ε�ͷ�߻����˸�
    comparepts=points(1:30,3);
    index=find(comparepts==max(comparepts));
    outpoints=points(index(end):len,:);
elseif(~head&&trend~=1)%���һ��β��
    comparepts=points(len-29:len,3);
    [maxH,index]=max(comparepts);
    outpoints=points(1:index+len-30,:);
else
    outpoints=points;
end



end

