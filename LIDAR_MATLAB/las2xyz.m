function [xyz ] = las2xyz( data )
%LAS2XYZ Converts as las structure to x, y, z vectors
%
% DETAILED DESCRIPTION:
%   This function converts a las structure (read by readLas) into x, y, and 
%   z vectors. This assumes the data are discrete.
%
% INPUTS:
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
% OUTPUTS:
%   x: an n x 1 vector containing the x values
%   y: an n x 1 vector containing the y values
%   z: an n x 1 vector containing the z values
%
% REQUIRED FUNCTIONS:
%   lasConvertCoordinates.m: converts the coordinates from the longs 
%
% HISTORY:
%   2013-07-23: Written by Paul Romanczyk (par4249 at rit dot edu)
%
% REFERENCES:
%   http://asprs.org/Committee-General/LASer-LAS-File-Format-Exchange-Activities.html
%   http://asprs.org/a/society/committees/standards/asprs_las_format_v10.pdf
%   http://asprs.org/a/society/committees/standards/asprs_las_format_v11.pdf
%   http://asprs.org/a/society/committees/standards/asprs_las_format_v12.pdf
%
% TODO:
%   I probably should add outputs of las attributes such as intensity.
%
% COPYRIGHT:
%   (C) 2013 Rochester Institute of Technology
%

% how many points do we have?
n = length(data.point);

% convert the coordinates!
%   - las stores x, y, z values as longs. There are x, y, and z scales and
%   translations in the header. This conversion puts the data into real
%   world coordinates
data = lasConvertCoordinates( data );

% preallocate some arrays
x = zeros( n, 1 );
y = zeros( n, 1 );
z = zeros( n, 1 );

for i = 1:n
    x(i) = data.point( i ).x;
    y(i) = data.point( i ).y;
    z(i) = data.point( i ).z;
end
xyz=[x,y,z];

end

