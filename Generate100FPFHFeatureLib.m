%
clc;
clear;
close all;
%

% 0 - low table, 1 - chair, 2 - high table, 3 - couch, 4 - bed

categories ={'table', 'chair', 'table', 'chair', 'table', 'table', 'couch', 'bed'};
featurelib = [];
labellib = {};
anglelist = [];
ifhasangle = 0;

filedirlist = {};

if ispc()
    rootdir = 'C:/Users/Eric/Documents/Samples/FPFH/hri_apartment';
else
    rootdir = '/home/hri/Samples/FPFH/hri_apartment'; 
end

for n = 0:7
    dirr = [rootdir '/' num2str(n)];
    flist = dir(dirr);
    t = 1;
    
    anglelist = [];
    for i = 1:size(flist, 1)
        fname = flist(i).name;
        if ~isempty(findstr(fname, 'pcfpfh'))
            fdir = [rootdir '/' num2str(n) '/' fname];
            filedirlist{end+1} = fdir;
            labellib{end+1} = categories{n+1};
        end
    end
end

for n = 1:length(filedirlist)
    
    fdir = filedirlist{n}
    pcfpfh = load(fdir);
    pc = pcfpfh(:,1:3);
    fpfh = pcfpfh(:,4:end);

    feature = get_fpfh_feature(pc, fpfh);
    featurelib = [featurelib; feature];

end

furniturelib.featurelib = featurelib
furniturelib.labellib = labellib

save('furniture_100_33_fpfh_feature_lib.mat', 'furniturelib');









