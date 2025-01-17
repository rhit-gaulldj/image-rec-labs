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

%[Xtrain, ytrain] = getXY('images\train');
%[Xtest, ytest] = getXY('images\test');
%[Xvalid, yvalid] = getXY('images\validate');

%save('features.mat', 'Xtrain', 'ytrain', 'Xtest', 'ytest', 'Xvalid', 'yvalid');

% load('trainFeatures.mat');
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
%         [detectedClasses, distances] = predict(model, Xtest);
%         accuracy = sum(ytest == detectedClasses) / size(ytest, 1) * 100;
%         datagrid(index, 1) = accuracy;
%         datagrid(index, 2) = c;
%         datagrid(index, 3) = k;
%         index = index + 1;
%     end
%     fprintf("Finished C %d\n", i);
% end
% 
% save('datagrid.mat', 'datagrid');

% [maxAccuracy, index] = max(datagrid(:,1));
% maxAccuracy, index

% "Zoom in" on the hyperparameters

load('trainFeatures.mat');

C = 500:100:1500;
KScale = 90:5:110;

datagrid2 = zeros(length(C) * length(KScale), 3);

index = 1;
for i=1:length(C)
    for j=1:length(KScale)
        c = C(i);
        k = KScale(j);
        model = fitcsvm(Xtrain,ytrain,'KernelFunction','RBF', 'Standardize',true, ...
            'ClassNames',[-1, 1], 'BoxConstraint',c,'KernelScale',k);
        [detectedClasses, distances] = predict(model, Xtest);
        accuracy = sum(ytest == detectedClasses) / size(ytest, 1) * 100;
        datagrid2(index, 1) = accuracy;
        datagrid2(index, 2) = c;
        datagrid2(index, 3) = k;
        index = index + 1;
    end
    fprintf("Finished C %d\n", i);
end

save('datagrid2.mat', 'datagrid2');

[maxAccuracy, index] = max(datagrid2(:,1));
maxAccuracy, index

% BoxConstraint = 1000
% KernelScale = 95