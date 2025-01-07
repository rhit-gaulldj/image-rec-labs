function [X, Y] = GenerateTrainingSet(seed, myTitle);
% Assume you have N total training points and each feature vector
% is of dimension D.
% X, the matrix of feature vectors, is an NxD matrix with one feature
% vector per row.
% Y, the label of each point, is a Nx1 matrix with one label per row. 
rng('default')
rng(seed)

% npts, cls, xmin, xmax, ymin, ymax
[x1,y1] = GenerateOneUniformCluster(80, -1, 50, 100,  0,  50);
[x2,y2] = GenerateOneUniformCluster(20, -1, 25,  50,  0,  25);
[x3,y3] = GenerateOneUniformCluster(20,  1,  0,  25,  0,  25);
[x4,y4] = GenerateOneUniformCluster(40,  1,  0,  50, 25,  50);
[x5,y5] = GenerateOneUniformCluster(20, -1,  0,  25, 50,  75);
[x6,y6] = GenerateOneUniformCluster(40, -1, 25,  50, 50, 100);
[x7,y7] = GenerateOneUniformCluster(20,  1,  0,  25, 75, 100);
[x8,y8] = GenerateOneUniformCluster(20,  1, 50,  75, 50,  75);
[x9,y9] = GenerateOneUniformCluster(40,  1, 75, 100, 50, 100);
[x10,y10] = GenerateOneUniformCluster(20,  -1, 50, 75, 75, 100);


X = [x1; x2; x3; x4; x5; x6; x7; x8; x9; x10];
Y = [y1; y2; y3; y4; y5; y6; y7; y8; y9; y10];

pos = find(Y > 0);
xPos = X(pos,:);
yPos = Y(pos,:);

neg = find(Y <= 0);
xNeg = X(neg,:);
yNeg = Y(neg,:);

figure(seed);
hold on;

plot(xPos(:,1), xPos(:,2), 'ro', xNeg(:,1),xNeg(:,2), 'bx');
axis([0 100 0 100]);
axis xy;
title(myTitle);
hold off;

fprintf('Red are positive samples (label=+1)\n');
fprintf('Blue are negative samples (label=-1)\n');

end

