function [features, featureMetrics] = myfeatureExtractor(img)
    % Image pre-processing
    img = imresize(im2double(img), [256 256]);
    patchSize = 4; %intial value used: 8
    sampledStep = 4;
    % Feature extraction ... It will be really slow
    count = 1;
    for x = 1:sampledStep:(256-patchSize)
        for y = 1:sampledStep:(256-patchSize)
            temp = img(x:x+patchSize-1,y:y+patchSize-1);
            temp = temp(:);
            temp = (temp - mean(temp))./std(temp); % mean centering and
            temp = temp./norm(temp);               % normalization for 
            features(count,:) = temp;              % each patch
            count = count + 1;
        end
    end
    featureMetrics = var(features,[],2);
end