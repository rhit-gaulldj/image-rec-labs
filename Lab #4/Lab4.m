%**************************************************************************
% Lab4.m
%
%   PROGRAM DESCRIPTION
%   see Lab4.docx
%
%   Output: 
%   
%
%   Written by Maria D. Beloreshka & Daniel Gaull
%   Date: 12/20/24
%**************************************************************************

clear variables;

img = imread('shapes.png');
img = img ~= 0;
%imshow(img);
shapes = bwlabel(img, 8);
numShapes = max(max(shapes));
for i = 1:numShapes
    if nnz(shapes == i) == 0
        continue;
    end
    [r, c] = find(shapes == i);
    cov = [r(:), c(:)];
    n = max(size(r));
    cov = cov - mean(cov);
    cov = transpose(cov) * cov;
    cov = cov ./ n;
    E = eig(cov);
    elongation = sqrt(max(E) / min(E));
    fprintf('Elongation of shape %d: %d\n', i, elongation);
    circularity = sum(sum(shapes == i)) * 4 * pi / (nnz(bwperim(shapes == i, 8)))^2;
    fprintf('Circularity of shape %d: %d\n', i, circularity);
end


