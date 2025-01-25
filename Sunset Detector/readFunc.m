function data = readFunc(filename)
data = imread(filename);
data = imresize(data, [227 227]);
end
