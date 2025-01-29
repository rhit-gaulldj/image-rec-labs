function [y, names] = getY(folder)

sunsetPath = fullfile(folder, 'sunset');
nonSunsetpath = fullfile(folder, 'nonsunset');

sunsetStore = imageDatastore(sunsetPath);
nonsunsetStore = imageDatastore(nonSunsetpath);

nSunsetImages = numel(sunsetStore.Files);
nNonSunsetImages = numel(nonsunsetStore.Files);
nImages = nSunsetImages + nNonSunsetImages;

y = zeros(nImages, 1);
y(1:nSunsetImages, :) = 1;
y(nSunsetImages + 1:end, :) = -1;

names = cat(1, sunsetStore.Files, nonsunsetStore.Files);

end
