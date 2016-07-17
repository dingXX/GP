function header = readLasHeader( filename )
%READLAS Reads a las file 
%
% DETAILED DESCRIPTION:
%   This function reads an ASPRS las file header
%
% INPUTS:
%   filename: the name of the las file
%
% OUTPUS:
%   header: a structure containing the las public header
%
% HISTORY:
%   2013-07-23: Created by Paul Romanczyk (par4249 at rit dot edu)
%   2013-10-03: Modified by Paul Romanczyk
%       -Moved the helper functions inside the main files
%       -Added RIT Copyright
%
% REFERENCES:
%   http://asprs.org/Committee-General/LASer-LAS-File-Format-Exchange-Activities.html
%   http://asprs.org/a/society/committees/standards/asprs_las_format_v10.pdf
%   http://asprs.org/a/society/committees/standards/asprs_las_format_v11.pdf
%   http://asprs.org/a/society/committees/standards/asprs_las_format_v12.pdf
%
% COPYRIGHT:
%   (C) 2013 Rochester Institute of Technology
%


fid = fopen( filename, 'r' );
if fid < 0
    error( 'readLasHeader:invalidFile', ...
        [ '"' filename '" is not a valid file' ] );
end

% read the public header
header = readLasPublicHeader( fid );

fclose( fid );

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