function [ curve ] = fitting( data,line )
%fitting 基于最小二乘法进行抛物线拟合
% data 点云
% line 点云在XOY面上的直线方程
% curve 抛物线参数
[dzPts,p0,p1]=xyz2dz(data,line);
a=polyfit(dzPts(:,1),dzPts(:,2),2);%多项式拟合
curve.p0=p0;
curve.p1=p1;
curve.A=a(1);
curve.B=a(2);
curve.C=a(3);
curve.a=line.a;
curve.b=line.b;
curve.c=line.c;
end

