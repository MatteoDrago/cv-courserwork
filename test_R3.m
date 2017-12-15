clc
clear 
close all

% load GN_tr
% load GN_vd
load trainingFeatures_reduced
load validationFeatures_reduced

DS = imageDatastore('./training','IncludeSubfolders',true,'ReadFcn',@preprocessingFcn,'LabelSource','foldernames');
[tr_set, ts_set] = splitEachLabel(DS, 0.75);

trainingLabels = tr_set.Labels;
testLabels = ts_set.Labels;
% pool = parpool; % Invoke workers
options = statset('UseParallel',true);
% classifier = fitcecoc(trainingFeatures_reduced,trainingLabels,...
%     'Coding','onevsall','Options',options);
% classifier = fitcknn(trainingFeatures_reduced,trainingLabels,'NSMethod','exhaustive','Distance','minkowski',...
%     'Standardize',1);
classifier = fitcsvm(trainingFeatures_reduced,trainingLabels);
predictedLabels = predict(classifier,testFeatures_reduced);
accuracy = mean(predictedLabels == testLabels);

%% Heatmap Plot

T = table(predictedLabels,testLabels,'VariableNames',{'Prediction','Target'});
heatmap(T,'Prediction','Target');