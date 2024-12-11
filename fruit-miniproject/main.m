%**************************************************************************
% main.m
%
%   PROGRAM DESCRIPTION
%   see Fruit Finder project description
%
%   Output: combined mask to detect oranges, apples, and bananas on
%   couches
%
%   Written by Daniel Gaull & Maria D. Beloreshka
%   Date: 12/10/24
%**************************************************************************
 
% load image
img = imread('./mixed_fruit3.tiff');
% convert image to hsv from rgb
hsv = rgb2hsv(img);
% figure;
% imshow(hsv);

%% Combined Mask Section
combinedMask = img;

% apple mask parameters
applemask = (hsv(:,:,1) < 0.04 | hsv(:,:,1) > 0.95) & hsv(:,:,2) > 0.55 & hsv(:,:,3) < 0.5 & hsv(:,:,3) > 0.01;
% assigning the apple mask to the first channel of the combined mask
combinedMask(:,:,1) = 255 * applemask;
% number of pixels belonging to an apple
applepixels = sum(sum(applemask)); 
% morphology steps depending on the number of apple pixels
if applepixels < 20000
    applemask = imerode(applemask, strel('disk', 3));
    applemask = imdilate(applemask, strel('disk', 7));
else
    applemask = imerode(applemask, strel('disk', 3));
    applemask = imdilate(applemask, strel('disk', 11));
    applemask = imerode(applemask, strel('disk', 3));
end

% orange mask parameters
orangemask = hsv(:,:,1) > 0.05 & hsv(:,:,1) < 0.12 & hsv(:,:,2) > 0.48 & hsv(:,:,3) > 0.50;
% assigning the orange mask to the second channel of the combined mask
combinedMask(:,:,2) = 255 * orangemask;
% number of pixels belonging to an orange
orangepixels = sum(sum(orangemask));
% morphology steps depending on the number of orange pixels
if orangepixels < 20000
    orangemask = imerode(orangemask, strel('disk', 3));
    orangemask = imdilate(orangemask, strel('disk', 7));
else
    orangemask = imerode(orangemask, strel('disk', 3));
    orangemask = imdilate(orangemask, strel('disk', 11));
    orangemask = imerode(orangemask, strel('disk', 3));
end

% banana mask parameters
bananamask = hsv(:,:,1) > 0.12 & hsv(:,:,1) < 0.24 & hsv(:,:,2) > 0.4 & hsv(:,:,3) > 0.5 & hsv(:,:,3) < 1; % hsv(:,:,2) < 0.7 & 
% assigning the banana mask to the third channel of the combined mask
combinedMask(:,:,3) = 255 * bananamask;
% number of pixels belonging to a banana
bananapixels = sum(sum(bananamask));
% morphology steps depending on the number of banana pixels
if bananapixels < 20000
    bananamask = imerode(bananamask, strel('disk', 3));
    bananamask = imdilate(bananamask, strel('disk', 15));
    bananamask = imerode(bananamask, strel('disk', 6));
else
    bananamask = imerode(bananamask, strel('disk', 3));
    bananamask = imdilate(bananamask, strel('disk', 11));
    bananamask = imerode(bananamask, strel('disk', 3));
end

imwrite(combinedMask, './combined_mask_pre_morphology3.png'); % saving the mask


%% Number of Apples and Their Individual Statistics
connectedApples = bwlabel(applemask, 4);
appleCount = max(max(connectedApples));
appleSizes = zeros(appleCount, 1);
appleXs = zeros(appleCount, 1);
appleYs = zeros(appleCount, 1);
% finding each apple's centroid
for i = 1:appleCount
    thisApple = connectedApples == i;
    appleSizes(i) = sum(sum(thisApple));
    c = regionprops(thisApple, 'centroid').Centroid;
    x = c(1);
    y = c(2);
    appleXs(i) = x;
    appleYs(i) = y;
end
meanAppleSize = mean(appleSizes);
stdAppleSize = std(appleSizes);
% remove small apple outliers that could be false positive apples
for i = 1:appleCount
    if appleSizes(i) < meanAppleSize - stdAppleSize
        connectedApples(connectedApples == i) = 0;
        appleSizes(i) = 0;
    end
end

%% Number of Oranges and Their Individual Statistics
connectedOranges = bwlabel(orangemask, 4);
orangeCount = max(max(connectedOranges));
orangeSizes = zeros(orangeCount, 1);
orangeXs = zeros(orangeCount, 1);
orangeYs = zeros(orangeCount, 1);
% finding each orange's centroid
for i = 1:orangeCount
    this = connectedOranges == i;
    orangeSizes(i) = sum(sum(this));
    c = regionprops(this, 'centroid').Centroid;
    x = c(1);
    y = c(2);
    orangeXs(i) = x;
    orangeYs(i) = y;
end
meanOrangeSize = mean(orangeSizes);
stdOrangeSize = std(orangeSizes);
% remove small orange outliers that could be false positive oranges
for i = 1:orangeCount
    if orangeSizes(i) < meanOrangeSize - stdOrangeSize
        connectedOranges(connectedOranges == i) = 0;
        orangeSizes(i) = 0;
    end
end

%% Number of Bananas and Their Individual Statistics
connectedBananas = bwlabel(bananamask, 4);
bananaCount = max(max(connectedBananas));
bananaSizes = zeros(bananaCount, 1);
bananaXs = zeros(bananaCount, 1);
bananaYs = zeros(bananaCount, 1);
% finding each banana's centroid
for i = 1:bananaCount
    this = connectedBananas == i;
    bananaSizes(i) = sum(sum(this));
    c = regionprops(this, 'centroid').Centroid;
    x = c(1);
    y = c(2);
    bananaXs(i) = x;
    bananaYs(i) = y;
end
meanBananaSize = mean(bananaSizes);
stdBananaSize = std(bananaSizes);
% remove small banana outliers that could be false positive bananas
for i = 1:bananaCount
    if bananaSizes(i) < meanBananaSize - 0.5 * stdBananaSize
        connectedBananas(connectedBananas == i) = 0;
        bananaSizes(i) = 0;
    end
end

% figure;
% imshow(img);
% figure;
% imshow(bananamask);
% figure;
% imshow(connectedBananas);
