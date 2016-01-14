%% preparation
b_girlface=im2double(imread('girlface_blurred.tiff'));
b_lena=im2double(rgb2gray(imread('lena_blurred.tiff')));
lena=im2double(rgb2gray(imread('lena.jpg')));

%% problem 1
%trial process
figure;
subplot(231);
imshow(lena);
title('original image')
subplot(232);
imshow(deconvreg(imfilter(lena,fspecial('gaussian',5,5)),fspecial('gaussian',2,5)));
title('recover with (2,5)')
subplot(233);
imshow(deconvreg(imfilter(lena,fspecial('gaussian',5,5)),fspecial('gaussian',5,1)));
title('recover with (5,1)')
subplot(234);
imshow(deconvreg(imfilter(lena,fspecial('gaussian',5,5)),fspecial('gaussian',5,5)));
title('recover with (5,5)')
subplot(235);
imshow(deconvreg(imfilter(lena,fspecial('gaussian',5,5)),fspecial('gaussian',8,5)));
title('recover with (8,5)')
subplot(236);
imshow(deconvreg(imfilter(lena,fspecial('gaussian',5,5)),fspecial('gaussian',5,9)));
title('recover with (5,9)')

%trvial phase
for i=28:28
    for j=3:0.1:4
    h = fspecial('gaussian', i, j);
%     rec_lena = deconvreg(b_lena,h);
    rec_girlface = deconvreg(b_girlface,h);
    figure;
    imshow(rec_girlface);
    title(['sigma=',num2str(j),'hsize=',num2str(i)]);
    end
end

% result
% lena
figure;
subplot(121);
imshow(b_lena);
title(['blurred imaged']);
subplot(122);
imshow(deconvreg(b_lena,fspecial('gaussian',25,3)));
title(['recovered imaged with hsize=25, sigma=3']);

% girlface
figure;
subplot(121);
imshow(b_girlface);
title(['blurred imaged']);
subplot(122);
imshow(deconvreg(b_girlface,fspecial('gaussian',25,3)));
title(['recovered imaged with hsize=25, sigma=3']);


h=fspecial('gaussian',25,3);
surf(h)
colormap(jet)
title('PSF magnitude');
imagesc(h)
colormap(gray)
title('scaled displayed PSF');


%% problem 2
[picWidth picHigh]=size(lena);
h2 = fspecial('gaussian', 25, 3);
H2 = fft2(h2, picWidth, picHigh);
b2_lena = real(ifft2(H2.*fft2(lena)));
VAR1 = 0.01;
VAR2 = 0.05;
VAR3 = 0.1;
noise1 = randn(picWidth, picHigh).*VAR1;
noise2 = randn(picWidth, picHigh).*VAR2;
noise3 = randn(picWidth, picHigh).*VAR3;
b2n1_lena = b2_lena + noise1;
b2n2_lena = b2_lena + noise2;
b2n3_lena = b2_lena + noise3;
B2N1_LENA = fft2(b2n1_lena);
B2N2_LENA = fft2(b2n2_lena);
B2N3_LENA = fft2(b2n3_lena);

subplot(131)
imshow(b2n1_lena);
title('original image')
subplot(132)
imshow(b2n2_lena);
title('blurred image')
subplot(133)
imshow(b2n3_lena);
title('noise added')

% trial process
fcut = 0:0.01:0.5;
PSNR1 = zeros(size(fcut));
PSNR2 = zeros(size(fcut));
PSNR3 = zeros(size(fcut));


for i= 1:length(fcut)

    B2N1R_LENA = zeros(picWidth,picHigh);
    B2N2R_LENA = zeros(picWidth,picHigh);
    B2N3R_LENA = zeros(picWidth,picHigh);

    valid_indices = find(abs(H2)>fcut(i));

    B2N1R_LENA(valid_indices) = B2N1_LENA(valid_indices)./H2(valid_indices);
    B2N2R_LENA(valid_indices) = B2N2_LENA(valid_indices)./H2(valid_indices);
    B2N3R_LENA(valid_indices) = B2N3_LENA(valid_indices)./H2(valid_indices);

    b2n1r_lena = real(ifft2(B2N1R_LENA));
    b2n2r_lena = real(ifft2(B2N2R_LENA));
    b2n3r_lena = real(ifft2(B2N3R_LENA));

    PSNR1(i) = psnr(b2n1r_lena,lena);
    PSNR2(i) = psnr(b2n2r_lena,lena);
    PSNR3(i) = psnr(b2n3r_lena,lena);
end
figure();
plot(fcut, PSNR1);
title(['VAR=0.01 PSNR vs cut frequency']);
figure();
plot(fcut, PSNR2);
title(['VAR=0.05 PSNR vs cut frequency']);
figure();
plot(fcut, PSNR3);
title(['VAR=0.1 PSNR vs cut frequency']);

% % result
subplot(231)
imshow(b2n1_lena);
title('noise var=0.01')
subplot(232)
imshow(b2n2_lena);
title('noise var=0.05')
subplot(233)
imshow(b2n3_lena);
title('noise var=0.1')
subplot(234)
imshow(b2n1r_lena);
title('recoverd from var=0.01')
subplot(235)
imshow(b2n2r_lena);
title('recoverd from var=0.05')
subplot(236)
imshow(b2n3r_lena);
title('recoverd from var=0.1')


%% problem 3
% Problem 3
% K=im2double((checkerboard>0.5));
K=(checkerboard>0.5);
[picWidth picHigh]=size(K);
PSF=fspecial('motion',20,10);
b_K = imfilter(K,PSF);
noise=randn(picWidth, picHigh)*0.2;
bn_K = b_K + noise;

NoisePower=abs(fftn(noise)).^2;
NCORR = fftshift(real(ifftn(NoisePower)));
ImagePower=abs(fftn(K)).^2;
ICORR = fftshift(real(ifftn(ImagePower)));
nsr=var(noise(:))/var(K(:))

figure();
subplot(231)
imshow(K);
title('original checkerboard');
subplot(232)
imshow(b_K);
title('blurred checkerboard with motion filter');
subplot(233)
imshow(bn_K);
title('noise added');
subplot(234)
wnr1 = deconvwnr(bn_K, PSF, 0);
imshow(wnr1)
title('with NSR=0');
wnr2 = deconvwnr(bn_K, PSF, nsr);
subplot(235)
imshow(wnr2)
title('with NSR calculated');
subplot(236)
wnr3 = deconvwnr(bn_K,PSF,NCORR,ICORR);
imshow(wnr3)
title('with autocorrelation');


g1=fftshift(real(ifft2((fft2(wnr1)./fft2(bn_K)))));
g2=fftshift(real(ifft2((fft2(wnr2)./fft2(bn_K)))));
g3=fftshift(real(ifft2((fft2(wnr3)./fft2(bn_K)))));
figure();
surf(g1);
title('PSF of filter with NSR=0')
figure();
surf(g2)
title('PSF of filter WITH NSR calculated')
figure();
surf(g3)
title('PSF with autocorrelation')
axis square; axis tight
