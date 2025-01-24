function ds = readDatastore(folder)
ds = imageDatastore(folder, IncludeSubfolders=true, LabelSource='foldernames');
ds.ReadFcn = @readFunc;
end
