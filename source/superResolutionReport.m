%SuperResolution Gaussian Mixture Report
%Greg Smith, 2015
clear all;

%SUPER_RESOLUTION by GMM BASED CONVERSION USING SELF_REDUCTION IMAGE:
%restore: conversion to uint8
%imshow[0:255]
%psnr is from 1-255
%I is created by decimating GroundTruth by 3
%loadImage does not convert to double
%super res type casts, Y as uint8
%super res upscales IL by 3 instead of 2
%esimation set and training set use factors of 3 instead of 2

%load The Image Being Super Resolved
fileName = char('lena_color');
fileExtension = char('.png');
ImageGroundTruth = loadImage(strcat(fileName,fileExtension),1);
%downsize the image
ImageGroundTruth = imresize(ImageGroundTruth,[576,576],'bicubic');
I = ImageGroundTruth;
I = uint8(downgradeImage(I,0.48));
I = imresize(I,1/3,'bilinear');

%obtain the bicubic image for comparison
bicubicImage = imresize(I,3,'bicubic');

%export the bicubic image
f = figure(1);
[psnr,ssim,v] = PSNR_SSIM(ImageGroundTruth,bicubicImage);
himage = imshow(bicubicImage,[0,255]);
title(strcat(fileName, ' Bicubic Image' ));
xlabel(strcat('PSNR: ', num2str(psnr), '    SSIM: ', num2str(ssim), '    VSNR: ', num2str(v)));
saveas(f,strcat('imageOutput/',fileName,'BicubicComparison.tiff'),'tif');
imwrite(bicubicImage,'bicubicImage.tif','tiff');

patchSize = 3;
reg = 0.0000001;
numGaussians = 5;


[superRes,gmm] = superResolveImage(I,I,numGaussians,patchSize,reg);
[psnr,ssim,v] = PSNR_SSIM(ImageGroundTruth,superRes);
f = figure(1);
himage = imshow(superRes);
title(strcat(fileName, ' Super-Resolution Image, K: ',num2str(numGaussians), '  patch size: ', num2str(patchSize), '  regularization: ', num2str(reg)   ));
xlabel(strcat('PSNR: ', num2str(psnr), '    SSIM: ', num2str(ssim), '    VSNR: ', num2str(v)));
saveas(f,strcat('imageOutput/', fileName,'SuperResolution K',num2str(numGaussians), ' P', num2str(patchSize), ' R', num2str(reg),'.tiff'),'tif');
