function [ Hpoint,Lpoint ] = ETS( pc )
%ETS �߳���ֵ�ָ
%  pc ��point clouds
%  Hpoint :��ֵ�ϵ�
%  Lpoint����ֵ�µ�
%  ���̣���ֵ�ֳ����ݣ����ݵľ�ֵ�ľ�ֵ��ԭ��ֵ����
Zm=0;%��ʼ��ֵ�߳�
Zmi=mean(pc(:,3));%������ֵ�߳�
while(abs(Zmi-Zm)>0.5) %
    Zm=Zmi;
    candidataH=pc(:,3)>Zm;
    Hpoint=pc(candidataH,:);
    Lpoint=pc(~candidataH,:);
    HZm=mean(Hpoint(:,3));
    LZm=mean(Lpoint(:,3));
    Zmi=(HZm+LZm)/2;
end
end

