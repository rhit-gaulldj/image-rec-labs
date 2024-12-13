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
%imshow(img);
grayImg = rgb2gray(img);
%imshow(grayImg);

filt = ones(3,3)/9; % equivalent to [1/9 1/9 1/9;  1/9 1/9 1/9; 1/9 1/9 1/9]
smoothImg = filter2(filt, grayImg); % applies the filter
figure;
imshow(smoothImg);

gfilter = [1 4 6 4 1; 4 16 24 16 4;6 24 36 24 6; 4 16 24 16 4; 1 4 6 4 1]/256;
%figure;
%mesh(gfilter);
trueGaussian = fspecial('gaussian', 5);
%figure;
%mesh(trueGaussian);

true_filtered = imfilter(grayImg,trueGaussian);
figure;
imshow(true_filtered);
approx_filtered = imfilter(grayImg, gfilter);
figure;
imshow(approx_filtered);
