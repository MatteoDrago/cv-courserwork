function [features, featureMetrics] = myfeatureExtractor(img)
    % Image pre-processing
    img = imresize(im2double(img), [256 256]);
    
    % Feature extraction ... It will be probably really slow
    count = 1;
    for x = 1:4:(256-8)
        for y = 1:4:(256-8)
            temp = img(x:x+7,y:y+7);
            temp = temp(:);
            temp = (temp - mean(temp))./std(temp);
            temp = temp./norm(temp);
            features(count,:) = temp;
            count = count + 1;
        end
    end
    
    featureMetrics = var(features,[],2);
end