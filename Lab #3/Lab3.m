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
%imshow(smoothImg);

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

uniform_filtered = imfilter(grayImg, [1 1 1; 1 1 1; 1 1 1]/9);

[horizontal_edge, vertical_edge, sum, mag, direction, direction_strong] = sobel(grayImg);

figure;
sgtitle('Unfiltered');
subplot(2,4,1); imshow(grayImg); title('Original')
subplot(2,4,2); imshow(horizontal_edge); title('Horizontal Filter')
subplot(2,4,3); imshow(vertical_edge); title('Vertical Filter')
subplot(2,4,4); imshow(sum); title('Sum')
subplot(2,4,5); imshow(mag); title('Magnitude')
subplot(2,4,6); imshow(direction); title('Direction')
subplot(2,4,7); imshow(direction_strong); title('Direction Strong')

[horizontal_edge, vertical_edge, sum, mag, direction, direction_strong] = sobel(approx_filtered);

figure;
sgtitle('Approximate Gaussian Filter');
subplot(2,4,1); imshow(gfiltered); title('Original')
subplot(2,4,2); imshow(horizontal_edge); title('Horizontal Filter')
subplot(2,4,3); imshow(vertical_edge); title('Vertical Filter')
subplot(2,4,4); imshow(sum); title('Sum')
subplot(2,4,5); imshow(mag); title('Magnitude')
subplot(2,4,6); imshow(direction); title('Direction')
subplot(2,4,7); imshow(direction_strong); title('Direction Strong')

[horizontal_edge, vertical_edge, sum, mag, direction, direction_strong] = sobel(true_filtered);

figure;
sgtitle('Gaussian Filter');
subplot(2,4,1); imshow(true_filtered); title('Original')
subplot(2,4,2); imshow(horizontal_edge); title('Horizontal Filter')
subplot(2,4,3); imshow(vertical_edge); title('Vertical Filter')
subplot(2,4,4); imshow(sum); title('Sum')
subplot(2,4,5); imshow(mag); title('Magnitude')
subplot(2,4,6); imshow(direction); title('Direction')
subplot(2,4,7); imshow(direction_strong); title('Direction Strong')

[horizontal_edge, vertical_edge, sum, mag, direction, direction_strong] = sobel(uniform_filtered);

figure;
sgtitle('Uniform Filter');
subplot(2,4,1); imshow(uniform_filtered); title('Original')
subplot(2,4,2); imshow(horizontal_edge); title('Horizontal Filter')
subplot(2,4,3); imshow(vertical_edge); title('Vertical Filter')
subplot(2,4,4); imshow(sum); title('Sum')
subplot(2,4,5); imshow(mag); title('Magnitude')
subplot(2,4,6); imshow(direction); title('Direction')
subplot(2,4,7); imshow(direction_strong); title('Direction Strong')

