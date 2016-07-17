function data = readLas( filename, firstPoint, numberOfPoints )
%READLAS Reads a las file 
%
% DETAILED DESCRIPTION:
%   This function reads an ASPRS las file of version 1.2 or less
%
% INPUTS:
%   filename: the name of the las file
%   firstPoint: (Optional) the index (starting at 0) of the first las point
%       to read
%   numberOfPoints: (Optional) The maximum number of points to read
%
% OUTPUTS:
%   data: a structure containing the las file
%   data.header: a structure containing the las public header
%   data.vlr: an array of structures containing variable length records
%   data.vlr(i): the ith variable length record
%   data.vlr(i).header: the header of the ith vlr
%   data.vlr(i).data: the variable length record data. Note that this will
%       most likely be a char array that will need data extracted from it
%   data.point: an array of point structures
%   data.point(i): the ith point
%
% HISTORY:
%   2013-07-23: Created by Paul Romanczyk (par4249 at rit dot edu)
%   2013-10-03: Modified by Paul Romanczyk
%       -Fixed a bug where a vlr was not properly initialized.
%       -Moved the helper functions inside the main files
%       -Added warning for las versions greater than 1.2
%       -Added RIT Copyright
%   2013-10-23: Modified by Paul Romanczyk
%       -Fixed some documentation issues
%
% REFERENCES:
%   http://asprs.org/Committee-General/LASer-LAS-File-Format-Exchange-Activities.html
%   http://asprs.org/a/society/committees/standards/asprs_las_format_v10.pdf
%   http://asprs.org/a/society/committees/standards/asprs_las_format_v11.pdf
%   http://asprs.org/a/society/committees/standards/asprs_las_format_v12.pdf
%
% WARNINGS:
%   This may not correctly read a las file of version 1.3 or later
%
% COPYRIGHT:
%   (C) 2013 Rochester Institute of Technology
%

if nargin < 2 
    firstPoint = 0;
end
if nargin < 3 
    numberOfPoints = inf;
end

fid = fopen( filename, 'r' );
if fid < 0
    error( 'readLas:invalidFile', ...
        [ '"' filename '" is not a valid file' ] );
end

% read the public header
data.header = readLasPublicHeader( fid );

if data.header.versionMajor > 1
    warning( 'readLas:v13', ...
            'This las file is greater than 1.2 and may not be read correctly' );
else
    if data.header.versionMinor > 2
        % > 1.2
        warning( 'readLas:v13', ...
            'This las file is greater than 1.2 and may not be read correctly' );
    end
end

% initialize the list of variable length records
if data.header.numberOfVariableLengthRecords == 0
    data.vlr = [];
else
    % create a temporary vlr to put into an array
    tmpvlr.header.reserved = 0;
    tmpvlr.header.userID = '';
    tmpvlr.header.recordID = 0;
    tmpvlr.header.recordLengthAfterHeader = 0;
    tmpvlr.header.description = '                                ';
    tmpvlr.data = '';
    
    data.vlr( data.header.numberOfVariableLengthRecords ) = tmpvlr;
    
    % read the variable length records
    for i = 1:data.header.numberOfVariableLengthRecords
        data.vlr( i ) = readLasVariableLengthData( fid );
    end
end

% figure out how many points will be read
n = min( [ numberOfPoints, data.header.numberOfPointRecords ] );

% move to the beginning of the point data
switch data.header.pointDataFormatID
    % advance to the beginning of the point Data
    case 0
        headerSize = 20;
    case 1
        headerSize = 28;
    case 2 
        headerSize = 26;
    case 3
        headerSize = 34;
    otherwise
        error( 'readLas:invalidPointType', ...
            [ 'The point data format id "' ...
            num2str( data.header.pointDataFormatID ) ...
            '" is not currently supported' ] );

end

if firstPoint > data.header.numberOfPointRecords
    error( 'readLas:invalidFirstPoint', ...
        'The first point is too big' );
end

fseek( fid, data.header.offsetToPointData + headerSize * firstPoint, ...
    'bof' );


% initialize the list of points
if data.header.numberOfPointRecords == 0
    data.point = [];
else
    switch data.header.pointDataFormatID
        % read the points.
        % the switch is outside the for loops to have fewer switch
        %   statements being used
        % the first point is put in the last element of the array to
        %   preallocate the array to the right size for efficiency
        case 0
            data.point( n ) = ...
                readLasPoint0( fid );
            for i = 2:n
                data.point( i - 1 ) = readLasPoint0( fid );
            end
        case 1
            data.point( n ) = ...
                readLasPoint1( fid );
            for i = 2:n
                data.point( i - 1 ) = readLasPoint1( fid );
            end
        case 2 
            data.point( n ) = ...
                readLasPoint2( fid );
            for i = 2:n
                data.point( i - 1 ) = readLasPoint2( fid );
            end
        case 3
            data.point( n ) = ...
                readLasPoint3( fid );
            for i = 2:n
                data.point( i - 1 ) = readLasPoint3( fid );
            end
        otherwise
            error( 'readLas:invalidPointType', ...
                [ 'The point data format id "' ...
                num2str( data.header.pointDataFormatID ) ...
                '" is not currently supported' ] );
    
    end
    % reorder the points
    data.point = [ data.point( 2:end ) data.point( 1 ) ];
end

fclose( fid );
end

