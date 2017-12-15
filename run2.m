close all;
clear
clc;

load DS;
load imageswithbagMD_2;
number_classes = 15;
lambda = 0.001;
N = 100;
tr = 75;
ts = 25;
voc_size = 500;

%lambdas = [0.1 0.01 0.001 0.0001 0.00001 0.000001];
lambdas = [0.00001];
accuracies = zeros(length(lambdas), 1);
m = 0;
for lambda = lambdas
m=m+1;
classifiers_w = zeros(voc_size, number_classes);
classifiers_b = zeros(1, number_classes);

% building 15 one vs all linear classifiers with SVMs
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
    [w, b] = vl_svmtrain(trainData, labels, lambda);
    classifiers_w(:,j) = w;
    classifiers_b(j) = b;
end
%testing on validation data

final_classification = zeros(ts, number_classes);

for k=1:number_classes
    class = DS_bag{k};
    class = class';
    testData = class(:,tr+1:end);
    classification  = zeros(number_classes, size(testData,2));
    for i=1:size(testData,2)
        for j=1:number_classes
            classification(j,i) = classifiers_w(:,j)'*testData(:,i) + classifiers_b(1,j);
        end 
        [value, index] = max(classification(:,i));
        final_classification(i,k) = index;
    end
    clearvars classification;
end

% measuring accuracy on validation data
accuracy = 0;
for i=1:number_classes
    for j=1:size(testData,2)
        if (final_classification(j,i) == i)
            accuracy=accuracy+1;
        end
    end
end

accuracies(m) = accuracy/375;
end
disp(accuracy/375);
figure;
plot(-log10(lambdas'),accuracies, 'b', 'linewidth', 2);
grid on
xlabel('-log_{10}(\lambda)', 'fontsize',14); ylabel('accuracy','fontsize',14);
title('Accuracy for different values of lambda','fontsize',14);

% % different bag representation for lambda comparison
% load DS;
% load imagesbag800_4;
% N = 100;
% tr = 75;
% ts = 25;
% voc_size = 800;
% accuracies2 = zeros(length(lambdas), 1);
% m = 0;
% 
% for lambda = lambdas
% m=m+1;
% classifiers_w = zeros(voc_size, number_classes);
% classifiers_b = zeros(1, number_classes);
% % building 15 one vs all linear classifiers with SVMs
% for j=1:number_classes
%     all = [];
%     for k=1:j-1
%         DS = DS_bag{k};
%         DS = DS';
%         all = [all DS(:,1:tr)];
%     end
%     for k=j+1:number_classes
%         DS = DS_bag{k};
%         DS = DS';
%         all = [all DS(:,1:tr)];
%     end
%     DS = DS_bag{j};
%     DS = DS';
%     one = DS(:,1:tr);
%     labels = [ones(1,tr) -ones(1,(number_classes-1)*tr)];
%     trainData = [one all];
%     [w, b] = vl_svmtrain(trainData, labels, lambda);
%     classifiers_w(:,j) = w;
%     classifiers_b(j) = b;
% end
% %testing on validation data
% 
% final_classification = zeros(ts, number_classes);
% 
% for k=1:number_classes
%     class = DS_bag{k};
%     class = class';
%     testData = class(:,tr+1:end);
%     classification  = zeros(number_classes, size(testData,2));
%     for i=1:size(testData,2)
%         for j=1:number_classes
%             classification(j,i) = classifiers_w(:,j)'*testData(:,i) + classifiers_b(1,j);
%         end 
%         [value, index] = max(classification(:,i));
%         final_classification(i,k) = index;
%     end
%     clearvars classification;
% end
% 
% % measuring accuracy on validation data
% accuracy = 0;
% for i=1:number_classes
%     for j=1:size(testData,2)
%         if (final_classification(j,i) == i)
%             accuracy=accuracy+1;
%         end
%     end
% end
% accuracies2(m) = accuracy/375;
% end
% %disp(accuracy/375);
% hold on;
% plot(-log10(lambdas'),accuracies2, 'r', 'linewidth', 2);
% legend('vocabulary 1', 'vocabulary 2');
%% testing run2 on complete test dataset

load bagMD_2;
load classes;
DS_test = imageDatastore('./testing');
file_names = dir('testing');
fileID = fopen('run2.txt','w');

test_images = 2985;
for i=1:test_images
    im = readimage(DS_test,i);
    imageBag = encode(bag, im2double(im));
    for j=1:number_classes
        classification(j,i) = classifiers_w(:,j)'*imageBag' + classifiers_b(1,j);
    end 
   [value, index] = max(classification(:,i));
   fprintf(fileID,'%12s %12s \n',file_names(i+2).name,classes{index});
end
disp('Classification on test set completed...');
fclose(fileID);

