
%For each image block, perform DCT, quantization and inverse DCT
%User can specify the QP for quantization
%This program calls function "blkdct_quant"

function dct_quant(fname,QP)


img=imread(fname);
figure; 
imagesc(img); 
colormap(gray); truesize; axis off;
title('Original Image');
qimg=blkproc(img,[8 8],'blkdct_quant',QP);
figure; 
imagesc(qimg); 
colormap(gray);
title(['DCT Domain Quantized Image Q=',num2str(QP)]);truesize; axis off;
