function saveScoreImages(indices, scores, names, folder)

myScores = scores(indices, 2);
myNames = names(indices);
[minScore, minIndex] = min(myScores);
[maxScore, maxIndex] = max(myScores);

minImgPath = myNames{minIndex};
maxImgPath = myNames{maxIndex};

minImg = imread(minImgPath);
maxImg = imread(maxImgPath);

imwrite(minImg, fullfile('output', folder, 'minimg.png'));
imwrite(maxImg, fullfile('output', folder, 'maximg.png'));

fprintf('%s min score: %f\n%s max score: %f\n', folder, minScore, folder, maxScore);
%fprintf('== %s ==\nMin Img Path: %s\nMax Img Path: %s\n====\n', folder, minImgPath, maxImgPath);
%fprintf('Min: %d; Max: %d\n', indices(minIndex), indices(maxIndex));

end
