function data = lasConvertCoordinates( data )
%LASCONVERTCOORDINATES Summary of this function goes here
%   Detailed explanation goes here

% update the points
for i = 1:numel( data.point )
    data.point( i ).x = data.point( i ).x * data.header.xScaleFactor + ...
        data.header.xOffset;
    data.point( i ).y = data.point( i ).y * data.header.yScaleFactor + ...
       data.header.yOffset;
    data.point( i ).z = data.point( i ).z * data.header.zScaleFactor + ...
       data.header.zOffset;
end
% update the header
data.header.xScaleFactor = 1.0;
data.header.yScaleFactor = 1.0;
data.header.zScaleFactor = 1.0;

data.header.xOffset = 0.0;
data.header.yOffset = 0.0;
data.header.zOffset = 0.0;
end

