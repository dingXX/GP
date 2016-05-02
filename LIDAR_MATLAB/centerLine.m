function [ line ,num] = centerLine( data )
%centerLine �ҵ������ߵ���XOYƽ���ϵ������ߣ������ĵ���ࣩ
%data �����ߵ�
%line �����߲���
num=0;%�����ĵ����
[n,m]=size(data);
for i=1:n-1%����������
    for j=i+1:n
        a=data(j,2)-data(i,2);
        b=data(i,1)-data(j,1);
        c=data(j,1)*data(i,2)-data(i,1)*data(j,2);
        d=abs(a*data(:,1)+b*data(:,2)+c)/sqrt(a^2+b^2);
        num1=sum(d<0.1);%�����㹹�ɵ�ֱ�߾����ĵ���
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

