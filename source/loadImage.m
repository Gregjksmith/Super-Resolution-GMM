function [ image ] = loadImage( filePath, channelIndex )
    image = RGBtoYPBR((imread(filePath)));
    image = image(:,:,channelIndex);
end

