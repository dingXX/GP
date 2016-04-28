function [ lines ] = point2lines( points,width )
%point2lines ��������ת��ֵ��ͼ
%points ��������
% width ͼ���
% lines ��������XOYƽ���ֱ��
% img ��ֵͼ��
%[minx,maxx,miny,maxy]
range=[min(points(:,1)),max(points(:,1));min(points(:,2)),max(points(:,2))];
d=min(range(:,2)-range(:,1))/width;
rowcol=((range(:,2)-range(:,1))/d);
img=zeros(ceil(rowcol(1)),ceil(rowcol(2)),'uint8');
[n,m]=size(points);
for i=1:n
%     row=floor((points(i,1)-range(1,1))/d)+1;
%     col=floor((points(i,2)-range(2,1))/d)+1;
     row=uint8((points(i,1)-range(1,1))/d+0.5);
     col=uint8((points(i,2)-range(2,1))/d+0.5);
    img(row,col)=255;
end
imglines=gethoughline(img,5);
for  k = 1: length(imglines)
%     lines(k).point1=((lines(k).point1(:)-1)*d+range(:,1))';
%     lines(k).point2=((lines(k).point2(:)-1)*d+range(:,1))';line
      lines(k).point1(1)=(imglines(k).point1(2)-0.5)*d+range(1,1);
      lines(k).point1(2)=(imglines(k).point1(1)-0.5)*d+range(2,1);
      lines(k).point2(1)=(imglines(k).point2(2)-0.5)*d+range(1,1);
      lines(k).point2(2)=(imglines(k).point2(1)-0.5)*d+range(2,1);
      if abs(lines(k).point1(1)-lines(k).point2(1))>0.01 % k���ڵ����
          lines(k).a=(lines(k).point1(2)-lines(k).point2(2))/(lines(k).point1(1)-lines(k).point2(1));
          lines(k).b=lines(k).point1(2)-lines(k).a*lines(k).point1(1);
          lines(k).c=1;%��¼k�Ƿ����
      else %k�����ڵ����
          lines(k).c=lines.(k).point1(1);
      end
end
end

