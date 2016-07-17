function [ log ] = cov_eig( neighbor )
% cov_eig 根据协方差求特征值，求大特征值个数
% neighbor 邻域矩阵
% log 大的特征值个数
[n,m]=size(neighbor);
if n<3
    log=0;
    return;
end
cv=cov(neighbor);%协方差
[X,B]=eig(cv);%X为特征向量，B为特征值
B=[B(1,1),B(2,2),B(3,3)];
B=sort(B,'descend');
a=[(sqrt(B(1))-sqrt(B(2)))/sqrt(B(1)),(sqrt(B(2))-sqrt(B(3)))/sqrt(B(1)),sqrt(B(3))/sqrt(B(1))];
a=a>0.85;
log=sum(a);

end
