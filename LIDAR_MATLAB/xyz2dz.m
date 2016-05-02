function [ dzPts,p0 ] = xyz2dz( data,line )
%xyz2dz 将点云转为以line所表示的直线为横轴，Z轴为纵轴的点
% data 点云
% line 点云在XOY面上的直线方程
% dzPts 坐标轴转化后的点云
if(line.c)
    k=1;
else
    k=2;
end
[minp,index]=min(data(:,k));
p0=data(index,:);%电力线的初始点
%求过点P0的垂直于电力线方程的直线L
if(line.c)%直线k存在的情况
    if(line.a<0.01) %L垂直于x轴
        dzPts=[data(:,1)-p0(1),data(:,3)];
    else %L的普通情况
        La=-1/line.a;
        Lb=p0(2)-La*p0(1);
        dzPts=[abs(La*data(:,1)-data(:,2)+Lb)/sqrt(1+La^2),data(:,3)];
    end
else % L垂直于y轴
    dzPts=[data(:,2)-p0(2),data(:,3)];
end
end

