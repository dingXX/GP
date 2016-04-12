function [ Hpoint,Lpoint ] = ETS( pc )
%ETS 高程阈值分割法
%  pc ：point clouds
%  Hpoint :阈值上点
%  Lpoint：阈值下点
%  流程：均值分成两份，两份的均值的均值和原均值收敛
Zm=0;%初始阈值高程
Zmi=mean(pc(:,3));%迭代阈值高程
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

