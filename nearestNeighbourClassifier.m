function classIDX = nearestNeighbourClassifier(k, imgToClass, feats, dist_measure)

N = 75; % This value depends on the number of images contained in each class

if(nargin < 4)
    D = vl_alldist2(imgToClass',feats');
else
    D = vl_alldist2(imgToClass',feats',dist_measure);
end


[~, min_ids] = sort(D(:));
min_ids = min_ids(1:k);
temp = ceil(min_ids./N);
classes = zeros(15,1);

for i = 1:15
    classes(i) = nnz(temp == i);
end

[~, classIDX] = max(classes);

end