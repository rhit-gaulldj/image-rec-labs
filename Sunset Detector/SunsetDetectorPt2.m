%**************************************************************************
% SunsetDetectorPt2.m
%
%   PROGRAM DESCRIPTION
%   Transfer learning method for Sunset Detector Pt. 2 Project
%
%   Output: 
%
%   Written by Daniel Gaull & Maria D. Beloreshka
%   Date: 01/23/25
%**************************************************************************

% dsTrain = readDatastore('images/train');
% dsValidation = readDatastore('images/validate');
% dsTest = readDatastore('images/test');
% 
% net = imagePretrainedNetwork("googlenet", NumClasses=2);
% %analyzeNetwork(net);
% layerNames = {'loss3-classifier'};
% net = freezeNetwork(net,LayerNamesToIgnore=layerNames);
% 
% options = trainingOptions("adam", ...
%     ValidationData=dsValidation, ...
%     ValidationFrequency=5, ...
%     Plots="training-progress", ...
%     Metrics="accuracy", ...
%     Verbose=true, ...
%     MiniBatchSize=64, ...
%     MaxEpochs=30);
% 
% fprintf('Starting training...\n');
% 
% net = trainnet(dsTrain, net, "crossentropy", options);
% 
% saveToStruct(net, 'net.mat');
% %load('net.mat');
% 
% scores = minibatchpredict(net, dsTest);
% save('scores.mat', 'scores');
% 
% %load('scores.mat');
% %labels = scores2label(scores, {'sunset', 'nonsunset'});
% save('labels.mat', 'labels');
% %load('labels.mat');
% testAcc = 1 - length(find(dsTest.Labels ~= labels)) / size(labels, 1);
% fprintf('Test Accuracy: %f%%\n', testAcc * 100);

%%
scores = minibatchpredict(net, dsTest);
labels = scores2label(scores, {'nonsunset', 'sunset'});
testAcc = 1 - length(find(dsTest.Labels ~= labels)) / size(labels, 1);
testAcc
