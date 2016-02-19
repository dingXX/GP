data=importdata('D:/DXX/ladar/terr.txt');
x=data(:,1);
y=data(:,2);
z=data(:,3);
C=data(:,4:6);
C=C/255;
scatter3(x,y,z,3,C,'.');