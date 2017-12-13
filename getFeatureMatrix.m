function X = getFeatureMatrix(img)
    count = 1;
    for x = 1:8:(256-8)
        for y = 1:8:(256-8)
            temp = img(x:x+7,y:y+7);
            temp = temp(:);
            temp = (temp - mean(temp))./std(temp);
            temp = temp./norm(temp);
            X(count,:) = temp;
            count = count + 1;
        end
    end
end