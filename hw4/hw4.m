%% problem 1
%  problem 1.1
dctdemo;

%  problem 1.2
dct_quant('lena128.bmp',1);
dct_quant('lena128.bmp',2);
dct_quant('lena128.bmp',5);



%%
%problem 2.1
clc;clear;
Aref = dctmtx(8);
k=0:7;
k=ones(8,1)*k;
i=k';
A=1/2*cos((2*k+1).*i*pi/16);
A(1,:)=sqrt(2)/4*cos((2*k(1,:)+1).*i(1,:)*pi/16);

%problem 2.2
ho=imread('lena128.bmp');

bx = 8; by = 8;
[sx sy] = size(ho);
nbx = floor(sx/bx);
nby = floor(sy/by);

% vectorize image
hodct = zeros([bx*by nbx*nby]);
hohar = zeros([bx*by nbx*nby]);

% You need to build haar tranform matrices
harmtx = 1/sqrt(8)*[
 1       1       1        1        1      1       1       1;
 1       1       1        1       -1     -1      -1      -1;
 sqrt(2) sqrt(2) -sqrt(2) -sqrt(2) 0      0       0       0;
 0       0       0        0       sqrt(2) sqrt(2) sqrt(2) sqrt(2);
 2       -2      0        0        0      0       0       0;
 0       0       2        -2       0      0       0       0;
 0       0       0        0        2     -2       0       0;
 0       0       0        0        0      0      -2       2]
% loop through 8x8 blocks
for lp1 = 1:nbx
    for lp2 = 1:nby
        nn = lp2 + (lp1-1)*nby;
        subim = ho(lp1*bx-7:lp1*bx,lp2*by-7:lp2*by);
        % You need to do DCT transform here
        subimt = subim;  % place holder
        temp = dct2(subimt);
        hodct(:,nn) = temp(:);
 
        % You need to do haar transform
        subimt = subim;  % place holder
        temp = harmtx * double(subimt);
        hohar(:,nn) = temp(:);
    end
end

% find variances along rows of hodct and hohar
% plot variances and cumulative variances
vardct=zeros(bx*by, 1);
varhar=zeros(bx*by, 1);
culvdct=zeros(bx*by,1);
culvhar=zeros(bx*by,1);
for i=1:bx*by
   vardct(i)=var(hodct(:,i));
   varhar(i)=var(hohar(:,i));
   tempdct=reshape(hodct(1:i,:), i*nbx*nby, 1);
   temphar=reshape(hohar(1:i,:), i*nbx*nby, 1);
   culvdct(i)=var(tempdct);
   culvhar(i)=var(temphar);
end

x = 1:bx*by;
figure;
semilogy(x,vardct,'rx-',x,varhar, 'bo-'),legend('dct','haar'),xlabel('subimage coefficient'),ylabel('log variance'),title('variances');

figure;
semilogy(x,culvdct,'rx-',x,culvhar, 'bo-'),legend('dct','haar'),xlabel('subimage coefficient'),ylabel('log cumulative variance'),title('cumulative variances');

% problem 2.4
clc;clear;
im=im2double(imread('lena128.bmp'));
imdct = blkproc(im,[8 8],'dct2');
seed1 = [ones(1,4) zeros(1,4)]' * [ones(1,4) zeros(1,4)];
seed2 = [ones(1,2) zeros(1,6)]' * [ones(1,2) zeros(1,6)];
mask1 = repmat(seed1, 16);
mask2 = repmat(seed2, 16);
imdcttr1 = imdct.*mask1;
imdcttr2 = imdct.*mask2;
imtr1 = blkproc(imdcttr1, [8 8], 'idct2');
imtr2 = blkproc(imdcttr2, [8 8], 'idct2');
figure;
imagesc(imtr1);colormap(gray);title('use 25% coefficient');
figure;
imagesc(imtr2);colormap(gray);
psnr1 = psnr(imtr1,double(im));title('use 6.25% coefficient');
psnr2 = psnr(imtr2,double(im));

%% problem 3
clear; clc;
im=imread('lena128.bmp');
imdct = blkproc(im,[8 8],'dct2');
steps = 2*[5, 8, 11, 14, 17, 20];
mse = zeros(1,6);
m_psnr = zeros(1,6);
for i = 1:6
    stepsize = steps(i);
    qimdct = round(imdct./stepsize).*stepsize;
    recim = round(blkproc(qimdct,[8 8],'idct2'));
    dif2 = (double(im) - recim).^2;
    mse(i) = sum(dif2(:))/128^2;
    m_psnr(i) = psnr(recim,double(im));
    figure;
    imagesc(recim); colormap(gray);
    title(['stepsize=',num2str(stepsize),',mse=',num2str(mse(i)),',psnr=',num2str(m_psnr(i))])
end