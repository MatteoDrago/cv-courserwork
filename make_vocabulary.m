clear 

% import images as image datastore and split between train and validation
% set
DS = imageDatastore('./training','IncludeSubfolders',true,'LabelSource','foldernames');
[tr_set, ts_set] = splitEachLabel(DS, 0.75);

% create and cluster with kmeans clustering a BOVW from train set images
% using custom features extraction function
voc_size = 500;
bag = bagOfFeatures(tr_set,'CustomExtractor',@myfeatureExtractor, 'VocabularySize', voc_size);

%save('bagMD_2', 'bag');

%% 
% load bagMD_2;
% load classifier2_MD;
%categoryClassifier = trainImageCategoryClassifier(tr_set, bag);
%save('classifier2_MD', 'categoryClassifier');
% confMatrix = evaluate(categoryClassifier, tr_set);
% confMatrix_2 = evaluate(categoryClassifier, ts_set);
%save('confMX1_MD2', 'confMatrix');
%save('confMX2_MD2', 'confMatrix_2');