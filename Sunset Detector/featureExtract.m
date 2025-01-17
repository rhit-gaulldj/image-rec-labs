function featureVector = featureExtract(image)
    % convert to double
    image = double(image);

    % convert to LST space
    R = image(:, :, 1);
    G = image(:, :, 2);
    B = image(:, :, 3);
    
    L = R + G + B;           % L channel
    S = R - B;               % S channel
    T = R - 2 * G + B;       % T channel

    % dimensions
    [height, width, ~] = size(image);

    % grid size
    numBlocks = 7; 
    blockHeight = round(height / numBlocks);
    blockWidth = round(width / numBlocks);

    % initialize the feature vector
    featureVector = zeros(1, 294); % 7x7x3x2 (grid x channels x stats)

    index = 1;
    for i=1:numBlocks
        for j=1:numBlocks
            % block boundaries
            rowStart = (i - 1) * blockHeight + 1;
            rowEnd = min(i * blockHeight, height);
            colStart = (j - 1) * blockWidth + 1;
            colEnd = min(j * blockWidth, width);

            % block for each channel
            L_block = L(rowStart:rowEnd, colStart:colEnd);
            S_block = S(rowStart:rowEnd, colStart:colEnd);
            T_block = T(rowStart:rowEnd, colStart:colEnd);

            % calculate mean and standard deviation of each channel
            featureVector(index) = mean(L_block(:));   
            featureVector(index + 1) = std(L_block(:));
            featureVector(index + 2) = mean(S_block(:));
            featureVector(index + 3) = std(S_block(:));
            featureVector(index + 4) = mean(T_block(:)); 
            featureVector(index + 5) = std(T_block(:));

            % increment index for next block
            index = index + 6;
        end 
    end
end




