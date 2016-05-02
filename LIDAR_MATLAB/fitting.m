function [ curve ] = fitting( data,line )
%fitting 基于最小二乘法进行抛物线拟合
% data 点云
% line 点云在XOY面上的直线方程
% curve 抛物线参数
[dzPts,p0]=xyz2dz(data,line);
a=polyfit(dzPts(:,1),dzPts(:,2),2);%多项式拟合
detax=max(data(:,1))-min(data(:,1));
detay=max(data(:,2))-min(data(:,2));
if(detax>=detay)
    k=1;
else
    k=2;
end
[maxp,index]=max(data(:,k));
curve.p0=p0;
curve.p1=data(index,:);
curve.A=a(1);
curve.B=a(2);
curve.C=a(3);
curve.a=line.a;
curve.b=line.b;
end

