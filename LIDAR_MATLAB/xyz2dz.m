function [ dzPts,p0,p1] = xyz2dz( data,line )
%xyz2dz ������תΪ��line����ʾ��ֱ��Ϊ���ᣬZ��Ϊ����ĵ�
% data ����
% line ������XOY���ϵ�ֱ�߷���
% dzPts ������ת����ĵ���
detax=max(data(:,1))-min(data(:,1));
detay=max(data(:,2))-min(data(:,2));
if(detax>=detay)
    k=1;
else
    k=2;
end
[minp,index]=min(data(:,k));
p0=data(index,:);%�����ߵĳ�ʼ��
%�����P0�Ĵ�ֱ�ڵ����߷��̵�ֱ��L
La=-line.b;
Lb=line.a;
Lc=-(La*p0(1)+Lb*p0(2));
dzPts=[abs(La*data(:,1)+Lb*data(:,2)+Lc)/sqrt(La^2+Lb^2),data(:,3)];
% p0=[(Lc*line.b-line.a*line.c)/(La^2+Lb^2),(-line.b*line.c-line.a*Lc)/(La^2+Lb^2)];
%��p1��
[maxp,index]=max(data(:,k));
p1=data(index,:);
% La1=-line.b;
% Lb1=line.a;
% Lc1=-(La1*p1(1)+Lb1*p1(2));
% p1=[(Lc1*line.b-line.a*line.c)/(La1^2+Lb1^2),(-line.b*line.c-line.a*Lc1)/(La1^2+Lb1^2)];
end

