function [horizontal_edge, vertical_edge, sum, mag, direction, direction_strong] = sobel(img)

horizontal_filter = [-1 0 1; -2 0 2; -1 0 1]/8; 
vertical_filter = [1 2 1; 0 0 0 ; -1 -2 -1]/8;
horizontal_edge = filter2(horizontal_filter, img);
vertical_edge = filter2(vertical_filter, img);
sum = horizontal_edge + vertical_edge;
mag = sqrt(horizontal_edge.^2 + vertical_edge.^2);
direction = atan2(horizontal_edge, vertical_edge);
dummy = direction;
direction_strong 