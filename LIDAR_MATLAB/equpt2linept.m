function [ linept ] = equpt2linept( equpt )
%equpt2linept ͬһ��ֱ�߷��̵���ͬһ�������ߵ�
%equpt ֱ�߷��̵�
%linept �����ߵ���ά���飨ÿҳΪһ�������ߣ�
%k ��ĳ���������ڽ���Ϊ�ڽ���
detax=max(equpt(:,1))-min(equpt(:,1));
detay=max(equpt(:,2))-min(equpt(:,2));
if(detax>=detay)
    k=1;
else
    k=2;
end
j=1;%�����߸���
equpt=sortrows(equpt,k);
while length(equpt)>30
    [n,m]=size(equpt);
    comparePt=equpt(1,:);
    log=logical(equpt(:,1).*0);%�Ƿ�ͬһ�߶ȵ��߼�����
    log(1)=1;
    for i=2:n
        if abs(equpt(i,3)-comparePt(3))<1;
            comparePt=equpt(i,:);
            log(i)=1;
        end
    end
    highLine=equpt(log,:);
    equpt=equpt(~log,:);
    %ͬһ�߶ȵĵ������ٷֶ�
    [n,m]=size(highLine);
    num=[1];%��ߵ���
%     for i=11:n-11
% %         log=highLine(:,k)<(highLine(i,k)+5)&highLine(:,k)>(highLine(i,k)-5);
% %         comparePts=highLine(log,:);
%         comparePts=highLine((i-10):(i+10),:);
%         if (max(comparePts(:,3))==highLine(i,3))
%             num=[num,i];
%         end
%     end
    meanHighLine=[];
    for i=5:10:n-5
        meanH=[i,mean(highLine((i-4):(i+5),3))];
        meanHighLine=[meanHighLine;meanH];
    end
    
    
    for i=5:(length(meanHighLine)-5)
        comparePts=meanHighLine((i-4):(i+5),:);
        if(max(comparePts(:,2))==meanHighLine(i,2))
            index=meanHighLine(i,1);
            [maxH,indexH]=max(highLine((index-15):(index+15),3));
            num=[num,index-16+indexH];
        end
    end    
    %���ߵ�ֵ�
    for i=1:length(num)
        if i==length(num)
            pts=highLine(num(i):end,:);
            pts=headAndTail(pts,false);
            if i==1;
                pts=headAndTail(pts,true);
            end
            linept{j}=pts;
        else
            pts=highLine(num(i):num(i+1),:);
            if i==1;
                pts=headAndTail(pts,true);
            end
            linept{j}=pts;
        end
        j=j+1;
    end
end
end