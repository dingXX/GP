tic
data=importdata('D:/DXX/ladar/terr.txt');
[row,col]=size(data);
r=round(row/2);
x=data(1:r,1);
y=data(1:r,2);
z=data(1:r,3);
c=data(1:r,4:6);
c=c/255;
scatter3(x,y,z,3,c,'.');
hold on;
x=data(r+1:end,1);
y=data(r+1:end,2);
z=data(r+1:end,3);
c=data(r+1:end,4:6);
c=c/255;
scatter3(x,y,z,3,c,'.');
toc