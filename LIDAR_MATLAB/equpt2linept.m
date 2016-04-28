function [ linept ] = equpt2linept( equpt,k )
%equpt2linept 同一条直线方程点求同一条电力线点
%equpt 直线方程点
%linept 电力线点三维数组（每页为一条电力线）
%以 以某轴排序后的邻近点为邻近点
if(~k)%直线方程k不存在，则按x轴排序
    k=2;%对y轴操作
end
j=1;%电力线个数
equpt=sortrows(equpt,k);
while length(equpt)>10
    [n,m]=size(equpt);
    comparePt=equpt(1,:);
    log=logical(equpt(:,1).*0);%是否同一高度的逻辑数组
    log(1)=1;
    for i=2:n
        if abs(equpt(i,3)-comparePt(3))<0.25;
            comparePt=equpt(i,:);
            log(i)=1;
        end
    end
    highLine=equpt(log,:);
    equpt=equpt(~log,:);
    %同一高度的电力线再分段
    [n,m]=size(highLine);
    num=[1];%最高点标号
    for i=5:n
        log=highLine(:,k)<(highLine(i,k)+0.5)|highLine(:,k)>(highLine(i,k)-0.5);
        comparePts=highLine(log,:);
        if (max(comparePts(:,3))==highLine(i,3))
            num=[num,i];
        end
    end
    for i=1:length(num)
        if i==length(num)
            linept{j}=highLine(num(i):end,:);
        else
            linept{j}=highLine(num(i):num(i+1),:);
        end
        j=j+1;
    end
end
