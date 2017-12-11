function dist = distFromClass(x, feats)

N = size(feats,1);

for i = 1:N
   dist(i) = getEuclideanDistance(x,feats(i,:));
%   dist(i) = getManhattanDistance(x,feats(i,:));
%   dist(i) = getCosineDistance(x,feats(i,:));
%   dist(i) = mean(mahal(x',feats(i,:)'));
    
end

end