%
clc;
clear;
close all;
%

%
clc;
clear;
close all;
%

% 0 - low table, 1 - chair, 2 - high table, 3 - couch, 4 - bed
categories ={'table-low', 'chair', 'table-low', 'chair', 'table-low', 'table-high', 'couch', 'bed'};

C = 'couch';

if ispc()
    rootdir = 'C:/Users/Eric/Documents/Samples/Normal/hri_apartment';
else
    rootdir = '/home/hri/Samples/Normal/hri_apartment'; 
end

anglefeaturelib = {};

for n = 0:7
    
    if strcmp(categories(n+1), C) == 1
        anglelist = load([rootdir '/' num2str(n) '/dir.txt']);
        angledir = [rootdir '/' num2str(n)];
        flist = dir(angledir);
        t = 1;
        for i = 1:size(flist, 1)
            disp([n i]);
            fname = flist(i).name;
            if fname(1) == 'p'
                fdir = [rootdir '/' num2str(n) '/' fname];
                pcnm = load(fdir);
                pc = pcnm(:,1:3);
%                 scatter3(pc(:,1), pc(:,2), pc(:,3));
                nm = pcnm(:,4:6);

                anglefeature = get_angle_mat(pc, nm);
                anglefeaturelib{end+1} = {anglefeature, anglelist(t)};
                t = t + 1;
                
            end
        end
    
    end
    
end

fname = ['anglefeaturelib_' C '.mat'];
save(fname, 'anglefeaturelib');

