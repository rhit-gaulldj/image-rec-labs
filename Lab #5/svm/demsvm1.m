%function demsvm1()
% DEMSVM1 - Demonstrate basic Support Vector Machine classification
% 
%   DEMSVM1 demonstrates the classification of a simple artificial data
%   set by a Support Vector Machine classifier, using different kernel
%   functions.
%
%   See also
%   SVM, SVMTRAIN, SVMFWD, SVMKERNEL, DEMSVM2
%

% 
% Copyright (c) Anton Schwaighofer (2001) 
% This program is released unter the GNU General Public License.
% 
% Changed to use MATLAB built-in functions for SVM, 2017,
% Matt Boutell, Rose-Hulman Institute of Technology.



 

X = [2 7; 3 6; 2 2; 8 1; 6 4; 4 8; 9 5; 9 9; 9 4; 6 9; 7 4];
Y = [ +1;  +1;  +1;  +1;  +1;  -1;  -1;  -1;  -1;  -1;  -1];
%X = [2 7; 3 6; 2 2; 4 8; 9 5; 9 9; 9 4; 6 9; 7 4];
%Y = [ +1;  +1;  +1;  -1;  -1;  -1;  -1;  -1;  -1];
% define a simple artificial data set

x1ran = [0 10];
x2ran = [0 10];
% range for plotting the data set and the decision boundary

disp(' ');
disp('This demonstration illustrates the use of a Support Vector Machine');
disp('(SVM) for classification. The data is a set of 2D points, together');
disp('with target values (class labels) +1 or -1.');
disp(' ');
disp('The data set consists of the points');

