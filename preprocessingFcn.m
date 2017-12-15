function img = preprocessingFcn(file)
    % Import image
    img = imread(file);
    img = imresize(img,[224 224]);
    % Convert grayscale to color (RGB)
    img = repmat(img,[1 1 3]);
end