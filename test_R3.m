clc
clear 
close all

load GN_tr
load GN_vd

DS = imageDatastore('./training','IncludeSubfolders',true,'ReadFcn',@preprocessingFcn,'LabelSource','foldernames');
[tr_set, ts_set] = splitEachLabel(DS, 0.75);

trainingLabels = tr_set.Labels;
testLabels = ts_set.Labels;

classifier = fitcecoc(trainingFeatures,trainingLabels);
predictedLabels = predict(classifier,validationFeatures);
accuracy = mean(predictedLabels == testLabels);
