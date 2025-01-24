function data = readFunc(filename)
data = imread(filename);
data = imresize(data, [224 224]);
end
