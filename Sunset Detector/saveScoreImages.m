function saveScoreImages(indices, scores, names, folder)

myScores = scores(indices, 2);
myNames = names(indices);
[minScore, minIndex] = min(myScores);
[maxScore, maxIndex] = max(myScores);

minImg = imread(myNames{minIndex});
maxImg = imread(myNames{maxIndex});

imwrite(minImg, fullfile('output', folder, 'minimg.png'));
imwrite(maxImg, fullfile('output', folder, 'maximg.png'));

fprintf('%s min score: %f\n%s max score: %f\n', folder, minScore, folder, maxScore);

end
