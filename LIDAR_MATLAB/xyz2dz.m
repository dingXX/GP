function [ dzPts,p0,p1] = xyz2dz( data,line )
%xyz2dz 将点云转为以line所表示的直线为横轴，Z轴为纵轴的点
% data 点云
% line 点云在XOY面上的直线方程
% dzPts 坐标轴转化后的点云
detax=max(data(:,1))-min(data(:,1));
detay=max(data(:,2))-min(data(:,2));
if(detax>=detay)
    k=1;
else
    k=2;
end
[minp,index]=min(data(:,k));
p0=data(index,:);%电力线的初始点
%求过点P0的垂直于电力线方程的直线L
La=-line.b;
Lb=line.a;
Lc=-(La*p0(1)+Lb*p0(2));
dzPts=[abs(La*data(:,1)+Lb*data(:,2)+Lc)/sqrt(La^2+Lb^2),data(:,3)];
% p0=[(Lc*line.b-line.a*line.c)/(La^2+Lb^2),(-line.b*line.c-line.a*Lc)/(La^2+Lb^2)];
%求p1点
[maxp,index]=max(data(:,k));
p1=data(index,:);
% La1=-line.b;
% Lb1=line.a;
% Lc1=-(La1*p1(1)+Lb1*p1(2));
% p1=[(Lc1*line.b-line.a*line.c)/(La1^2+Lb1^2),(-line.b*line.c-line.a*Lc1)/(La1^2+Lb1^2)];
end

