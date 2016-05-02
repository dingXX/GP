function curveShow( curve ,s)
%curveShow ��ʾ����
%curve ���߲���
%s ���
if nargin<2
    s=1;
end
%���ݳ�ʼ������ֹ�㣬����s��
dist=sqrt((curve.p0(1)-curve.p1(1))^2+(curve.p0(2)-curve.p1(2))^2);
s=0:s:dist;
s=[s,dist];
if curve.k % k����
    x=curve.p0(1)+s.*(1/sqrt(curve.a^2+1));
    y=curve.p0(2)+s.*(curve.a/sqrt(curve.a^2+1));
else
    x=curve.p0(1);
    y=curve.p0(2)+s;
end
z=curve.A*s.^2+curve.B*s+curve.C;
plot3(x,y,z,'-r');
end
