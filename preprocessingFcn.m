function img = preprocessingFcn(file)
    % Import image
    img = imread(file);
    img = imresize(img,[227 227]);
    % Convert grayscale to color (RGB)
    img = repmat(img,[1 1 3]);
end