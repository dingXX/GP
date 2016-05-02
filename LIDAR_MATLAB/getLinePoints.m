function [ linePoints ] = getLinePoints( points,lines )
%getLinePoints �ҳ���ֱ�߷��̸����ĵ����ߵ���
%points ���еĵ����ߵ��Ƶ�
%lines ������ֱ�߷���
%linePoints linePoints.line ֱ�߷��� linePoints.points cell��ʽ������ÿ�����������ߵĵ�
for i=1:length(lines)
    %����ֱ�߷���
    linePoints(i).line=lines(i); 
    % x��ķ�Χ �����ľ�������1
    xrange=sort([lines(i).point1(1),lines(i).point2(1)]);
    xrange=[xrange(1)-1,xrange(2)+1];
    % y��ķ�Χ �����ľ�������1
    yrange=sort([lines(i).point1(2),lines(i).point2(2)]);
    yrange=[yrange(1)-1,yrange(2)+1];
    % ����ֱ�ߵľ���d
    points(:,4)=abs(lines(i).a*points(:,1)+lines(i).b*points(:,2)+lines(i).c)/sqrt(lines(i).a^2+lines(i).b^2);
    log=points(:,4)<0.5&points(:,1)>xrange(1)&points(:,1)<xrange(2)&points(:,2)>yrange(1)&points(:,2)<yrange(2);
    %���̵�
    equPoints=points(log,1:3);
    linePoints(i).points=equpt2linept(equPoints);
    %linePoints(i).points=points(log,:);
    points=points(~log,:);
end
end
