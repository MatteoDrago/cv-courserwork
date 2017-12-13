clear 

DS = imageDatastore('./training','IncludeSubfolders',true,'LabelSource','foldernames');
[tr_set, ts_set] = splitEachLabel(DS, 0.75);

bag = bagOfFeatures(tr_set,'CustomExtractor',@myfeatureExtractor);

save('bagMD_2', 'bag');

%% 
% load bagMD

categoryClassifier = trainImageCategoryClassifier(tr_set, bag);
save('classifier2_MD', 'categoryClassifier');
confMatrix = evaluate(categoryClassifier, tr_set);
confMatrix_2 = evaluate(categoryClassifier, ts_set);
save('confMX1_MD2', 'confMatrix');
save('confMX2_MD2', 'confMatrix_2');