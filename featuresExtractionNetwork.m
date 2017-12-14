clc
clear
close

DS = imageDatastore('./training','IncludeSubfolders',true,'ReadFcn',@preprocessingFcn,'LabelSource','foldernames');
[tr_set, ts_set] = splitEachLabel(DS, 0.75);

networkName = 'googlenet';

switch networkName
    case 'alexnet'
        anet = alexnet; 
        layer = 'fc7';
        disp('Starting evaluating activations . . .');
        trainingFeatures = activations(anet,tr_set,layer);
        validationFeatures = activations(anet,ts_set,layer);
    case 'googlenet'
        gnet = googlenet;
        layer = 'loss3-classifier';
        disp('Starting evaluating activations . . .');
        parpool;
        trainingFeatures = activations(gnet,tr_set,layer);
        validationFeatures = activations(gnet,ts_set,layer);
        save('GN_tr','trainingFeatures');
        save('GN_vd','validationFeatures');
    otherwise
        disp('Network name not valid');
end