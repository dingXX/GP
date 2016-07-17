function [ returnNumber, numberOfReturns, scanDirectionFlag, edgeOfFlightLine ] = lasParseReturns( returnInfo )
%LASPARSERETURNS Parses the las return byte into its compoents
%
% DETAILED DESCRIPTION:
%   This function parses the return byte into the return number, number of
%   returns, scan direction flag, and edgeOfFlightLine.
%
% INPUTS:
%   returnInfo: 1 byte containing return number, number of returns, scan 
%       direction flag, and edgeOfFlightLine for las point types 0-3.
%
% OUTPUTS:
%   returnNumber: The return number 
%   numberOfReturns: The number of returns per outgoing pulse
%   scanDirectionFlag: 1 for positive scan direction, 0 for negative scan
%       direction
%   EdgeOfFlightLine: 1 if the point is at the end of a scan line
%
% HISTORY:
%   2013-07-23: Written by Paul Romanczyk (par4249 at rit dot edu)
% 
% DOCUMENTATION:
%                      Table 1: Return Bit Field Encoding                                                  
%   =======================================================================
%   Bits    Field Name      Description
%   -----------------------------------------------------------------------
%   0-2 Return Number        The Return Number is the pulse return number 
%                            for a given output pulse. A given output laser 
%                            pulse can have many returns, and they must be 
%                            marked in sequence of return. The first return 
%                            will have a Return Number of one, the second a 
%                            Return Number of two, and so on up to five 
%                            returns.
%   3-5 Number of Returns    The Number of Returns is the total number of 
%                            returns for a given pulse. For example, a 
%                            laser data point may be return two (Return 
%                            Number) within a total number of five returns.
%   6   Scan Direction Flag  The Scan Direction Flag denotes the direction  
%                            at which the scanner mirror was traveling at
%                            the output the time of pulse. A bit value of 1 
%                            is a positive scan direction, and a bit value 
%                            of 0 is a negative scan direction (where 
%                            positive scan direction is a scan moving from 
%                            the left side of the in-track direction to the 
%                            right side and negative the opposite).
%   7   Edge of Flight Line  The Edge of Flight Line data bit has a value  
%                            of 1 only when the point is at the end of a 
%                            scan. It is the last point on a given scan 
%                            line before it changes direction.
%   =======================================================================                       
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

% make sure we are a uint8
returnInfo = uint8( returnInfo );

% get components
returnNumber = bitand( returnInfo, 7 );
numberOfReturns = bitshift( bitand( returnInfo, 56 ), -3 );
scanDirectionFlag = logical( bitshift( bitand( returnInfo, 64 ), -6 ) );
edgeOfFlightLine = logical( bitshift( bitand( returnInfo, 128 ), -7 ) );

end

