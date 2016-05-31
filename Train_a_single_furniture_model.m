%
clc;
clear;
close all;
%

lib = load('furniturelib.mat');
featurelib = lib.furniturelib.featurelib;
labellib = lib.furniturelib.labellib;
% categorylist = [0];


category = 'table-high';

%     features = featurelib;
features = featurelib(1:2:end,:);
rawlabelsets = labellib(1:2:end);
labels = ones(length(rawlabelsets),1);
labels(find(strcmp(rawlabelsets, category) ~= 1)) = -1;

featuret = featurelib(2:2:end,:);
rawlabelsett = labellib(2:2:end);
labelt = ones(length(rawlabelsett),1);
labelt(find(strcmp(rawlabelsett, category) ~= 1)) = -1;

kernelstr = 'rbf';

rbfsigma = 20;  
model = svmtrain(features, labels,'Kernel_Function', kernelstr, 'rbf_sigma', rbfsigma);

groupt = svmclassify(model,featuret);

k = labelt.*groupt;
aws = find(k < 0);

disp(category);
disp(length(model.SupportVectors));
disp(aws);
model.Sigma = rbfsigma;

save(['models/model_' kernelstr '_' num2str(category) '.mat'], 'model');

folderdir = ['models_for_ros/' category];
mkdir(folderdir);
save_model_to_dir(folderdir, model);

