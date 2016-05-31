%
clc;
clear;
close all;
%

kernelstr = 'rbf';
categorynameslist = {};
flist = dir('models');
for i = 1:length(flist)
    if (~isempty(findstr(flist(i).name, 'model') == 1))
        categorynameslist{end+1} = flist(i).name(length(['model_' kernelstr '_'])+1:end-4);
    end    
end


for C = 1:length(categorynameslist)
    category = categorynameslist{C};
    model = load(['models/model_' kernelstr '_' category '.mat']);
    model = model.model;
    
    folderdir = ['models_for_ros/' category];
    mkdir(folderdir);
    save_model_to_dir(folderdir, model);
end

