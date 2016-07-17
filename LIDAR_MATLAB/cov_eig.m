function [ log ] = cov_eig( neighbor )
% cov_eig ����Э����������ֵ���������ֵ����
% neighbor �������
% log �������ֵ����
[n,m]=size(neighbor);
if n<3
    log=0;
    return;
end
cv=cov(neighbor);%Э����
[X,B]=eig(cv);%XΪ����������BΪ����ֵ
B=[B(1,1),B(2,2),B(3,3)];
B=sort(B,'descend');
a=[(sqrt(B(1))-sqrt(B(2)))/sqrt(B(1)),(sqrt(B(2))-sqrt(B(3)))/sqrt(B(1)),sqrt(B(3))/sqrt(B(1))];
a=a>0.85;
log=sum(a);

end
