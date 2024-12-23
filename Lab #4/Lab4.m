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

img = imread('shapes.png');
img = img ~= 0; % Binarize image
shapes = bwlabel(img, 8); % Label connected components
numShapes = max(shapes(:));

% elongation and circularity images
elongationImg = zeros(size(img));
circularityImg = zeros(size(img));

figure;
subplot(2, 2, 1);
imshow(img);
title('Elongation');
hold on;

subplot(2, 2, 2);
imshow(img);
title('Circularity');
hold on;

subplot(2, 2, 3);
imshow(img);
title('Classification');
hold on;

for i = 1:numShapes
    if nnz(shapes == i) == 0
        continue;
    end
    
    % shape pixels
    [r, c] = find(shapes == i);
    shapePixels = [r, c];

    % elongation
    n = size(shapePixels, 1);
    shapePixels = shapePixels - mean(shapePixels);
    covarianceMatrix = (shapePixels' * shapePixels) / n;
    eigenvalues = eig(covarianceMatrix);
    elongation = sqrt(max(eigenvalues) / min(eigenvalues));

    % circularity
    %perimeter = nnz(bwperim(shapes == i, 8));
    perimeterSet = bwtraceboundary(shapes == i, [r(1), c(1)], "S");
    perimeter = 0;
    for j = 2:length(perimeterSet)
        cr = perimeterSet(j,1);
        cc = perimeterSet(j,2);
        pr = perimeterSet(j-1,1);
        pc = perimeterSet(j-1,2);
        if cr == pr || cc == pc
            perimeter = perimeter + 1;
        else
            perimeter = perimeter + sqrt(2);
        end
    end
    area = sum(shapes(:) == i);
    circularity = (4 * pi * area) / (perimeter^2);

    if elongation > 0 && elongation < 1.03
        if circularity > 0.85
            classification = 'circle';
        else
            classification = 'square';
        end
    else
        if circularity > 0.76
            classification = 'ellipse';
        else
            classification = 'rectangle';
        end
    end

    % elongation value to the elongation image
    elongationImg(r, c) = elongation;
    subplot(2, 2, 1);
    text(mean(c), mean(r), sprintf('%.2f', elongation), 'Color', 'r', 'FontSize', 10, 'HorizontalAlignment', 'center');

    % circularity value to the circularity image
    circularityImg(r, c) = circularity;
    subplot(2, 2, 2);
    text(mean(c), mean(r), sprintf('%.2f', circularity), 'Color', 'g', 'FontSize', 10, 'HorizontalAlignment', 'center');

    % classification value to the classification image
    subplot(2, 2, 3);
    text(mean(c), mean(r), sprintf('%s', classification), 'Color', 'b', 'FontSize', 10, 'HorizontalAlignment', 'center');

    %fprintf('Shape %d: Elongation = %.2f, Circularity = %.2f, Classification = %.2f\n', i, elongation, circularity, classification);
end

hold off;
