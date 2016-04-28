function [ neighbor ] = elliNeighbour( data,point,r )
%elliNeighbour �ҳ������������
%data ���ƾ���
%point ĳ��
%r [����X��뾶 ����Y��뾶 ����z��뾶]
%negihbor �õ�������������
neighbor=[];
neigh=data;
for i=1:3
    log=abs(neigh(:,i)-point(i))<r(i);
    neigh=neigh(log,:);
end
[m,n]=size(neigh);
for i=1:m
    if((neigh(i,1)-point(1))^2/r(1)+(neigh(i,2)-point(2))^2/r(2)+(neigh(i,3)-point(3))^2/r(3)<=1)
        neighbor=[neighbor;neigh(i,:)];
    end
end
end

