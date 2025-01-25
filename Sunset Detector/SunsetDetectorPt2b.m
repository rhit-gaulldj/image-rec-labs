%**************************************************************************
% SunsetDetectorPt2b.m
%
%   PROGRAM DESCRIPTION
%   see Sunset Detector Pt. 2b project description
%
%   Output: 
%
%   Written by Daniel Gaull & Maria D. Beloreshka
%   Date: 01/25/25
%**************************************************************************

% dsTrain = readDatastore('images/train');
% dsValidation = readDatastore('images/validate');
% dsTest = readDatastore('images/test');
% 
% net = alexnet;
% 
% layer = 'fc7';
% featuresTrain = activations(net,dsTrain,layer,'OutputAs','rows');
% featuresValidation = activations(net,dsValidation,layer,'OutputAs','rows');
% featuresTest = activations(net,dsTest,layer,'OutputAs','rows');
% save('features2.mat', 'featuresTrain', 'featuresValidation', 'featuresTest');

load('features2.mat');

ytrain = getY('images\train');
yvalid = getY('images\validate');
ytest = getY('images\test');

C = 10.^(-5:1:10);
KScale = 10.^(-5:1:10);

datagrid = zeros(length(C) * length(KScale), 3);

fprintf('Starting training\n');

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
