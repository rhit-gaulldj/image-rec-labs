%**************************************************************************
% SunsetDetectorPt2.m
%
%   PROGRAM DESCRIPTION
%   see Sunset Detector Pt. 2 project description
%
%   Output: 
%
%   Written by Daniel Gaull & Maria D. Beloreshka
%   Date: 01/23/25
%**************************************************************************

dsTrain = readDatastore('images/train');
dsValidation = readDatastore('images/validate');
dsTest = readDatastore('images/test');

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
% net = trainnet(dsTrain,net, "crossentropy", options);
% save('model.mat', 'net');

load('model.mat');


