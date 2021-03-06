function [ lines ] = gethoughline( f , peaksNum )
%GETHOUGHLINE 此处显示有关此函数的摘要
%   此处显示详细说明
% f 二值化二维矩阵，[0,255]
%peaksNum houghpeaks中的峰值数
% lines 检测到的直线
[H,theta,rho]=hough(f,'ThetaRes',0.1,'RhoRes',0.5);
peaks=houghpeaks(H,peaksNum,'NHoodSize',[11,11]);
lines=houghlines(f,theta,rho,peaks,'FillGap',40);
figure, imshow(f, []), hold on
for  k = 1: length(lines)
    xy = [lines(k).point1; lines(k).point2];
    plot(xy(:, 1), xy(:, 2), 'LineWidth', 2, 'Color', [1,0,0]);
end
end

