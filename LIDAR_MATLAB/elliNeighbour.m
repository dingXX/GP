function [ neighbor ] = elliNeighbour( data,point,r )
%elliNeighbour 找出点的椭球领域
%data 点云矩阵
%point 某点
%r [椭球X轴半径 椭球Y轴半径 椭球z轴半径]
%negihbor 该点的椭球邻域矩阵
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

