clc
clear
close all

load classes
classes_pred = zeros(2985,1);
file_names = dir('testing');

%% RUN 1

load features_all
load testing_tinyFeats % load cell of tiny images

for i = 1:2985
    classes_pred(i) = nearestNeighbourClassifier(7,testing_tinyFeats(i,:),feats_all,'L2');
end

fileID = fopen('run1.txt','w');
for i = 1:2985
    disp(i);
    fprintf(fileID,'%12s %12s \n',file_names(i+2).name,classes{classes_pred(i)});
end
fclose(fileID);
