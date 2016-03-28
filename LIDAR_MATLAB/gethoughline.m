function [ lines ] = gethoughline( f , peaksNum )
%GETHOUGHLINE �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
% f ��ֵ����ά����[0,255]
%peaksNum houghpeaks�еķ�ֵ��
% lines ��⵽��ֱ��
[H,theta,rho]=hough(f);
peaks=houghpeaks(H,peaksNum);
lines=houghlines(f,theta,rho,peaks);
figure, imshow(f, []), hold on
for  k = 1: length(lines)
    xy = [lines(k).point1; lines(k).point2];
    plot(xy(:, 1), xy(:, 2), 'LineWidth', 2, 'Color', [1,0,0]);
end
end

