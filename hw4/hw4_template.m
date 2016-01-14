ho=imread('lena128.bmp');

bx = 8; by = 8;
[sx sy] = size(ho);
nbx = floor(sx/bx);
nby = floor(sy/by);

% vectorize image
hodct = zeros([bx*by nbx*nby]);
hohar = zeros([bx*by nbx*nby]);

% You need to build haar tranform matrices

% loop through 8x8 blocks
for lp1 = 1:nbx
    for lp2 = 1:nby
        nn = lp2 + (lp1-1)*nby;
        subim = ho(lp1*bx-7:lp1*bx,lp2*by-7:lp2*by);
        % You need to do DCT transform here
        subimt = subim;  % place holder
        hodct(:,nn) = subimt(:);
        hodct(:,nn) = dct2(subimt);
 
        % You need to do haar transform
        subimt = subim;  % place holder
        hohar(:,nn) = subimt(:);
        hohar(:,nn) = 

    end
end

% find variances along rows of hodct and hohar

% plot variances and cumulative variances
