clc
clear
close all

load DS % load all images datastores 
load features_tr
load features_ts
load classes

realClass = [ones(25,1);2*ones(25,1);3*ones(25,1);...
4*ones(25,1);5*ones(25,1);6*ones(25,1);...
7*ones(25,1);8*ones(25,1);9*ones(25,1);...
10*ones(25,1);11*ones(25,1);12*ones(25,1);...
13*ones(25,1);14*ones(25,1);15*ones(25,1);];

classes = zeros(375,1);

K = 20;
prec = zeros(K,1);
for k = 1:K
    for i = 1:375
        classes(i) = nearestNeighbourClassifier(k,feats_ts(i,:),feats_tr);
    end
    prec(k) = (nnz(classes == realClass)/375);
end

figure
stem(prec)
grid on
ylim([0.17 0.21]);

% fprintf("Precision: %.2f \n",(nnz(classes == realClass)/375)*100);