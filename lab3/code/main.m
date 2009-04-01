close all
clear all
clc
load feat.mat
imagesc(multim)
colormap(gray)
cimage=MICD(multf8,f8t)
% imagesc(cimage)
% colormap(gray)