ind = [1:length(Y)]';
fprintf('X%2i = (%2i, %2i) with label Y%2i = %2i\n', [ind, X, ind, Y]');
disp(' ')
disp('Press any key to plot the data set');
pause

f1 = figure;
plotdata(X, Y, x1ran, x2ran);
title('Data from class +1 (squares) and class -1 (crosses)');

fprintf('\n\n\n\n');
fprintf('The data is plotted in figure %i, where\n', f1.Number);
disp('  squares stand for points with label Yi = +1');
disp('  crosses stand for points with label Yi = -1');
disp(' ')
disp(' ');
disp('Now we train a Support Vector Machine classifier on this data set.');
disp('We use the most simple kernel function, namely the inner product');
disp('of points Xi, Xj (linear kernel K(Xi,Xj) = Xi''*Xj )');
disp(' ');
disp('Press any key to start training')
pause

net = fitcsvm(X,Y,'KernelFunction','linear', 'Standardize',false, ...
    'ClassNames',[-1, 1], 'BoxConstraint',10);

% Currently just classifies the training set to show example use of predict. 
[detectedClasses, distances] = predict(net, X);

for i = 1:length(Y)
    fprintf('Point %d, True class: %d, detected class: %d, distance: %0.2f\n', i, Y(i), detectedClasses(i), distances(i,2))
end

f2 = figure;
plotboundary(net, x1ran, x2ran);
plotdata(X, Y, x1ran, x2ran);
plotsv(net, X, Y);
title(['SVM with linear kernel: decision boundary (black) plus Support' ...
       ' Vectors (red)']);

fprintf('\n\n\n\n');
fprintf('The resulting decision boundary is plotted in figure %i.\n', f2.Number);
disp('The contour plotted in black separates class +1 from class -1');
disp('(this is the actual decision boundary)');
disp('The contour plotted in red are the points at distance +1 from the');
disp('decision boundary, the blue contour are the points at distance -1.');
disp(' ');
disp('All examples plotted in red are found to be Support Vectors.');
disp('Support Vectors are the examples at distance +1 or -1 from the ');
disp('decision boundary and all the examples that cannot be classified');
disp('correctly.');
disp(' ');
disp('The data set shown can be correctly classified using a linear');
disp('kernel. This can be seen from the coefficients alpha associated');
disp('with each example: The coefficients are');
ind = [1:length(Y)]';
 
fprintf('  Example %2i: alpha%2i = %5.2f\n', [ind, ind, getAllAlphas(net)]');
disp('The upper bound for the coefficients has been set to');
fprintf('BoxConstraints = %5.2f. None of the coefficients are at the bound,\n', ...
	net.BoxConstraints(1));
disp('this means that all examples in the training set can be correctly');
disp('classified by the SVM.')
disp(' ');
disp('Press any key to continue')
pause



X = [X; [4 4]];
Y = [Y; -1];


net = fitcsvm(X, Y, 'KernelFunction', 'linear', 'BoxConstraint', 10);

f3 = figure;
plotboundary(net, x1ran, x2ran);
plotdata(X, Y, x1ran, x2ran);
plotsv(net, X, Y);
title(['SVM with linear kernel: decision boundary (black) plus Support' ...
       ' Vectors (red)']);

fprintf('\n\n\n\n');
disp('Adding an additional point X12 with label -1 gives a data set');
disp('that can not be linearly separated. The SVM handles this case by');
disp('allowing training points to be misclassified.');
disp(' ');
disp('Training the SVM on this modified data set we see that the points');
disp('X5, X11 and X12 can not be correctly classified. The decision');
fprintf('boundary is shown in figure %i.\n', f3.Number);
disp('The coefficients alpha associated with each example are');
ind = [1:length(Y)]';
fprintf('  Example %2i: alpha%2i = %5.2f\n', [ind, ind, getAllAlphas(net)]');
disp('The coefficients of the misclassified points are at the upper');
disp('bound of the BoxConstraint.');
disp(' ')
disp('Press any key to continue')
pause


fprintf('\n\n\n\n');
disp('Adding the new point X12 has lead to a more difficult data set');
disp('that can no longer be separated by a simple linear kernel.');
disp('We can now switch to a more powerful kernel function, namely');
disp('the Radial Basis Function (RBF) kernel.');
disp(' ')
disp('The RBF kernel has an associated parameter, the kernel width.');
disp('We will now show the decision boundary obtained from a SVM with');
disp('RBF kernel for 3 different values of the kernel width.');
disp(' ');
disp('Press any key to continue')
pause


kernelScale = 4;

net = fitcsvm(X, Y, 'KernelFunction', 'rbf', 'KernelScale', kernelScale, 'BoxConstraint', 100); 
f4 = figure;
plotboundary(net, x1ran, x2ran);
plotdata(X, Y, x1ran, x2ran);
plotsv(net, X, Y);
title(sprintf('SVM with RBF kernel, width %.1f: decision boundary (black) plus Support Vectors (red)', kernelScale)); 

fprintf('\n\n\n\n');
fprintf('Figure %i shows the decision boundary obtained from a SVM\n', ...
	f4.Number);
disp('with Radial Basis Function kernel, the kernel width has been');
fprintf('set to %.1f.', kernelScale);
disp('The SVM now interprets the new point X12 as evidence for a');
disp('cluster of points from class -1, the SVM builds a small ''island''');
disp('around X12.');
disp(' ')
disp('Press any key to continue')
pause


kernelScale = 1.5;
net = fitcsvm(X, Y, 'KernelFunction', 'rbf', 'KernelScale', kernelScale, 'BoxConstraint', 100); 

f5 = figure;
plotboundary(net, x1ran, x2ran);
plotdata(X, Y, x1ran, x2ran);
plotsv(net, X, Y);
title(sprintf('SVM with RBF kernel, width %.1f: decision boundary (black) plus Support Vectors (red)', kernelScale)); 
   
fprintf('\n\n\n\n');
fprintf('Figure %i shows the decision boundary obtained from a SVM\n', ...
	f5.Number);
fprintf('with radial basis function kernel, kernel width %.1f.\n', kernelScale);
disp('The decision boundary is now highly shattered, since a smaller');
disp('kernel width allows the decision boundary to be more curved.');
disp(' ')
disp('Press any key to continue')
pause


kernelScale = 9;
net = fitcsvm(X, Y, 'KernelFunction', 'rbf', 'KernelScale', kernelScale, 'BoxConstraint', 100); 

f6 = figure;
plotboundary(net, x1ran, x2ran);
plotdata(X, Y, x1ran, x2ran);
plotsv(net, X, Y);
title(sprintf('SVM with RBF kernel, width %.1f: decision boundary (black) plus Support Vectors (red)', kernelScale)); 

fprintf('\n\n\n\n');
fprintf('Figure %i shows the decision boundary obtained from a SVM\n', ...
	f6.Number);
fprintf('with radial basis function kernel, kernel width %.1f.\n', kernelScale);
disp('This gives a decision boundary similar to the one shown in');
fprintf('Figure %i for the SVM with linear kernel.\n', f2.Number);

fprintf('\n\n\n\n');
disp('Press any key to end the demo')
pause

delete(f1);
delete(f2);
delete(f3);
delete(f4);
delete(f5);
delete(f6);
close all

function plotdata(X, Y, x1ran, x2ran)
% PLOTDATA - Plot 2D data set
% 

hold on;
ind = find(Y>0);
plot(X(ind,1), X(ind,2), 'ks');
ind = find(Y<0);
plot(X(ind,1), X(ind,2), 'kx');
text(X(:,1)+.2,X(:,2), int2str([1:length(Y)]'));
axis([x1ran x2ran]);
axis xy;
end

function plotsv(net, X, Y)
% PLOTSV - Plot Support Vectors
% 
hold on;
% Plot the support vectors.
posSV = net.SupportVectors(find(net.SupportVectorLabels > 0), :);
plot(posSV(:,1),posSV(:,2), 'rs');
negSV = net.SupportVectors(find(net.SupportVectorLabels < 0), :);
plot(negSV(:,1),negSV(:,2), 'rx');
end

function [x11, x22, x1x2out] = plotboundary(net, x1ran, x2ran)
% PLOTBOUNDARY - Plot SVM decision boundary on range X1RAN and X2RAN
% 

hold on;
nbpoints = 100;
x1 = x1ran(1):(x1ran(2)-x1ran(1))/nbpoints:x1ran(2);
x2 = x2ran(1):(x2ran(2)-x2ran(1))/nbpoints:x2ran(2);
[x11, x22] = meshgrid(x1, x2);
[dummy, x1x2out] = predict(net, [x11(:),x22(:)]);
x1x2out = x1x2out(:,2);
x1x2out = reshape(x1x2out, [length(x1) length(x2)]);
contour(x11, x22, x1x2out, [-0.99 -0.99], 'b-');
contour(x11, x22, x1x2out, [0 0], 'k-');
contour(x11, x22, x1x2out, [0.99 0.99], 'g-');
end

function [allAlphas] = getAllAlphas(net)
% Maps for example, from boolean 1 1 0 1 0 0] 
% and a dense matrix [a1, a2, a3] to
% [a1, a2, 0 a3, 0, 0] 
allAlphas = zeros(net.NumObservations, 1);
svIdx = 1;
for i = 1:length(allAlphas)
   if net.IsSupportVector(i)
       allAlphas(i) = net.Alpha(svIdx);
       svIdx = svIdx + 1;
   end
end





end


