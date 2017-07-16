function [ X ] = createEstimationSet( I ,patchSize )

IprimeL = imresize(I,3,'bicubic');

H1 = [0,0,1,0,0,-1];
H2 = [0,0,1,0,0,-1]';
H3 = [0.5, 0,0, -1, 0, 0, 0.5];
H4 = [0.5, 0,0, -1, 0, 0, 0.5]';

IpH1 = conv2(IprimeL,H1,'same');
IpH2 = conv2(IprimeL,H2,'same');
IpH3 = conv2(IprimeL,H3,'same');
IpH4 = conv2(IprimeL,H4,'same');

N = size(IprimeL,1);
M = size(IprimeL,2);
zIndex = 1;

X = zeros((N-patchSize)*(M-patchSize),4*patchSize*patchSize);

for i=1:patchSize:patchSize*floor(N/patchSize)
    for j=1:patchSize:patchSize*floor(M/patchSize)
        patch = IpH1(i:i+patchSize-1, j:j+patchSize-1)';
        X(zIndex,1:patchSize*patchSize) = patch(:)';
        
        patch = IpH2(i:i+patchSize-1, j:j+patchSize-1)';
        X(zIndex, patchSize*patchSize +1: 2*patchSize*patchSize) = patch(:)';
        
        patch = IpH3(i:i+patchSize-1, j:j+patchSize-1)';
        X(zIndex, 2*patchSize*patchSize +1: 3*patchSize*patchSize) = patch(:)';
        
        patch = IpH4(i:i+patchSize-1, j:j+patchSize-1)';
        X(zIndex, 3*patchSize*patchSize +1: 4*patchSize*patchSize) = patch(:)';
        
        
        zIndex = zIndex + 1;
    end
end

end

