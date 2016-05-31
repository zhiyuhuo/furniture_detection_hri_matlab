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
    rootdir = 'C:/Users/Eric/Documents/Samples/Normal/hri_apartment';
else
    rootdir = '/home/hri/Samples/Normal/hri_apartment'; 
end

for n = 0:7
    dirr = [rootdir '/' num2str(n)];
    flist = dir(dirr);
    t = 1;
    
    anglelist = [];
    for i = 1:size(flist, 1)
        fname = flist(i).name;
        if ~isempty(findstr(fname, 'pcnorm'))
            fdir = [rootdir '/' num2str(n) '/' fname];
            filedirlist{end+1} = fdir;
            labellib{end+1} = categories{n+1};
        end
    end
end

for n = 1:length(filedirlist)
    
    fdir = filedirlist{n};
    pcnm = load(fdir);
    pc = pcnm(:,1:3);
    nm = pcnm(:,4:6);

    f = get_norm_feature(pc, nm);
    feature = reshape(f', [1 size(f,1)*size(f,2)]);
    featurelib = [featurelib; feature];

end

furniturelib.featurelib = featurelib
furniturelib.labellib = labellib

save('furniture_100_normal_feature_lib.mat', 'furniturelib');









