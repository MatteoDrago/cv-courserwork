clc
clear
close

train_DS = imageDatastore('./training','IncludeSubfolders',true,'ReadFcn',@preprocessingFcn,'LabelSource','foldernames');
test_DS = imageDatastore('./testing','IncludeSubfolders',true,'ReadFcn',@preprocessingFcn,'LabelSource','foldernames');

%[tr_set, ts_set] = splitEachLabel(DS, 0.75);

networkName = 'alexnet';

switch networkName
    case 'alexnet'
        anet = alexnet; 
        layer = 'fc7';
        parpool;
        disp('Starting evaluating activations . . .');
        trainingFeaturesALL = activations(anet,train_DS,layer);
        testFeaturesALL = activations(anet,test_DS,layer);
    case 'googlenet'
        gnet = googlenet;
        layer = 'loss3-classifier';
        disp('Starting evaluating activations . . .');
        parpool;
        trainingFeatures = activations(gnet,train_DS,layer);
        validationFeatures = activations(gnet,test_DS,layer);
        save('GN_tr','trainingFeatures');
        save('GN_vd','validationFeatures');
    case 'vgg19'
        vnet = vgg19;
        layer = 'fc7';
        disp('Starting evaluating activations . . .');
        parpool;
        trainingFeatures = activations(vnet,train_DS,layer);
        validationFeatures = activations(vnet,test_DS,layer);
    otherwise
        disp('Network name not valid');
end