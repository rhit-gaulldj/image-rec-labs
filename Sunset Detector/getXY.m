function [X, y, names] = getXY(folder)

sunsetPath = fullfile(folder, 'sunset');
nonSunsetpath = fullfile(folder, 'nonsunset');

sunsetStore = imageDatastore(sunsetPath);
nonsunsetStore = imageDatastore(nonSunsetpath);

nSunsetImages = numel(sunsetStore.Files);
nNonSunsetImages = numel(nonsunsetStore.Files);
nImages = nSunsetImages + nNonSunsetImages;

names = cat(1, sunsetStore.Files, nonsunsetStore.Files);
%names(1:nSunsetImages) = sunsetStore.Files;
%names(nSunsetImages + 1:end) = sunsetStore.Files;

sunsetFeatures = imageDatastoreReader(sunsetStore);
nonsunsetFeatures = imageDatastoreReader(nonsunsetStore);

X = zeros(nImages, 294);
y = zeros(nImages, 1);
X(1:nSunsetImages, :) = sunsetFeatures;
X(nSunsetImages + 1:end, :) = nonsunsetFeatures;

y(1:nSunsetImages, :) = 1;
y(nSunsetImages + 1:end, :) = -1;

end
