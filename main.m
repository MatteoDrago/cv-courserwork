clc
clear
close all

load DS % load all images datastores 
load features_all
load features_tr
load features_ts
load classes
load testset % load cell of tiny images

realClass = [ones(25,1);2*ones(25,1);3*ones(25,1);...
4*ones(25,1);5*ones(25,1);6*ones(25,1);...
7*ones(25,1);8*ones(25,1);9*ones(25,1);...
10*ones(25,1);11*ones(25,1);12*ones(25,1);...
13*ones(25,1);14*ones(25,1);15*ones(25,1);];

classes = zeros(375,1);

for i = 1:375
    classes(i) = nearestNeighbourClassifier(9,feats_ts(i,:),feats_tr);
end

fprintf("Precision: %.2f \n",(nnz(classes == realClass)/375)*100);
