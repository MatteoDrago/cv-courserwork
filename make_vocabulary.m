clear all
% build the vocabulary
%cluster them with kmeans, and then return the cluster centroids.

load DS;
field = 'DS';
values = {DS_1; DS_2; DS_3; DS_4; DS_5; DS_6; DS_7; DS_8; DS_9; DS_10; DS_11; DS_12; DS_13; DS_14; DS_15};
D = struct(field,values);

binSize = 8;
sampledStep = 4;
number_classes = 15;

X = [];
for i=1:number_classes
    class = readall(D(i).DS);
    disp(length(class));
    for k=1:length(class)
        image = im2double(class{k});
        [f, b] = vl_dsift(single(image),'size', binSize, 'step', sampledStep, 'fast'); 
        X = [X f];
    end
end
disp('patches extraction terminated, building clusters...');

% m = X';
% m(:,1) = m(:,1) - mean(m(:,1));
% m(:,2) = m(:,2) - mean(m(:,2));
% m = normc(m);
% 
% X = m';
number_clusters = 500;
[C, A] = vl_kmeans(X, number_clusters);


%{
Useful functions:
[locations, SIFT_features] = vl_dsift(img) 
 http://www.vlfeat.org/matlab/vl_dsift.html
 locations is a 2 x n list list of locations, which can be thrown away here
  (but possibly used for extra credit in get_bags_of_sifts if you're making
  a "spatial pyramid").
 SIFT_features is a 128 x N matrix of SIFT features
  note: there are step, bin size, and smoothing parameters you can
  manipulate for vl_dsift(). We recommend debugging with the 'fast'
  parameter. This approximate version of SIFT is about 20 times faster to
  compute. Also, be sure not to use the default value of step size. It will
  be very slow and you'll see relatively little performance gain from
  extremely dense sampling. You are welcome to use your own SIFT feature
  code! It will probably be slower, though.

[centers, assignments] = vl_kmeans(X, K)

  X is a d x M matrix of sampled SIFT features, where M is the number of
   features sampled. M should be pretty large! Make sure matrix is of type
   single to be safe. E.g. single(matrix).
  K is the number of clusters desired (vocab_size)
  centers is a d x K matrix of cluster centroids. This is your vocabulary.
   You can disregard 'assignments'.

%}

% Load images from the training set. To save computation time, you don't
% necessarily need to sample from all images, although it would be better
% to do so. You can randomly sample the descriptors from each image to save
% memory and speed up the clustering. Or you can simply call vl_dsift with
% a large step size here, but a smaller step size in make_hist.m. 

% For each loaded image, get some SIFT features. You don't have to get as
% many SIFT features as you will in get_bags_of_sift.m, because you're only
% trying to get a representative sample here.

% Once you have tens of thousands of SIFT features from many training
% images, cluster them with kmeans. The resulting centroids are now your
% visual word vocabulary.