% Read a type 0 las point
function point = readLasPoint0( fid )
    point.x = fread( fid, 1, 'int32' );
    point.y = fread( fid, 1, 'int32' );
    point.z = fread( fid, 1, 'int32' );
    point.intensity = fread( fid, 1, 'ushort' );
    point.returnInfo = fread( fid, 1 );
    point.classification = fread( fid, 1, 'uchar' );
    point.scanAngleRank = fread( fid, 1, 'uchar' );
    point.userData = fread( fid, 1, 'uchar' );
    point.sourceId = fread( fid, 1, 'ushort' );
end

% Read a type 1 las point
function point = readLasPoint1( fid )
    point.x = fread( fid, 1, 'int32' );
    point.y = fread( fid, 1, 'int32' );
    point.z = fread( fid, 1, 'int32' );
    point.intensity = fread( fid, 1, 'ushort' );
    point.returnInfo = fread( fid, 1 );
    point.classification = fread( fid, 1, 'uchar' );
    point.scanAngleRank = fread( fid, 1, 'uchar' );
    point.userData = fread( fid, 1, 'uchar' );
    point.sourceId = fread( fid, 1, 'ushort' );
    point.gpsTime = fread( fid, 1, 'double' );
end

% Read a type 2 las point
function point = readLasPoint2( fid )
    point.x = fread( fid, 1, 'int32' );
    point.y = fread( fid, 1, 'int32' );
    point.z = fread( fid, 1, 'int32' );
    point.intensity = fread( fid, 1, 'ushort' );
    point.returnInfo = fread( fid, 1 );
    point.classification = fread( fid, 1, 'uchar' );
    point.scanAngleRank = fread( fid, 1, 'uchar' );
    point.userData = fread( fid, 1, 'uchar' );
    point.sourceId = fread( fid, 1, 'ushort' );
    point.red = fread( fid, 1, 'ushort' );
    point.green = fread( fid, 1, 'ushort' );
    point.blue = fread( fid, 1, 'ushort' );
end

% Read a type 3 las point
function point = readLasPoint3( fid )
    point.x = fread( fid, 1, 'int32' );
    point.y = fread( fid, 1, 'int32' );
    point.z = fread( fid, 1, 'int32' );
    point.intensity = fread( fid, 1, 'ushort' );
    point.returnInfo = fread( fid, 1 );
    point.classification = fread( fid, 1, 'uchar' );
    point.scanAngleRank = fread( fid, 1, 'uchar' );
    point.userData = fread( fid, 1, 'uchar' );
    point.sourceId = fread( fid, 1, 'ushort' );
    point.gpsTime = fread( fid, 1, 'double' );
    point.red = fread( fid, 1, 'ushort' );
    point.green = fread( fid, 1, 'ushort' );
    point.blue = fread( fid, 1, 'ushort' );
end

% Read a las public header
function header = readLasPublicHeader( fid )
    header.fileSignature = char( fread( fid, 4 )' );
    header.fileSourceID = fread( fid, 1, 'ushort' );
    header.globalEncoding = fread( fid, 1, 'ushort' );
    header.projectID1 = fread( fid, 1, 'uint32' );
    header.projectID2 = fread( fid, 1, 'ushort' );
    header.projectID3 = fread( fid, 1, 'ushort' );
    header.projectID4 = char( fread( fid, 8 )' );
    header.versionMajor = fread( fid, 1 );
    header.versionMinor = fread( fid, 1 );
    header.systemIdentifier = char( fread( fid, 32 )' );
    header.generatingSoftware = char( fread( fid, 32 )' );
    header.fileCreationDayOfYear = fread( fid, 1, 'ushort' );
    header.fileCreationYear = fread( fid, 1, 'ushort' );
    header.headerSize = fread( fid, 1, 'ushort' );
    header.offsetToPointData = fread( fid, 1, 'uint32' );
    header.numberOfVariableLengthRecords = fread( fid, 1, 'uint32' );
    header.pointDataFormatID = fread( fid, 1, 'uchar' );
    header.pointDataRecordLength = fread( fid, 1, 'ushort' );
    header.numberOfPointRecords = fread( fid, 1, 'uint32' );
    header.numberOfPointsByReturn = fread( fid, 5, 'uint32' )';
    header.xScaleFactor = fread( fid, 1, 'double' );
    header.yScaleFactor = fread( fid, 1, 'double' );
    header.zScaleFactor = fread( fid, 1, 'double' );
    header.xOffset = fread( fid, 1, 'double' );
    header.yOffset = fread( fid, 1, 'double' );
    header.zOffset = fread( fid, 1, 'double' );
    header.maxX = fread( fid, 1, 'double' );
    header.minX = fread( fid, 1, 'double' );
    header.maxY = fread( fid, 1, 'double' );
    header.minY = fread( fid, 1, 'double' );
    header.maxZ = fread( fid, 1, 'double' );
    header.minZ = fread( fid, 1, 'double' );
end

% Read a variable length record
function vlData = readLasVariableLengthData( fid )
    % read the header
    vlData.header = readLasVariableLengthHeader( fid );

    % read the data
    vlData.data = fread( fid, vlData.header.recordLengthAfterHeader );
end

% Read a variable length record header
function vlHeader = readLasVariableLengthHeader( fid )
    vlHeader.reserved = fread( fid, 1, 'ushort' );
    vlHeader.userID = char( fread( fid, 16 )' );
    vlHeader.recordID = fread( fid, 1, 'ushort' );
    vlHeader.recordLengthAfterHeader = fread( fid, 1, 'ushort' );
    vlHeader.description = char( fread( fid, 32 )' );
end