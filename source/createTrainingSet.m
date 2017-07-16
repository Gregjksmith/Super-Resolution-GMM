function [ Z ] = createTrainingSet( I , patchSize)

IR = uint8(downgradeImage(I,0.48));
IR = imresize(IR,1/3,'bilinear');
IL = imresize(IR,3,'bicubic');
IF = I - IL;

H1 = [0,0,1,0,0,-1];
H2 = [0,0,1,0,0,-1]';
H3 = [0.5, 0,0, -1, 0, 0, 0.5];
H4 = [0.5, 0,0, -1, 0, 0, 0.5]';

ILH1 = conv2(IL,H1,'same');
ILH2 = conv2(IL,H2,'same');
ILH3 = conv2(IL,H3,'same');
ILH4 = conv2(IL,H4,'same');

N = size(I,1);
M = size(I,2);

Z = zeros((N-patchSize)*(M-patchSize),5*(patchSize*patchSize));
zIndex = 1;
for i=1:1:N-patchSize
    for j=1:1:M-patchSize
        
        patch = ILH1(i:i+patchSize-1, j:j+patchSize-1)';
        Z(zIndex,1:patchSize*patchSize) = patch(:)';
        
        patch = ILH2(i:i+patchSize-1, j:j+patchSize-1)';
        Z(zIndex, patchSize*patchSize +1: 2*patchSize*patchSize) = patch(:)';
        
        patch = ILH3(i:i+patchSize-1, j:j+patchSize-1)';
        Z(zIndex, 2*patchSize*patchSize +1: 3*patchSize*patchSize) = patch(:)';
        
        patch = ILH4(i:i+patchSize-1, j:j+patchSize-1)';
        Z(zIndex, 3*patchSize*patchSize +1: 4*patchSize*patchSize) = patch(:)';
        
        patch = IF(i:i+patchSize-1, j:j+patchSize-1)';
        Z(zIndex, 4*patchSize*patchSize +1: 5*patchSize*patchSize) = patch(:)';
        

        zIndex = zIndex + 1;
        
    end
end

end

