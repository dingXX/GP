function [ linePt ] = getLinePtByChunk( chunkData )
%getLinePtByChunk 获取电力线点云
%chunkData 分块的点云
%LinePt 电力线点云

[n,m]=size(chunkData);
r=[4,4,0.75];
linePt=[];
tab=0;
for i=1:n
    for j=1:m
        data=chunkData{i,j};
        minHd=min(data(:,3));
        Hdata=ETS(data);
        if ~isempty(Hdata)
            minH=min(Hdata(:,3));
            if(minH-minHd<1)
                tab=1;
            end
            linedata  = extractPoint( Hdata,r );
            linePt=[linePt;linedata];
        end        
    end
end
if tab
    linePt=ETS(linePt);
end

end

