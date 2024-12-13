%**************************************************************************
% Lab3.m
%
%   PROGRAM DESCRIPTION
%   see Lab3.docx
%
%   Output: 
%   
%
%   Written by Maria D. Beloreshka & Daniel Gaull
%   Date: 12/13/24
%**************************************************************************
 
img = imread('./nyc_times_square.jpg');
imshow(img);

filt = ones(3,3)/9; % equivalent to [1/9 1/9 1/9;  1/9 1/9 1/9; 1/9 1/9 1/9]
smoothImg = filter2(filt, grayImg); % applies the filter
imtool(img); imtool(uint8(smoothImg));
