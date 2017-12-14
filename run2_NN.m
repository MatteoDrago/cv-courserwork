close all;
clear
clc;

load DS;
load imageswithbagMD_2;
number_classes = 15;
lambda = 0.0001;
N = 100;
tr = 75;
ts = 25;

for j=1:number_classes
    all = [];
    for k=1:j-1
        DS = DS_bag{k};
        DS = DS';
        all = [all DS(:,1:tr)];
    end
    for k=j+1:number_classes
        DS = DS_bag{k};
        DS = DS';
        all = [all DS(:,1:tr)];
    end
    DS = DS_bag{j};
    DS = DS';
    one = DS(:,1:tr);
    labels = [ones(1,tr) -ones(1,(number_classes-1)*tr)];
    trainData = [one all];
    net = patternnet([20 20], 'trainscg');
    net.input.processFcns = {'removeconstantrows','mapminmax'};
    %net.trainFcn = 'trainbr';
    %net.adaptFcn = 'learngdm'; 
    %net.divideFcn = 'divideblock';
    net.trainParam.epochs = 10000;
    net.trainParam.max_fail = 600;
    net.trainParam.min_grad = 1e-8;
    net.trainParam.mu = 0.001;
    net = train(net, trainData, labels);
    networks{j} = net;
    clearvars net;
end
%%

final_classification = zeros(ts, number_classes);

for k=1:number_classes
    class = DS_bag{k};
    class = class';
    testData = class(:,tr+1:end);
    classification  = zeros(number_classes, size(testData,2));
    for i=1:size(testData,2)
        for j=1:number_classes
            net = networks{i};
            test = testData(:,i);
            classification(j,i) = net(test);
            %classification(j,i) = classifiers_w(:,j)'*testData(:,i) + classifiers_b(1,j);
        end 
        [value, index] = max(classification(:,i));
        final_classification(i,k) = index;
    end
    clearvars classification;
end

accuracy = 0;
for i=1:number_classes
    for j=1:size(testData,2)
        if (final_classification(j,i) == i)
            accuracy=accuracy+1;
        end
    end
end