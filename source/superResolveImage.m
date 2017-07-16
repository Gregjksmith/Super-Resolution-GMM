function [ superImage,obj ] = superResolveImage( lowResImage, trainingSet, numGaussianMixtures, patchSize ,regularization)

PATCH_SIZE = patchSize;
K = numGaussianMixtures;

I = lowResImage;
IL = imresize(I,3,'bicubic');
Z = createTrainingSet(trainingSet,PATCH_SIZE);
'training set complete'

obj = gmdistribution.fit(Z,K,'Regularize',regularization);
'GMM training complete'


X = createEstimationSet(I,PATCH_SIZE);
'estimation set complete'

N = size(lowResImage,1)*3;
M = size(lowResImage,2)*3;


n = 1;
for yIndexN=1:PATCH_SIZE:PATCH_SIZE*floor(N/PATCH_SIZE)
    for yIndexM = 1:PATCH_SIZE:PATCH_SIZE*floor(M/PATCH_SIZE)
    
        x = X(n,:);

        for m=1:K
            w(m) = obj.PComponents(1,m)*NormalRegularized( x, obj.mu(m,1:4*PATCH_SIZE*PATCH_SIZE), obj.Sigma(1:4*PATCH_SIZE*PATCH_SIZE,1:4*PATCH_SIZE*PATCH_SIZE,m),regularization);
        end
        w  =  w/sum(sum(w));
        y = zeros(PATCH_SIZE*PATCH_SIZE,1);
        for m = 1:K
            y = y + w(m)*( obj.mu(m,4*PATCH_SIZE*PATCH_SIZE + 1:5*PATCH_SIZE*PATCH_SIZE)' + obj.Sigma(4*PATCH_SIZE*PATCH_SIZE + 1:5*PATCH_SIZE*PATCH_SIZE, 1:4*PATCH_SIZE*PATCH_SIZE,m)*pinv(obj.Sigma(1:4*PATCH_SIZE*PATCH_SIZE,1:4*PATCH_SIZE*PATCH_SIZE,m))*( x' - obj.mu(m,1:4*PATCH_SIZE*PATCH_SIZE)' ));
        end
        Y(yIndexN:yIndexN+PATCH_SIZE-1,yIndexM:yIndexM+PATCH_SIZE-1) = reshape(y,PATCH_SIZE,PATCH_SIZE)';
        n
        n = n + 1;
    end
    
end

%IL = imresize(IL,[size(Y,1), size(Y,2)],'bicubic');
IL = IL(1:size(Y,1),1:size(Y,2));
superImage = uint8(round(Y)) + IL;

end