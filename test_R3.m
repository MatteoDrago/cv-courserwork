clc
clear 
close all

DS = imageDatastore('./training','IncludeSubfolders',true,'ReadFcn',@preprocessingFcn,'LabelSource','foldernames');
[tr_set, ts_set] = splitEachLabel(DS, 0.75);

feature_ext = false;

if (feature_ext)
    anet = alexnet; %#ok<UNRCH>
    layer = 'fc7';
    disp('Starting evaluating activations . . .');
    trainingFeatures = activations(anet,tr_set,layer);
    testFeatures = activations(anet,ts_set,layer);
end

%%

trainingLabels = tr_set.Labels;
testLabels = ts_set.Labels;

classifier = fitcecoc(trainingFeatures_reduced,trainingLabels);
predictedLabels = predict(classifier,testFeatures_reduced);
accuracy = mean(predictedLabels == testLabels);
