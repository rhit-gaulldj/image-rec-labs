%**************************************************************************
% SunsetDetectorPt1.m
%
%   PROGRAM DESCRIPTION
%   see Sunset Detector Pt. 1 project description
%
%   Output: 
%
%   Written by Daniel Gaull & Maria D. Beloreshka
%   Date: 1/16/25
%**************************************************************************

% [Xtrain, ytrain, namesTrain] = getXY('images\train');
% [Xtest, ytest, namesTest] = getXY('images\test');
% [Xvalid, yvalid, namesValid] = getXY('images\validate');
% 
% save('features.mat', 'Xtrain', 'ytrain', 'Xtest', 'ytest', 'Xvalid', 'yvalid', ...
%     'namesTrain', 'namesTest', 'namesValid');
% fprintf('Done');
% 
% load('features.mat');
% 
% C = 10.^(-5:1:10);
% KScale = 10.^(-5:1:10);
% 
% datagrid = zeros(length(C) * length(KScale), 3);
% 
% index = 1;
% for i=1:length(C)
%     for j=1:length(KScale)
%         c = C(i);
%         k = KScale(j);
%         model = fitcsvm(Xtrain,ytrain,'KernelFunction','RBF', 'Standardize',true, ...
%             'ClassNames',[-1, 1], 'BoxConstraint',c,'KernelScale',k);
%         [detectedClasses, distances] = predict(model, Xvalid);
%         accuracy = sum(yvalid == detectedClasses) / size(yvalid, 1) * 100;
%         datagrid(index, 1) = accuracy;
%         datagrid(index, 2) = c;
%         datagrid(index, 3) = k;
%         index = index + 1;
%     end
%     fprintf("Finished C %d\n", i);
% end
% 
% save('datagrid.mat', 'datagrid');
% 
% load('datagrid.mat');
% [maxAccuracy, index] = max(datagrid(:,1));
% maxAccuracy, index
% 
% % "Zoom in" on the hyperparameters
% 
% load('features.mat');
% 
% C = 1:1:20;
% KScale = 1:1:20;
% 
% datagrid2 = zeros(length(C) * length(KScale), 3);
% 
% index = 1;
% for i=1:length(C)
%     for j=1:length(KScale)
%         c = C(i);
%         k = KScale(j);
%         model = fitcsvm(Xtrain,ytrain,'KernelFunction','RBF', 'Standardize',true, ...
%             'ClassNames',[-1, 1], 'BoxConstraint',c,'KernelScale',k);
%         [detectedClasses, distances] = predict(model, Xvalid);
%         accuracy = sum(yvalid == detectedClasses) / size(yvalid, 1) * 100;
%         datagrid2(index, 1) = accuracy;
%         datagrid2(index, 2) = c;
%         datagrid2(index, 3) = k;
%         index = index + 1;
%     end
%     fprintf("Finished C %d\n", i);
% end
% 
% save('datagrid2.mat', 'datagrid2');
% 
% [maxAccuracy, index] = max(datagrid2(:,1));
% maxAccuracy, index

% BoxConstraint = 2
% KernelScale = 13

%%

load('features.mat');

% Define the best parameters found
bestC = 2; % Update as per your hyperparameter tuning
bestKScale = 13; % Update as per your hyperparameter tuning

% Train the SVM model with the best hyperparameters
model = fitcsvm(Xtrain, ytrain, 'KernelFunction', 'RBF', ...
    'Standardize', true, 'ClassNames', [-1, 1], ...
    'BoxConstraint', bestC, 'KernelScale', bestKScale);

fprintf('Support vectors: %f, percent: %f\n', size(model.SupportVectors, 1), size(model.SupportVectors, 1) / size(Xtrain, 1));
[detectedClasses, ~] = predict(model, Xvalid);
accuracy = sum(yvalid == detectedClasses) / size(yvalid, 1) * 100;
fprintf('Validation Accuracy: %f\n', accuracy);
[detectedClasses, distances] = predict(model, Xtest);
accuracy = sum(ytest == detectedClasses) / size(ytest, 1) * 100;
fprintf('Test Accuracy: %f\n', accuracy);

% Predict the scores for the test data
[testClasses, scores] = predict(model, Xtest);

truePositive = find(ytest == testClasses & ytest == 1);
trueNegative = find(ytest == testClasses & ytest == -1);
falsePositive = find(ytest ~= testClasses & ytest == 1);
falseNegative = find(ytest ~= testClasses & ytest == -1);
saveScoreImages(truePositive, scores, namesTest, 'tp');
saveScoreImages(trueNegative, scores, namesTest, 'tn');
saveScoreImages(falsePositive, scores, namesTest, 'fp');
saveScoreImages(falseNegative, scores, namesTest, 'fn');

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
