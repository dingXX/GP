data=importdata('data/point1.txt');
data=data(:,1:3);
Hdata=ETS(data);
r=[4,4,0.75];
linedata  = extractPoint( Hdata,r );
linearEqu  = point2lines( linedata,400);
linePoints  = getLinePoints( linedata,linearEqu );
%电力线点云显示与电力线三维重建
len=length(linePoints);
k=1;
for i=1:len
    for j=1:length(linePoints(i).points)
        linePt{k}=linePoints(i).points{j};
        k=k+1;
    end
end


len=length(linePt);
for i=1:len
    line=centerLine(linePt{i});
    curve=fitting(linePt{i},line);
    curveShow(curve);
    hold on;
    scatter3(linePt{i}(:,1),linePt{i}(:,2),linePt{i}(:,3),20,[0,0,0],'.');
    
end

len=length(linePt)
for i=1:len
    scatter3(linePt{i}(:,1),linePt{i}(:,2),linePt{i}(:,3),20,[1/i,0,0],'.');
    hold on
end


a=[(sqrt(B(1))-sqrt(B(2)))/sqrt(B(1)),(sqrt(B(2))-sqrt(B(3)))/sqrt(B(1)),sqrt(B(3))/sqrt(B(1))];


scatter3(neigh(:,1),neigh(:,2),neigh(:,3),100,[1,0,0],'.');
hold on
scatter3(neighbor(:,1),neighbor(:,2),neighbor(:,3),255,[0,1,1],'.');
hold on
scatter3(point(:,1),point(:,2),point(:,3),3,[0,0,0],'.');


scatter3(data(:,1),data(:,2),data(:,3),3,[1,0,0],'.');
scatter3(Hdata(:,1),Hdata(:,2),Hdata(:,3),3,[1,0,0],'.');
hold on
scatter3(linedata(:,1),linedata(:,2),linedata(:,3),3,[0,0,0],'.');


range=[min(linedata(:,1)),max(linedata(:,1));min(linedata(:,2)),max(linedata(:,2))];


scatter(linedata(:,1),linedata(:,2),3,[0,0,0],'.');


x=linearEqu(i).point1(1):1:linearEqu(i).point2(1);
if linearEqu.b==0
    y=x*0+linearEqu(i).point1(2);
else
    y=-(linearEqu(i).a*x+linearEqu(i).c)/linearEqu(i).b;
end
plot(x,y)


 scatter(highLine(i,1),highLine(i,3),255,[1,0,0],'.');
hold on
scatter(highLine(:,1),highLine(:,3),3,'.');
scatter(comparePts(:,1),comparePts(:,3),100,[1,1,0],'.');

linePt{i}=linePt{i}*100;

line=centerLine(linePt{i});
[dzPts,p0,p1]=xyz2dz(linePt{i},line);
curve=fitting(linePt{i},line);
d=dzPts(:,1);
zf=curve.A*d.^2+curve.B*d+curve.C;
z=dzPts(:,2);
SSE=sum((z-zf).^2);
meanZ=mean(z);
R=1-(SSE/sum((z-meanZ).^2));

line=linePoints(ceil(i/2)).line;
[dzPts,p0,p1]=xyz2dz(linePt{i},line);
curve=fitting(linePt{i},line);
d=dzPts(:,1);
zf=curve.A*d.^2+curve.B*d+curve.C;
z=dzPts(:,2);
SSE=sum((z-zf).^2);
meanZ=mean(z);
R=1-(SSE/sum((z-meanZ).^2));


%JING 拟合
pts=linePt{i};
d=sqrt(pts(:,1).^2+pts(:,2).^2);
z=pts(:,3);
a=polyfit(d,z,2);
zf=a(1)*d.^2+a(2)*d+a(3);
SSE=sum((z-zf).^2);
meanZ=mean(z);
R=1-(SSE/sum((z-meanZ).^2));


%最佳拟合平面图
line=centerLine(linePt{i});
[dzPts,p0,p1]=xyz2dz(linePt{i},line);
curve=fitting(linePt{i},line);
x=dzPts(:,1);
y=curve.A*(x.^2)+curve.B*x+curve.C;
plot(x,y,'-r');
hold on
scatter(dzPts(:,1),dzPts(:,2),20,'.');


curveShow(curve);
hold on;
scatter3(linePt{i}(:,1),linePt{i}(:,2),linePt{i}(:,3),20,'.');



%总程序
tic;
datapath='data/point98.las';
% Las文件分块
dataCell=chunkLas(datapath,20);
toc;
tic;
%分块分割电力线点云
linedata=getLinePtByChunk(dataCell);
toc;
tic;
%提取电力线XOY面方程
linearEqu  = point2lines( linedata,400);
%单段电力线提取
linePoints  = getLinePoints( linedata,linearEqu );
toc