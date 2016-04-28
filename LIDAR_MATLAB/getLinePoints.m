function [ linePoints ] = getLinePoints( points,lines )
%getLinePoints 找出在直线方程附近的电力线点云
%points 所有的电力线点云点
%lines 电力线直线方程
%linePoints linePoints.line 直线方程 linePoints.points cell格式，包含每条单独电力线的点
for i=1:length(lines)
    %保存直线方程
    linePoints(i).line=lines(i); 
    % x轴的范围 两点间的距离正负1
    xrange=sort([lines(i).point1(1),lines(i).point2(1)]);
    xrange=[xrange(1)-1,xrange(2)+1];
    % y轴的范围 两点间的距离正负1
    yrange=sort([lines(i).point1(2),lines(i).point2(2)]);
    yrange=[yrange(1)-1,yrange(2)+1];
    % 点离直线的距离d
    if(lines(i).c)
        points(:,4)=abs(lines(i).a*points(:,1)-points(:,2)+lines(i).b)/sqrt(1+lines(i).a^2);
    else
        points(:,4)=abs(points(:,1)-lines(i).point1(1));
    end
    log=points(:,4)<0.5&points(:,1)>xrange(1)&points(:,1)<xrange(2)&points(:,2)>yrange(1)&points(:,2)<yrange(2);
    %方程点
    equPoints=points(log,:);
    linePoints(i).points=equpt2linept(equPoints,linePoints(i).line.c);
    %linePoints(i).points=points(log,:);
    points=points(~log,:);
end

