img = imread('./mixed_fruit3.tiff');
hsv = rgb2hsv(img);
%%

combinedMask = img;

applemask = (hsv(:,:,1) < 0.04 | hsv(:,:,1) > 0.95) & hsv(:,:,2) > 0.55 & hsv(:,:,3) < 0.5 & hsv(:,:,3) > 0.01;
combinedMask(:,:,1) = 255 * applemask;
applepixels = sum(sum(applemask));
if applepixels < 20000
    applemask = imerode(applemask, strel('disk', 3));
    applemask = imdilate(applemask, strel('disk', 7));
else
    applemask = imerode(applemask, strel('disk', 3));
    applemask = imdilate(applemask, strel('disk', 11));
    applemask = imerode(applemask, strel('disk', 3));
end

orangemask = hsv(:,:,1) > 0.05 & hsv(:,:,1) < 0.12 & hsv(:,:,2) > 0.48 & hsv(:,:,3) > 0.50;
combinedMask(:,:,2) = 255 * orangemask;
orangepixels = sum(sum(orangemask));
if orangepixels < 20000
    orangemask = imerode(orangemask, strel('disk', 3));
    orangemask = imdilate(orangemask, strel('disk', 7));
else
    orangemask = imerode(orangemask, strel('disk', 3));
    orangemask = imdilate(orangemask, strel('disk', 11));
    orangemask = imerode(orangemask, strel('disk', 3));
end

bananamask = hsv(:,:,1) > 0.12 & hsv(:,:,1) < 0.24 & hsv(:,:,2) > 0.4 & hsv(:,:,3) > 0.5 & hsv(:,:,3) < 1; % hsv(:,:,2) < 0.7 & 
combinedMask(:,:,3) = 255 * bananamask;
bananapixels = sum(sum(bananamask));
if bananapixels < 20000
    bananamask = imerode(bananamask, strel('disk', 3));
    bananamask = imdilate(bananamask, strel('disk', 9));
    bananamask = imerode(bananamask, strel('disk', 6));
else
    bananamask = imerode(bananamask, strel('disk', 3));
    bananamask = imdilate(bananamask, strel('disk', 11));
    bananamask = imerode(bananamask, strel('disk', 3));
end

%imwrite(combinedMask, './combined_mask_pre_morphology2.png');

combinedMask(:,:,1) = applemask * 255;
combinedMask(:,:,2) = orangemask * 255;
combinedMask(:,:,3) = bananamask * 255;
%imwrite(combinedMask, './combined_mask_post_morphology2.png');

%imtool(img);
%imtool(bananamask);
%imtool(uint8(bananamask) .* img);

%%

connectedApples = bwlabel(applemask, 4);
appleCount = max(max(connectedApples));
appleSizes = zeros(appleCount, 1);
appleXs = zeros(appleCount, 1);
appleYs = zeros(appleCount, 1);
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
for i = 1:appleCount
    if appleSizes(i) < meanAppleSize - 2 * stdAppleSize
        connectedApples(connectedApples == i) = 0;
        appleSizes(i) = 0;
    end
end
appleCount = size(find(appleSizes > 0));
appleCount = appleCount(1);
appleCount

%%
connectedOranges = bwlabel(orangemask, 4);
orangeCount = max(max(connectedOranges));
orangeSizes = zeros(orangeCount, 1);
orangeXs = zeros(orangeCount, 1);
orangeYs = zeros(orangeCount, 1);
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
for i = 1:orangeCount
    if orangeSizes(i) < meanOrangeSize - 2.5 * stdOrangeSize
        connectedOranges(connectedOranges == i) = 0;
        orangeSizes(i) = 0;
    end
end
orangeCount = size(find(orangeSizes > 0));
orangeCount = orangeCount(1);
orangeCount

%%
connectedBananas = bwlabel(bananamask, 4);
bananaCount = max(max(connectedBananas));
bananaSizes = zeros(bananaCount, 1);
bananaXs = zeros(bananaCount, 1);
bananaYs = zeros(bananaCount, 1);
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
for i = 1:bananaCount
    if bananaSizes(i) < meanBananaSize - 1 * stdBananaSize
        connectedBananas(connectedBananas == i) = 0;
        bananaSizes(i) = 0;
    end
end
bananaCount = size(find(bananaSizes > 0));
bananaCount = bananaCount(1);
bananaCount

combinedMask(:,:,1) = connectedApples * 255;
combinedMask(:,:,2) = connectedOranges * 255;
combinedMask(:,:,3) = connectedBananas * 255;

figure;
imshow(img);
figure;
imshow(combinedMask);

%imwrite(combinedMask, './combined_mask_post_deletion3.png');
