function classIDX = nearestNeighbourClassifier(k, imgToClass, feats)

N = 75; % This value depends on the number of images contained in each class
D = zeros(15,N);

for i = 1:size(feats,2)
    D(i,:) = distFromClass(imgToClass,feats{1,i});
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