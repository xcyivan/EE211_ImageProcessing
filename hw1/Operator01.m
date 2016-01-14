clc;clf;clear;
O=imread('parrots.tif');
M=im2double(O);
f=rgb2gray(O);
% imshow(f);
Fs=edge(f,'sobel');
Fp=edge(f,'prewitt');
% figure;imshow(f);title('origin');
% figure;imshow(Fs);title('sobel benchmark');
% figure;imshow(Fp);title('prewitt benchmark');
[L,H]=size(f);
% % initialization
Sobel=f;
Prewitt=f;
Laplace=f;
dif_s=f;
dif_p=f;
dif_l=f;
threshold_sobel=30;
threshold_prewitt=45;
threshold_laplace=30;

%%Sobel operator approximation
for i=2:1:L-1
    for j=2:1:H-1
        Gx=abs(f(i-1,j+1)+2*f(i,j+1)+f(i+1,j+1)-f(i-1,j-1)-2*f(i,j-1)-f(i+1,j-1));
        Gy=abs(f(i-1,j-1)+2*f(i-1,j)+f(i-1,j+1)-f(i+1,j-1)-2*f(i+1,j)-f(i+1,j+1));
        dif_s(i,j)=Gx+Gy;
    end
end

%%Prewitt operator approximation
for i=2:1:L-1
    for j=2:1:H-1
        Gx=abs(f(i-1,j+1)+f(i,j+1)+f(i+1,j+1)-f(i-1,j-1)-f(i,j-1)-f(i+1,j-1));
        Gy=abs(f(i-1,j-1)+f(i-1,j)+f(i-1,j+1)-f(i+1,j-1)-f(i+1,j)-f(i+1,j+1));
        dif_p(i,j)=Gx+Gy;
    end
end

%%Laplace operator approximation
for i=2:1:L-1
    for j=2:1:H-1
        dif_l(i,j)=abs(f(i-1,j-1)+f(i-1,j+1)+f(i+1,j-1)+f(i+1,j+1)-4*f(i,j));
    end
end

for i=1:L
    for j=1:H
        if(dif_s(i,j)>threshold_sobel) Sobel(i,j)=255;else Sobel(i,j)=0;end
        if(dif_p(i,j)>threshold_prewitt) Prewitt(i,j)=255;else Prewitt(i,j)=0;end
        if(dif_l(i,j)>threshold_laplace) Laplace(i,j)=255;else Laplace(i,j)=0;end
    end
end



% subplot(2,2,1);imshow(Fs);title('soble system');
% subplot(2,2,2);imshow(Sobel);title('soble approximation');
% subplot(2,2,3);imshow(Fp);title('prewitt system');
% subplot(2,2,4);imshow(Prewitt);title('prewitt approximation');
figure;
imshow(Laplace);title('laplace apporximation');

% figure;
% subplot(2,2,1);imshow(f);title('Origin Image');
% subplot(2,2,2);imshow(Sobel);title('soble approximation');
% subplot(2,2,3);imshow(Prewitt);title('prewitt approximation');
% subplot(2,2,4);imshow(Laplace);title('laplace apporximation');

