clear 

DS = imageDatastore('./training','IncludeSubfolders',true,'LabelSource','foldernames');
[tr_set, ts_set] = splitEachLabel(DS, 0.75);

net = resnet50;

%%
layer = 'fc7';
trainingFeatures = activations(net,tr_set,layer);
testFeatures = activations(net,ts_set,layer);