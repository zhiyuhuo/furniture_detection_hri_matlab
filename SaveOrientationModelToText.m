%
clc;
clear;
close all;
%

categorynameslist = {};
flist = dir('models');
for i = 1:length(flist)
    if (~isempty(findstr(flist(i).name, 'orientation') == 1))
        categorynameslist{end+1} = flist(i).name(length(['orientation' '_'])+1:end-4);
    end    
end


for C = 1:length(categorynameslist)
    category = categorynameslist{C};
    anglew = load(['models/orientation_' category '.mat']);
    anglew = anglew.anglew;
    
    folderdir = ['models_for_ros/' category];
    mkdir(folderdir);
    dlmwrite([folderdir '/anglew.txt'], anglew);
end
