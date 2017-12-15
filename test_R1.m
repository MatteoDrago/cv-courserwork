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
        classes(i) = nearestNeighbourClassifier(k,feats_ts(i,:),feats_tr,'HELL');
    end
    prec(k) = (nnz(classes == realClass)/375);
end

load P
figure
plot(1:15,P(1:15,1:3),'Linewidth',1.2)
xlabel('k')
ylabel('Accuracy')
grid on
axis([1 15 0.1 0.23]);
legend('L_{INF}','L_2','L_1');

% fprintf("Precision: %.2f \n",(nnz(classes == realClass)/375)*100);