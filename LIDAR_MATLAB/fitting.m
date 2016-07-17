function [ curve ] = fitting( data,line )
%fitting ������С���˷��������������
% data ����
% line ������XOY���ϵ�ֱ�߷���
% curve �����߲���
[dzPts,p0,p1]=xyz2dz(data,line);
a=polyfit(dzPts(:,1),dzPts(:,2),2);%����ʽ���
curve.p0=p0;
curve.p1=p1;
curve.A=a(1);
curve.B=a(2);
curve.C=a(3);
curve.a=line.a;
curve.b=line.b;
curve.c=line.c;
end

