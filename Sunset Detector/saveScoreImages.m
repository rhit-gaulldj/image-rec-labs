function saveScoreImages(indices, scores, names, folder)

myScores = scores(indices, 2);
[minScore, minIndex] = min(myScores);
[maxScore, maxIndex] = max(myScores);

minImg = imread(names{minIndex});
maxImg = imread(names{maxIndex});

imwrite(minImg, fullfile('output', folder, 'minimg.png'));
imwrite(maxImg, fullfile('output', folder, 'maximg.png'));

fprintf('%s min score: %f\n%s max score: %f\n', folder, minScore, folder, maxScore);

end
