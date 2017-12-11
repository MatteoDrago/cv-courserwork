
function feats = getTinyImages(img_datastore)
% image_paths is an N x 1 cell array of strings where each string is an
%  image path on the file system.
% image_feats is an N x d matrix of resized and then vectorized tiny
%  images. E.g. if the images are resized to 16x16, d would equal 256.

% To build a tiny image feature, simply resize the original image to a very
% small square resolution, e.g. 16x16. You can either resize the images to
% square while ignoring their aspect ratio or you can crop the center
% square portion out of each image. Making the tiny images zero mean and
% unit length (normalizing them) will increase performance modestly.

images_cell = readall(img_datastore);
% dim_tr = size(images_cell,1)*.75;
dim_ts = size(images_cell,1)*.25;
feats = zeros(dim_ts,256);

for i=76:100
    temp = imresize(im2double(images_cell{i,1}),[16, 16]);
    feats(i-75,:) = temp(:);
end





