img = imread('shapes.png');
img = img ~= 0;
%imshow(img);
shapes = bwlabel(img, 8);
numShapes = max(max(shapes));
for i = 0:numShapes
    [r, c] = find(shapes == i);
    cov = [r(:), c(:)];
    n = max(size(r));
    cov = cov - mean(cov);
    cov = transpose(cov) * cov;
    cov = cov ./ n;
    E = eig(cov);
    elongation = sqrt(max(E) / min(E));
    fprintf('Elongation of shape %d: %d\n', i, elongation);
    circularity = sum(sum(shapes == i)) * 4 * pi / perimeter(shapes == i, 8);
    fprintf('Circularity of shape %d: %d\n', i, circularity);
end