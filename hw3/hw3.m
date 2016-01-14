im1=imread('Ex3Im1.tiff');
im2=imread('Ex3Im2.tiff');
im3=imread('Ex3Im3.tiff');
index = 2:256*256;

% (a)
%% H1
figure();
imhist(im1);
title('histogram of image 1');
figure();
imhist(im2);
title('histogram of image 2');
figure();
imhist(im3);
title('histogram of image 3');
e11=entropy(im1);
e21=entropy(im2);
e31=entropy(im3);

(b)
%% H2
im1_2(index)=im1(index)-im1(index-1);
im2_2(index)=im2(index)-im2(index-1);
im3_2(index)=im3(index)-im2(index-1);
im1_2(1)=im1(1);
im2_2(1)=im2(1);
im3_2(1)=im3(1);
imshow(im1_2);
imshow(im2_2);
imshow(im3_2);
e12=entropy(im1_2);
e22=entropy(im2_2);
e32=entropy(im3_2);

%% H3
im1t=im1';
im2t=im2';
im3t=im3';
im1_3(index)=im1t(index)-im1t(index-1);
im2_3(index)=im2t(index)-im2t(index-1);
im3_3(index)=im3t(index)-im2t(index-1);
im1_3(1)=im1t(1);
im2_3(1)=im2t(1);
im3_3(1)=im3t(1);
figure;
imshow(im1_3);
figure;
imshow(im2_3);
figure;
imshow(im3_3);
e13=entropy(im1_3);
e23=entropy(im2_3);
e33=entropy(im3_3);

%% H4
im1_zz = zigzag(im1);
im2_zz = zigzag(im2);
im3_zz = zigzag(im3);
im1_4=im1_zz;
im2_4=im2_zz;
im3_4=im3_zz;
im1_4(index) = im1_zz(index)-im1_zz(index-1);
im2_4(index) = im2_zz(index)-im2_zz(index-1);
im3_4(index) = im3_zz(index)-im3_zz(index-1);
e14=entropy(im1_4);
e24=entropy(im2_4);
e34=entropy(im3_4);

%% H5
im1_zzf = zigzag(fliplr(im1));
im2_zzf = zigzag(fliplr(im2));
im3_zzf = zigzag(fliplr(im3));
im1_5 = im1_zzf;
im2_5 = im2_zzf;
im3_5 = im3_zzf;
im1_5(index) = im1_zzf(index)-im1_zzf(index-1);
im2_5(index) = im2_zzf(index)-im2_zzf(index-1);
im3_5(index) = im3_zzf(index)-im3_zzf(index-1);
e15=entropy(im1_5);
e25=entropy(im2_5);
e35=entropy(im3_5);
disp(mean(im1_5(:)))
%% (c)
subplot(221);
imshow(im1);
title('original image')
subplot(222);
im1_eq=histeq(im1);
imshow(im1_eq);
title('contrast enhanced image')
subplot(223);
imhist(im1);
title('original histogram')
subplot(224);
imhist(im1_eq);
title('contrast enhanced histogram')

figure;
subplot(221);
imshow(im2);
title('original image')
subplot(222);
im2_eq=histeq(im2);
imshow(im2_eq);
title('contrast enhanced image')
subplot(223);
imhist(im2);
title('original histogram')
subplot(224);
imhist(im2_eq);
title('contrast enhanced histogram')

figure;
subplot(221);
imshow(im3);
title('original image')
subplot(222);
im3_eq=histeq(im3);
imshow(im3_eq);
title('contrast enhanced image')
subplot(223);
imhist(im3);
title('original histogram')
subplot(224);
imhist(im3_eq);
title('contrast enhanced histogram')

e11eq=entropy(im1_eq);
e21eq=entropy(im2_eq);
e31eq=entropy(im3_eq);

%% H2'
im1_2_eq=im1_eq;
im2_2_eq=im2_eq;
im3_2_eq=im3_eq;
im1_2_eq(index)=im1_eq(index)-im1_eq(index-1);
im2_2_eq(index)=im2_eq(index)-im2_eq(index-1);
im3_2_eq(index)=im3_eq(index)-im2_eq(index-1);
imshow(im1_2_eq);
imshow(im2_2_eq);
imshow(im3_2_eq);
e12eq=entropy(im1_2_eq);
e22eq=entropy(im2_2_eq);
e32eq=entropy(im3_2_eq);

%% H3
im1t_eq=im1_eq';
im2t_eq=im2_eq';
im3t_eq=im3_eq';
im1_3_eq=im1t_eq;
im2_3_eq=im2t_eq;
im3_3_eq=im3t_eq;
im1_3_eq(index)=im1t_eq(index)-im1t_eq(index-1);
im2_3_eq(index)=im2t_eq(index)-im2t_eq(index-1);
im3_3_eq(index)=im3t_eq(index)-im2t_eq(index-1);
figure;
imshow(im1_3_eq);
figure;
imshow(im2_3_eq);
figure;
imshow(im3_3_eq);
e13_eq=entropy(im1_3_eq);
e23_eq=entropy(im2_3_eq);
e33_eq=entropy(im3_3_eq);

%% H4
im1_zz_eq = vec2mat(zigzag(im1_eq),256);
im2_zz_eq = vec2mat(zigzag(im2_eq),256);
im3_zz_eq = vec2mat(zigzag(im3_eq),256);
im1_4_eq(1)=im1_zz_eq(1);
im2_4_eq(1)=im2_zz_eq(1);
im3_4_eq(1)=im3_zz_eq(1);
im1_4_eq(index) = im1_zz_eq(index)-im1_zz_eq(index-1);
im2_4_eq(index) = im2_zz_eq(index)-im2_zz_eq(index-1);
im3_4_eq(index) = im3_zz_eq(index)-im3_zz_eq(index-1);
e14_eq=entropy(im1_4_eq);
e24_eq=entropy(im2_4_eq);
e34_eq=entropy(im3_4_eq);

%% H5
im1_zzf_eq = vec2mat(zigzag(fliplr(im1_eq)),256);
im2_zzf_eq = vec2mat(zigzag(fliplr(im2_eq)),256);
im3_zzf_eq = vec2mat(zigzag(fliplr(im3_eq)),256);
im1_5_eq(1)=im1_zzf_eq(1);
im2_5_eq(1)=im2_zzf_eq(1);
im3_5_eq(1)=im3_zzf_eq(1);
im1_5_eq(index) = im1_zzf_eq(index)-im1_zzf_eq(index-1);
im2_5_eq(index) = im2_zzf_eq(index)-im2_zzf_eq(index-1);
im3_5_eq(index) = im3_zzf_eq(index)-im3_zzf_eq(index-1);
e15_eq=entropy(im1_5_eq);
e25_eq=entropy(im2_5_eq);
e35_eq=entropy(im3_5_eq);