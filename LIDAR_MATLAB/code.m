data=importdata('data/point1.txt');
data=data(:,1:3);
Hdata=ETS(data);
r=[4,4,0.75];
linedata  = extractPoint( Hdata,r );
linearEqu  = point2lines( linedata,200);
linePoints  = getLinePoints( linedata,linearEqu );

a=[(sqrt(B(1))-sqrt(B(2)))/sqrt(B(1)),(sqrt(B(2))-sqrt(B(3)))/sqrt(B(1)),sqrt(B(3))/sqrt(B(1))];


scatter3(neigh(:,1),neigh(:,2),neigh(:,3),100,[1,0,0],'.');
hold on
scatter3(neighbor(:,1),neighbor(:,2),neighbor(:,3),255,[0,1,1],'.');
hold on
scatter3(point(1),point(2),point(3),255,[0,0,0],'.');


scatter3(data(:,1),data(:,2),data(:,3),3,[1,0,0],'.');
scatter3(Hdata(:,1),Hdata(:,2),Hdata(:,3),3,[1,0,0],'.');
hold on
scatter3(linedata(:,1),linedata(:,2),linedata(:,3),3,[0,0,0],'.');


range=[min(linedata(:,1)),max(linedata(:,1));min(linedata(:,2)),max(linedata(:,2))];


scatter(linedata(:,1),linedata(:,2),3,[0,0,0],'.');


x=linearEqu(1).point1(1):1:linearEqu(1).point2(1);
if linearEqu.b==0
    y=x*0+linearEqu(1).point1(2);
else
    y=-(linearEqu(1).a*x+linearEqu(1).c)/linearEqu(1).b;
end
plot(x,y)