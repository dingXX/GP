tic;
data=importdata('D:/DXX/ladar/terr.txt');
x=data(:,1);
y=data(:,2);
z=data(:,3);
%C=data(:,4:6);
%C=C/255;
%clear data;
%25s
%scatter3(x,y,z,3,C,'.');
%1s
%scatter3(x,y,z,'.');
%1s
scatter3(x,y,z,3,z,'.');
toc;