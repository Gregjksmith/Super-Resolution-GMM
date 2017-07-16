function [ p,s,v ] = PSNR_SSIM( groundTruth, restored )

N = size(restored,1);
M = size(restored,2);

imageBorderSize = 1;
%I = groundTruth(imageBorderSize:N-imageBorderSize,imageBorderSize:M-imageBorderSize);
%IL = restored(imageBorderSize:N-imageBorderSize,imageBorderSize:M-imageBorderSize);
IL = restored;
I = groundTruth(1:N,1:M);

imwrite(abs(IL - I),'diff.tif', 'tiff');

mmse_super = sum(sum( ((I-IL).^2) ))/((N)*(M));
p = 10*log10((255^2)/mmse_super);

meanI = mean(I(:));
meanIL = mean(IL(:));
covariance = cov(double(I(:)),double(IL(:)));

% cI = double(0);
% 
% for i=1:N
%     for j=1:M
%         cI = cI + double( (double(I(i,j)) - meanI)*(double(IL(i,j)) - meanIL));
%     end
% end
% 
% cI = cI/(N*M);

%s = (2*meanI*meanIL)*(2(covariance(1,2)))/( (meanI^2 + meanIL^2)*(covariance(1,1) + covariance(2,2) ));

%vI = var(double(I(:)));
%vIL = var(double(IL(:)));

k1 = 0.01;
k2 = 0.03;
C1 = k1^2;
C2 = k2^2;

%s_comp = ((2*meanI*meanIL +  C1)*(2*covariance(2,1) + C2))/ ( (meanI^2 + meanIL^2 + C1)*(covariance(1,1) + covariance(2,2) + C2));
s_comp_mean = (2*meanI*meanIL)/(meanI^2 + meanIL^2);
s_comp_cov = (2*covariance(2,1))/(covariance(1,1) + covariance(2,2));
s_comp = s_comp_mean*s_comp_cov;

%s = ssim(double(I),double(IL),[0.01 0.03],fspecial('gaussian', 11, 1.5),1);
s = s_comp;%ssim(double(I),double(IL));
v = vsnr(double(I),double(IL));
end

