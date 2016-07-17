function [ class, synthetic, keypoint, withheld ] = lasClassification( in )
%LASCLASSIFICATION parses the 1byte input in into the classication and other flags
%
% DETAILED DESCRIPTION:
%   This function parses a 1 byte classification input into the
%   classification, synthetic, keypoint, and withheld fields
%
% INPUTS:
%   in: 1 byte containg the classification, synthetic, keypoint, and 
%       withheld fields from a las point of type 0-3. (see Table 1)
%
% OUTPUTS:
%   class: the ASPRS classification of the point (See Table 2).
%   sythetic: 1 if the point was created from something other than lidar
%   keypoint: 1 if a keypoint that should not be removed in data thinning
%   withheld: 1 if the point should not be used if further processing,
%       i.e., the point was deleted.
%
% HISTORY:
%   2013-07-23: Written by Paul Romanczyk (par4249 at rit dot edu)
% 
% DOCUMENTATION:
%                 Table 1: Classification Bit Field Encoding              
%   =======================================================================
%   Bits    Field Name      Description
%   -----------------------------------------------------------------------
%   0-4     Classification  Standard ASPRS classification as defined by the
%                           following classification table.
%   5       Synthetic       If set, then this point was created by a
%                           technique other than LIDAR collection such as 
%                           digitized from a photogrammetric stereo model.
%   6       Key-point       If set, this point is considered to be a model
%                           key-point and thus generally should not be 
%                           withheld in a thinning algorithm.
%   7       Withheld        If set, this point should not be included in
%                           processing (synonymous with Deleted).
%   =======================================================================                       
%
%                 Table 2: ASPRS Standard LIDAR Point Classes                            
%   =======================================================================
%   Classification      Meaning                             Footnote
%   Value (bits 1-4)
%   -----------------------------------------------------------------------
%   0                   Created, never classified
%   1                   Unclassified                        1
%   2                   Ground
%   3                   Low Vegetation
%   4                   Medium Vegetation
%   5                   High Vegetation
%   6                   Building
%   7                   Low Point (noise)
%   8                   Model Key-point (mass point)
%   9                   Water
%   10                  Reserved for ASPRS Definition
%   11                  Reserved for ASPRS Definition
%   12                  Overlap Points                      2
%   13-31               Reserved for ASPRS Definition
%   -----------------------------------------------------------------------
%   1: We are using both 0 and 1 as Unclassified to maintain compatibility 
%   with current popular classification software such as TerraScan. We 
%   extend the idea of classification value 1 to include cases in which 
%   data have been subjected to a classification algorithm but emerged in 
%   an undefined state. For example, data with class 0 is sent through an 
%   algorithm to detect man-made structures ? points that emerge without 
%   having been assigned as belonging to structures could be remapped from 
%   class 0 to class 1. 
%   2: Overlap Points are those points that were immediately culled during 
%   the merging of overlapping flight lines. In general, the Withheld bit 
%   should be set since these points are not subsequently classified.
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

% make sure we are a uint8 (1 byte)!
in = uint8( in );

% parse the data into its components
class = bitand( in, 31 );
synthetic = bitshift( bitand( in, 32 ), -5 );
keypoint = bitshift( bitand( in, 64 ), -6 );
withheld = bitshift( bitand( in, 128 ), -7 );

end

