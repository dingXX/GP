scatter3(C(:,1),C(:,2),C(:,3));
cv=cov(C);%协方差
[X,B]=eig(cv);%协方差的特征向量和特征值