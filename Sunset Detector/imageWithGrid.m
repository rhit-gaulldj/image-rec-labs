
img = imread('images/train/sunset/8591064132_994fe0f0bf_z.jpg');

figure;
imshow(img);
[rows, cols, ~] = size(img);

hold on;
rowSpacing = rows / 7;
colSpacing = cols / 7;
for row = 1:rowSpacing:rows
    line([1, cols], [row, row], 'Color', 'r', 'LineWidth', 1);
end
for col = 1:colSpacing:cols
    line([col, col], [1, rows], 'Color', 'r', 'LineWidth', 1);
end
