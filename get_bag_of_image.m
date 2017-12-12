function bag_image = get_bag_of_image(image, binSize, sampledStep, C, kdtree)

    f = vl_dsift(single(image),'size', binSize, 'step', sampledStep, 'fast');
    ba_image = zeros(size(C,2), 1);
    D = vl_alldist2(f,C);
    for i=1:size(D,1)
        [value index] = min(D(i,:));
        ba_image(index) = ba_image(index) +1;
    end
    nn = vl_kdtreequery(kdtree, C, f);
%   assignments = zeros(size(C,2), size(f,2));
%   assignments(sub2ind(size(assignments), nn, 1:length(nn))) = 1;
%   enc = vl_vlad(f, C, assignments, 'NormalizeComponents');
    
    b_image = zeros(size(C,2),1);
    for i=1:size(C,2)
        b_image(i) = sum(nn == i);
    end
    b_image(:) = b_image(:) - mean(b_image);
    b_image = normc(b_image);
    bag_image = b_image;