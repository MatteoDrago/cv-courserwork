clc
clear 
close all

% load GN_tr
% load GN_vd
load trainingFeaturesALL
load testFeaturesALL

DS = imageDatastore('./training','IncludeSubfolders',true,'ReadFcn',@preprocessingFcn,'LabelSource','foldernames');
% [tr_set, ts_set] = splitEachLabel(DS, 0.75);

trainingLabels = DS.Labels;
%testLabels = ts_set.Labels;
options = statset('UseParallel',true);
classifier = fitcecoc(trainingFeaturesALL,trainingLabels,...
     'Coding','onevsall','Options',options);
% classifier = fitcknn(trainingFeatures_reduced,trainingLabels,'NSMethod','exhaustive','Distance','minkowski',...
%     'Standardize',1);
% predictedLabels = predict(classifier,testFeatures_reduced);
% accuracy = mean(predictedLabels == testLabels);

%% Heatmap Plot

T = table(predictedLabels,testLabels,'VariableNames',{'Prediction','Target'});
heatmap(T,'Prediction','Target');