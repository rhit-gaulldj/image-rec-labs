% toyProblem.m
% Written by Matthew Boutell, updated Jan 2020.
% Feel free to distribute at will.
clear all;
% We fix the seeds so the data sets are reproducible
seedTrain = 136;
seedTest = 137;
[xTrain, yTrain] = GenerateTrainingSet(seedTrain, 'Training set');
[xTest, yTest] = GenerateTestingSet(seedTest, 'Test set');


% Add your SVM code here.



% Uncomment and run this on a trained network called net 
% to see the resulting boundary (as in the demo)
% % selecting the existing figure with the data plotted on it before
% % calling plotboundary will cause
% % the contours to be plotted together with the data
% figure(seedTrain)
% plotboundary(net, [0,100], [0,100])
