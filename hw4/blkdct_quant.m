
% This function does the following processing on each block: DCT, quantize DCT, inverse DCT
% This function is called by dct_exp

function qimblock=blkdct_quant(imblock,QP)


Qmatrix=[16,11,10,16,24,40,51,61;
   12,12,14,19,26,58,60,55;
   14,13,16,24,40,57,69,56;
   14,17,22,29,51,87,80,62;
   18,22,37,56,68,109,103,77;
   24,35,55,64,81,104,113,92;
   49,64,78,87,103,121,120,101;
   72,92,95,98,112,100,103,99];



dctblock=dct2(imblock);

QM=Qmatrix*QP;

qdct=floor((dctblock+QM/2)./QM);

iqdct=qdct.*QM;

qimblock=round(idct2(iqdct));


