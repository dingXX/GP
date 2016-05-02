function [ line ,num] = centerLine( data )
%centerLine 找到电力线点在XOY平面上的中心线（经过的点最多）
%data 电力线点
%line 中心线参数
num=0;%经过的点个数
[n,m]=size(data);
for i=1:n-1%任意两个点
    for j=i+1:n
        a=data(j,2)-data(i,2);
        b=data(i,1)-data(j,1);
        c=data(j,1)*data(i,2)-data(i,1)*data(j,2);
        d=abs(a*data(:,1)+b*data(:,2)+c)/sqrt(a^2+b^2);
        num1=sum(d<0.1);%这两点构成的直线经过的点数
        if(num1>num)
            num=num1;
            line.a=a;
            line.b=b;
            line.c=c;
            if(num==length(data))
                break;
            end
        end
    end
end
end

