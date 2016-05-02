function [ dzPts,p0 ] = xyz2dz( data,line )
%xyz2dz ������תΪ��line����ʾ��ֱ��Ϊ���ᣬZ��Ϊ����ĵ�
% data ����
% line ������XOY���ϵ�ֱ�߷���
% dzPts ������ת����ĵ���
if(line.c)
    k=1;
else
    k=2;
end
[minp,index]=min(data(:,k));
p0=data(index,:);%�����ߵĳ�ʼ��
%�����P0�Ĵ�ֱ�ڵ����߷��̵�ֱ��L
if(line.c)%ֱ��k���ڵ����
    if(line.a<0.01) %L��ֱ��x��
        dzPts=[data(:,1)-p0(1),data(:,3)];
    else %L����ͨ���
        La=-1/line.a;
        Lb=p0(2)-La*p0(1);
        dzPts=[abs(La*data(:,1)-data(:,2)+Lb)/sqrt(1+La^2),data(:,3)];
    end
else % L��ֱ��y��
    dzPts=[data(:,2)-p0(2),data(:,3)];
end
end

