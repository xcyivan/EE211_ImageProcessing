b_girlface=im2double(imread('girlface_blurred.tiff'));
b_lena=im2double(rgb2gray(imread('lena_blurred.tiff')));
lena=im2double(rgb2gray(imread('lena.jpg')));

% Problem 1
%trial process
for i=0.1:0.1:1
    for j=1:10
    figure();
    h = fspecial('gaussian', [j j], i);
    rec_girlface = imfilter(b_girlface,ifft2(1./fft2(h)));
    rec_lena = imfilter(b_lena,ifft2(1./fft2(h)));
    imshow(rec_lena)
    end
end

% get k=3 i=0.9 as the best parameters
h = fspecial('gaussian', [3 3], 0.9);
rec_girlface = imfilter(b_girlface,ifft2(1./fft2(h)));
rec_lena = imfilter(b_lena,ifft2(1./fft2(h)));
subplot(221)
imshow(b_girlface)
title('blurred image')
subplot(222)
imshow(rec_girlface)
title('recovered image')
subplot(223)
imshow(b_lena)
('blurred image')
subplot(224)
imshow(rec_lena)
title('recovered image')


% Problem 2
% for lena_2
[picWidth picHigh]=size(lena);
h2 = fspecial('gaussian', [15 15], 3);
b2_lena = imfilter(lena,h2);
VAR = 0.05; % 0.05 0.1
noise = randn(picWidth, picHigh).*VAR;
b2n_lena = b2_lena + noise;

% trial process
fcut = 0.01:0.01:1;
PSNR = zeros(size(fcut));
for i= 1:length(fcut)
    for k = 15:15
        for j = 1:1
            j
            H2 = fft2(fspecial('gaussian',[k,k],j));
            H2_res = zeros(size(H2));
            H2_res(find(abs(H2)>fcut(i))) = 1./H2(find(abs(H2)>fcut(i)));
            h2_res = ifft2(H2_res);
            b2nr_lena = imfilter(b2n_lena,h2_res);
            PSNR(i) = psnr(b2nr_lena,lena);
%             figure;
%             imshow(b2nr_lena);
            title(['fcut=',num2str(fcut(i)),', k=', num2str(k),', j=',num2str(j)])
        end
    end
end
figure();
plot(fcut, PSNR);
title(['VAR=',num2str(VAR),'   PSNR vs cut frequency'])

% result: 
% for noise VAR=0.1  pick hsize=6, deviation=1, fcut = 0.65
% for noise VAR=0.05 pick hsize=15, deviation=1, fcut = 0.6
% for noise VAR=0.01 pick hsize=15, deviation=0.7, fcut = 0.4
H2 = fft2(fspecial('gaussian',[15,15],1));
H2_res = zeros(size(H2));
H2_res(find(abs(H2)>0.6)) = 1./H2(find(abs(H2)>0.6));
h2_res = ifft2(H2_res);
b2nr_lena = imfilter(b2n_lena,h2_res);
subplot(221)
imshow(lena)
title('original image')
subplot(222)
imshow(b2_lena)
title('blurred image')
subplot(223)
imshow(b2n_lena)
title(['VAR=', num2str(VAR),' noise added image'])
subplot(224)
imshow(b2nr_lena)
title('recovered image')


% Problem 3
K=(checkerboard>0.5);
[picWidth picHigh]=size(K);
figure();
subplot(231)
imshow(K)
PSF=fspecial('motion',20,10);
b_K = imfilter(K,PSF);
subplot(232)
imshow(b_K);
noise=randn(picWidth, picHigh)*0.2;
bn_K = b_K + noise;
subplot(233)
imshow(bn_K);

NoisePower=abs(fftn(noise)).^2;
NCORR = fftshift(real(ifftn(NoisePower)));
ImagePower=abs(fftn(K)).^2;
ICORR = fftshift(real(ifftn(ImagePower)));
wnr = deconvwnr(bn_K,PSF,NCORR,ICORR);
subplot(234)
imshow(wnr)
wnr2 = deconvwnr(bn_K, PSF, 0.1);
subplot(235)
imshow(wnr2)

imshow(PSF,[],'InitialMagnification','fit')






% deprecated

% % for lena_1
% % trial process
% fcut = 0.01:0.01:1;
% PSNR = zeros(size(fcut));
% for i= 1:length(fcut)
%     for k = 3:3
%         for j = 0.9:0.9
%             H2 = fft2(fspecial('gaussian',[k,k],j));
%             H2_res = zeros(size(H2));
%             H2_res(find(abs(H2)>fcut(i))) = 1./H2(find(abs(H2)>fcut(i)));
%             h2_res = ifft2(H2_res);
%             br_lena = imfilter(b_lena,h2_res);
%             PSNR(i) = psnr(br_lena,lena);
% %             figure;
%             imshow(br_lena);
%             title(['fcut=',num2str(fcut(i)),', k=', num2str(k),', j=',num2str(j)])
%         end
%     end
% end
% figure();
% plot(fcut, PSNR);
% title(['PSNR vs cut frequency for lena_1'])
% 
% %result
% % pick hsize=3, deviation=0.9, fcut = 0.1
% H2 = fft2(fspecial('gaussian',[3,3],0.9));
% H2_res = zeros(size(H2));
% H2_res(find(abs(H2)>0.1)) = 1./H2(find(abs(H2)>0.1));
% h2_res = ifft2(H2_res);
% br_lena = imfilter(b_lena,h2_res);
% subplot(131)
% imshow(lena)
% title('original image')
% subplot(132)
% imshow(b_lena)
% title('blurred image')
% subplot(133)
% imshow(br_lena)
% title('recovered image')
% 
% % for girlface
% % trial process
% fcut = 0.01:0.01:1;
% PSNR = zeros(size(fcut));
% for i= 1:length(fcut)
%     for k = 3:3
%         for j = 0.9:0.9
%             H2 = fft2(fspecial('gaussian',[k,k],j));
%             H2_res = zeros(size(H2));
%             H2_res(find(abs(H2)>fcut(i))) = 1./H2(find(abs(H2)>fcut(i)));
%             h2_res = ifft2(H2_res);
%             br_girlface = imfilter(b_girlface,h2_res);
%             PSNR(i) = psnr(br_girlface,rec_girlface);
% %             figure;
%             imshow(br_girlface);
%             title(['fcut=',num2str(fcut(i)),', k=', num2str(k),', j=',num2str(j)])
%         end
%     end
% end
% figure();
% plot(fcut, PSNR);
% title(['PSNR vs cut frequency for girlface'])
% 
% %result
% % pick hsize=3, deviation=0.9, fcut = 0.1
% H2 = fft2(fspecial('gaussian',[3,3],0.9));
% H2_res = zeros(size(H2));
% H2_res(find(abs(H2)>0.1)) = 1./H2(find(abs(H2)>0.1));
% h2_res = ifft2(H2_res);
% br_girlface = imfilter(b_girlface,h2_res);
% subplot(121)
% imshow(b_girlface)
% title('blurred image')
% subplot(122)
% imshow(br_girlface)
% title('recovered image')
