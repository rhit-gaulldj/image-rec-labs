%**************************************************************************
% SunsetDetectorPt2b.m
%
%   PROGRAM DESCRIPTION
%   Feature extraction method to be fed into SVM for Sunset Detector Pt. 2
%   Project using AlexNet.
%
%   Output: 
%
%   Written by Daniel Gaull & Maria D. Beloreshka
%   Date: 01/25/25
%**************************************************************************

dsTrain = readDatastore('images/train');
dsValidation = readDatastore('images/validate');
dsTest = readDatastore('images/test');

ytrain = getY('images\train');
yvalid = getY('images\validate');
ytest = getY('images\test');

net = alexnet;

layer = 'fc7';
featuresTrain = activations(net,dsTrain,layer,'OutputAs','rows');
featuresValidation = activations(net,dsValidation,layer,'OutputAs','rows');
featuresTest = activations(net,dsTest,layer,'OutputAs','rows');
save('features2.mat', 'featuresTrain', 'featuresValidation', 'featuresTest', 'ytrain', 'yvalid', 'ytest');

%%

load('features2.mat');

C = 10.^(-5:1:10);
KScale = 10.^(-5:1:10);
lenC = length(C);

datagrid = zeros(length(C) * length(KScale), 3);

fprintf('Starting training (%d)\n', lenC);

index = 1;
for i=1:length(C)
    for j=1:length(KScale)
        c = C(i);
        k = KScale(j);
        model = fitcsvm(featuresTrain,ytrain,'KernelFunction','RBF', 'Standardize',true, ...
            'ClassNames',[-1, 1], 'BoxConstraint',c,'KernelScale',k);
        [detectedClasses, distances] = predict(model, featuresValidation);
        accuracy = sum(yvalid == detectedClasses) / size(yvalid, 1) * 100;
        datagrid(index, 1) = accuracy;
        datagrid(index, 2) = c;
        datagrid(index, 3) = k;
        index = index + 1;
    end
    fprintf("Finished C %d\n", i);
end

save('datagridpt2.mat', 'datagrid');
%%
load('datagridpt2.mat');

[maxAccuracy, index] = max(datagrid(:,1));
maxAccuracy, index
%%
load('features2.mat');
%C = 100, KScale = 100
C = 90:110;
KScale = 90:110;
lenC = length(C);

datagrid2 = zeros(length(C) * length(KScale), 3);

fprintf('Starting training (%d)\n', lenC);

index = 1;
for i=1:length(C)
    for j=1:length(KScale)
        c = C(i);
        k = KScale(j);
        model = fitcsvm(featuresTrain,ytrain,'KernelFunction','RBF', 'Standardize',true, ...
            'ClassNames',[-1, 1], 'BoxConstraint',c,'KernelScale',k);
        [detectedClasses, distances] = predict(model, featuresValidation);
        accuracy = sum(yvalid == detectedClasses) / size(yvalid, 1) * 100;
        datagrid2(index, 1) = accuracy;
        datagrid2(index, 2) = c;
        datagrid2(index, 3) = k;
        index = index + 1;
    end
    fprintf("Finished C %d\n", i);
end

save('datagrid2pt2.mat', 'datagrid2');
%%
load('datagrid2pt2.mat');

[maxAccuracy, index] = max(datagrid2(:,1));
maxAccuracy, index

%%
load('features2.mat');
ytrain = getY('images\train');
yvalid = getY('images\validate');
ytest = getY('images\test');
namesTest = dsTest.Files;

% Define the best parameters found
bestC = 90; % Update as per your hyperparameter tuning
bestKScale = 90; % Update as per your hyperparameter tuning

% Train the SVM model with the best hyperparameters
model = fitcsvm(featuresTrain, ytrain, 'KernelFunction', 'RBF', ...
    'Standardize', true, 'ClassNames', [-1, 1], ...
    'BoxConstraint', bestC, 'KernelScale', bestKScale);

fprintf('Support vectors: %f, percent: %f\n', size(model.SupportVectors, 1), size(model.SupportVectors, 1) / size(ytrain, 1) * 100);
[detectedClasses, ~] = predict(model, featuresValidation);
accuracy = sum(yvalid == detectedClasses) / size(yvalid, 1) * 100;
fprintf('Validation Accuracy: %f\n', accuracy);
[detectedClasses, distances] = predict(model, featuresTest);
accuracy = sum(ytest == detectedClasses) / size(ytest, 1) * 100;
fprintf('Test Accuracy: %f\n', accuracy);

% Predict the scores for the test data
tic
[testClasses, scores] = predict(model, featuresTest);
toc

truePositive = find(ytest == testClasses & testClasses == 1);
trueNegative = find(ytest == testClasses & testClasses == -1);
falsePositive = find(ytest ~= testClasses & testClasses == 1);
falseNegative = find(ytest ~= testClasses & testClasses == -1);
saveScoreImages(truePositive, scores, namesTest, 'nn-tp');
saveScoreImages(trueNegative, scores, namesTest, 'nn-tn');
saveScoreImages(falsePositive, scores, namesTest, 'nn-fp');
saveScoreImages(falseNegative, scores, namesTest, 'nn-fn');

% Extract the positive class scores
positiveScores = scores(:, 2);

% Generate the ROC curve
[rocX, rocY, ~, auc] = perfcurve(ytest, positiveScores, 1);

% Plot the ROC curve
figure;
plot(rocX, rocY, 'b-', 'LineWidth', 2);
hold on;
xlabel('False Positive Rate (FPR)');
ylabel('True Positive Rate (TPR)');
title(['ROC Curve (AUC = ' num2str(auc, '%.3f') ')']);
grid on;
legend('SVM Classifier', 'Random Guessing');
hold off;
