%
clc;
clear;
close all;
%

% 0 - low table, 1 - chair, 2 - high table, 3 - couch, 4 - bed

categories ={'table-low', 'chair', 'table-low', 'chair', 'table-low', 'table-high', 'couch', 'bed'};
featurelib = [];
labellib = {};

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
        fdir = [rootdir '/' num2str(n) '/' fname];
        if strcmp(fname, 'dir.txt') == 1
            anglelist = load(fdir);
        end
    end
    
    for i = 1:size(flist, 1)
        disp([n i]);
        fname = flist(i).name;
        if fname(1) == 'p'
            fdir = [rootdir '/' num2str(n) '/' fname];
            pcnm = load(fdir);
            pc = pcnm(:,1:3);
            nm = pcnm(:,4:6);
            
            f = get_norm_feature(pc, nm);
            feature = reshape(f', [1 size(f,1)*size(f,2)]);
            featurelib = [featurelib; feature];
            
            anglestr = '';
%             if (~isempty(anglelist))
%                 angle = anglelist(t);
%                 if angle <= 315 && angle >= 225
%                     anglestr = '-front';
%                 elseif angle == 0 || angle == 180
%                     anglestr = '-front';
%                 elseif angle == 45 || angle == 135
%                     anglestr = '-front';
%                 elseif angle > 45 && angle < 135
%                     anglestr = '-back';
%                 end
%             end
            labellib{end+1} = [categories{n+1} anglestr];   
            t = t + 1;
        end
    end    
end

furniturelib.featurelib = featurelib;
furniturelib.labellib = labellib;

save('furniturelib.mat', 'furniturelib');









