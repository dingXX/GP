function [ linedata ] = extractPoint( data,r )
%extractPoint ��ȡ�����ߵ�
%data ԭʼ��������
%r ��������뾶����
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

