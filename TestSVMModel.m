%
clc;
close all;
clear;
%

category = 0;
kernelstr = 'rbf';
model = load(['models/model_' kernelstr '_' num2str(category) '.mat']);
model = model.model;

lib = load('furniturelib.mat');
featurelib = lib.furniturelib.featurelib;
labellib = lib.furniturelib.labellib;


M = 50;
sample = featurelib(M,:);
label = labellib(M);


% y0 = svmclassify(model,sample);
y = furniture_rbf_classify(sample, model);

% disp([label y y0])
