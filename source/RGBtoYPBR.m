function [ imageOut ] = RGBtoYPBR( imageIn )
    Mypbr = [ 0.299, 0.587, 0.114; 
        -0.169, -0.331, 0.5; 
        0.5, -0.419, -0.081];    

    imageOut(:,:,1) = Mypbr(1,1)*imageIn(:,:,1) + Mypbr(1,2)*imageIn(:,:,2) + Mypbr(1,3)*imageIn(:,:,3);
    imageOut(:,:,2) = Mypbr(2,1)*imageIn(:,:,1) + Mypbr(2,2)*imageIn(:,:,2) + Mypbr(2,3)*imageIn(:,:,3);
    imageOut(:,:,3) = Mypbr(3,1)*imageIn(:,:,1) + Mypbr(3,2)*imageIn(:,:,2) + Mypbr(3,3)*imageIn(:,:,3);

end

