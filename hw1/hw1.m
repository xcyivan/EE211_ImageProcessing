% % Exercise 1
% (a)
r = [1,0,0; 1,0,1; 1,0,1];
g = [0,0,0; 1,1,0; 1,1,1];
b = [0,0,1; 0,0,1; 1,1,1];

subplot(1,2,1);
rgb_image = cat(3,r,g,b);
f1 = imshow(rgb_image,'InitialMagnification',10000);
title('RGB Image');

% (b)
subplot(1,2,2);
[X,map] = rgb2ind(rgb_image,8);
f2 = imshow(X,map,'InitialMagnification',10000);
title('Indexed Image');

% (c)
figure();
for i = 1:5
    c = 0.2*i;
    rgb_scaled = cat(3, r*c, g*c, b*c);
    subplot(1,5,i);
    imshow(rgb_scaled,'InitialMagnification',10000)
    title(['c=', num2str(c)]);
end

% % Exercise 2
% (a)
figure();
rgb_parrots = imread('parrots.tif');
subplot(1,2,1);
f3 = imshow(rgb_parrots);
title('rgb image');
gray_parrots = rgb2gray(rgb_parrots);
subplot(1,2,2);
f4 = imshow(gray_parrots);
title('gay image');

% (b)
for i = 0:5
    [X2,map2] = rgb2ind(rgb_parrots,256/power(2,i));
    newmap2 = rgb2gray(map2);
    figure();
    imshow(X2,newmap2);
    title(['N=', num2str(256/power(2,i))]);
end

% % Exercise 3
for i = 0:5
    [X3,map3] = rgb2ind(rgb_parrots,256/power(2,i));
    whos;
    figure();
    subplot(1,2,1);
    imshow(X3,map3);
    title(['N=', num2str(256/power(2,i))]);
    subplot(1,2,2);
    rgbplot(map3);
    title('RGB map');
end

% % Exercise 4
d1 = 4
d2 = 2
fs = 200
h = 1
ftheta1 = pi*d1*fs/180/h 
ftheta2 = pi*d2*fs/180/h 

% % Exercise 5
% (a)
pi*d*MN/180/h/w = 10
% (b)
a) pro: reduce hardware cost, less blurring between frames, con: more blurring inside per fram
b) pro: reduce hardware cost, less blurring inside per frame, more blurring between frames
c) pro: save handwidth, con: flickering between odd lines and even lines
prefer c) because we save band width and save cost
% (c)
no because the spatial frequency is 0
maybe now the spatial frequency is not 0, but it can only be opbserved when it's over certain value