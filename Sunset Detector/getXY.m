function [X, y] = getXY(folder)

sunsetPath = fullfile(folder, 'sunset');
nonSunsetpath = fullfile(folder, 'nonsunset');

sunsetStore = imageDatastore(sunsetPath);
nonsunsetStore = imageDatastore(nonSunsetpath);

nSunsetImages = numel(sunsetStore.Files);
nNonSunsetImages = numel(nonsunsetStore.Files);
nImages = nSunsetImages + nNonSunsetImages;

sunsetFeatures = imageDatastoreReader(sunsetStore);
nonsunsetFeatures = imageDatastoreReader(nonsunsetStore);

X = zeros(nImages, 294);
y = zeros(nImages);
X(1:nSunsetImages, :) = sunsetFeatures;
X(nSunsetImages + 1:end, :) = nonsunsetFeatures;

y(1:nSunsetImages) = 1;
y(nSunsetImages + 1:end) = -1;

end
