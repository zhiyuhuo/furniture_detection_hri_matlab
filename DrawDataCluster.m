clc;
clear;
close all;
%

%load lib file
% lib = load('furniture_100_normal_feature_lib');
lib = load('furniture_100_33_fpfh_feature_lib.mat');
featurelib = lib.furniturelib.featurelib;
labellib = lib.furniturelib.labellib;

idx = find(strcmp(labellib, 'couch') == 1)

X = featurelib(idx, :);

createVAT(X)