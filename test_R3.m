clc
clear 
close all

DS = imageDatastore('./training','IncludeSubfolders',true,'ReadFcn',@preprocessingFcn,'LabelSource','foldernames');
[tr_set, ts_set] = splitEachLabel(DS, 0.75);

anet = alexnet;
layers = anet.Layers;

fc = fullyConnectedLayer(15);
layers(23) = fc; % it correspond to last layer before the output

cl = classificationLayer;
layers(25) = classificationLayer;

options = trainingOptions('sgdm',...
    'InitialLearnRate', 0.001,...
    'Plots','training-progress',...
    'ExecutionEnvironment','parallel');

[newAlexNet,info] = trainNetwork(tr_set, layers, options); 

save('newAlexNet','newAlexNet');

%%

testpreds = classify(newnet,ts_set);