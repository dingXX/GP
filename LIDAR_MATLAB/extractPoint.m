function [ linedata ] = extractPoint( data,r )
%extractPoint 提取电力线点
%data 原始点云数据
%r 椭球邻域半径数组
[n,m]=size(data);
linedata=[];
for i=1:n
    neighbor=elliNeighbour( data,data(i,:),r );
    log=cov_eig(neighbor);
    if(log==1)
        linedata=[linedata;data(i,:)];
    end
end
end

