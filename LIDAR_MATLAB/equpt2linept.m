function [ linept ] = equpt2linept( equpt,k )
%equpt2linept ͬһ��ֱ�߷��̵���ͬһ�������ߵ�
%equpt ֱ�߷��̵�
%linept �����ߵ���ά���飨ÿҳΪһ�������ߣ�
%�� ��ĳ���������ڽ���Ϊ�ڽ���
if(~k)%ֱ�߷���k�����ڣ���x������
    k=2;%��y�����
end
j=1;%�����߸���
equpt=sortrows(equpt,k);
while length(equpt)>10
    [n,m]=size(equpt);
    comparePt=equpt(1,:);
    log=logical(equpt(:,1).*0);%�Ƿ�ͬһ�߶ȵ��߼�����
    log(1)=1;
    for i=2:n
        if abs(equpt(i,3)-comparePt(3))<0.25;
            comparePt=equpt(i,:);
            log(i)=1;
        end
    end
    highLine=equpt(log,:);
    equpt=equpt(~log,:);
    %ͬһ�߶ȵĵ������ٷֶ�
    [n,m]=size(highLine);
    num=[1];%��ߵ���
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
