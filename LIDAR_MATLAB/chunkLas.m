function [ chunkData ] = chunkLas( path,unitWidth )
%chunkLas 对点云数据进行分块
%path 文件路径
%chunkData cell 点云数据的xyz
num=50000;
if nargin < 2 
unitWidth=50;
end
head=readLasHeader(path);
numOfPt=head.numberOfPointRecords-4;
detaX=head.maxX-head.minX;
detaY=head.maxY-head.minY;
chunkX=ceil(detaX/unitWidth);
chunkY=ceil(detaY/unitWidth);
chunkData=cell(chunkX,chunkY);

times=floor(numOfPt/num);
for k=0:times
    if k==times
        data=readLas(path,k*num+1,numOfPt-(k*num));
    else
        data=readLas(path,k*num+1,num);
    end
    data=las2xyz(data);
    for i=1:chunkX
        for j=1:chunkY
            if ~isempty(data)
                minX=head.minX+unitWidth*(i-1);
                maxX=minX+unitWidth;
                minY=head.minY+unitWidth*(j-1);
                maxY=minY+unitWidth;
                log=data(:,1)>=minX & data(:,1)<maxX & data(:,2)>=minY & data(:,2)<maxY;
                pts=chunkData{i,j};
                pts=[pts;data(log,:)];
                chunkData{i,j}=pts;
                data=data(~log,:);
            else
                break;
            end
        end
    end
end
end

