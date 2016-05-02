function [ curve ] = fitting( data,line )
%fitting ������С���˷��������������
% data ����
% line ������XOY���ϵ�ֱ�߷���
% curve �����߲���
[dzPts,p0]=xyz2dz(data,line);
a=polyfit(dzPts(:,1),dzPts(:,2),2);%����ʽ���
if(line.c)
    k=1;
else
    k=2;
end
[maxp,index]=max(data(:,k));
curve.p0=p0;
curve.p1=data(index,:);
curve.A=a(1);
curve.B=a(2);
curve.C=a(3);
curve.a=line.a;
curve.k=line.c;%k�Ƿ����
end

