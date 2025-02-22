% toyProblem.m
% Written by Matthew Boutell, updated Jan 2020.
% Added onto by Daniel Gaull and Maria Beloreshka Jan 2025
% Feel free to distribute at will.
clear all;
% We fix the seeds so the data sets are reproducible
seedTrain = 136;
seedTest = 137;
[xTrain, yTrain] = GenerateTrainingSet(seedTrain, 'Training set');
[xTest, yTest] = GenerateTestingSet(seedTest, 'Test set');


% Add your SVM code here.
model = fitcsvm(xTrain,yTrain,'KernelFunction','RBF', 'Standardize',false, ...
    'ClassNames',[-1, 1], 'BoxConstraint',10,'KernelScale',20);
[detectedClasses, distances] = predict(model, xTest);
ysz = size(yTest);
accuracy = sum(yTest == detectedClasses) / ysz(1) * 100;
fprintf('Accuracy: %f%%.\n', accuracy);
percent_support_vectors = size(model.SupportVectors, 1) / ysz(1) * 100;
fprintf('Percent Support Vectors: %f%%.\n', percent_support_vectors);

confusionmat(yTest, detectedClasses)


% Uncomment and run this on a trained network called net 
% to see the resulting boundary (as in the demo)
% selecting the existing figure with the data plotted on it before
% calling plotboundary will cause
% the contours to be plotted together with the data
figure(seedTrain);
plotboundary(model, [0,100], [0,100]);
figure(seedTest);
plotboundary(model, [0,100], [0,100]);
