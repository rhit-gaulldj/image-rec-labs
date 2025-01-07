function [fv, label] = GenerateOneUniformCluster(nPts, cls, xmin, xmax, ymin, ymax)
x = rand([nPts,1]) * (xmax-xmin) + xmin;
y = rand([nPts,1]) * (ymax-ymin) + ymin;
fv = [x, y];
label = ones(nPts, 1)*cls;
end

