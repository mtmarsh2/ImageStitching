
function [ imout ] = laplacian( im1, im2, mask1, mask2 )

im1copy = im1;
im2copy = im2;

gFilter = fspecial('gaussian',[5 5],4);

%create mask
[mx, my, mz] = size(im1copy);
mask1 = im1copy;
mask1(:,1:my/2,:) = 1;
mask1(:,mx/2:end,:) = 0;
mask2 = im2copy;
mask2(:,1:my/2,:) = 0;
mask2(:,mx/2:end,:) = 1;

%Start gaussian blend on im1copy
Ig1 = imfilter(im1copy,gFilter,'same');
im1copy = imresize(im1copy, .5);
Ig2 = imfilter(im1copy,gFilter,'same');
im1copy = imresize(im1copy, .5);
Ig3 = imfilter(im1copy,gFilter,'same');
im1copy = imresize(im1copy, .5);
Ig4 = imfilter(im1copy,gFilter,'same');
im1copy = imresize(im1copy, .5);
Ig5 = imfilter(im1copy,gFilter,'same');
im1copy = imresize(im1copy, .5);

%Create Laplacian images for im1copy
Lp5 = Ig5;
[mx,my,mz] = size(Ig5);
mask15 = imresize(mask1, [mx, my]);
mask25 = imresize(mask2, [mx, my]);
[lpx, lpy, lpz] = size(Ig4);
mask14 = imresize(mask1, [lpx, lpy]);
mask24 = imresize(mask2, [lpx, lpy]);
Lp4 = Ig4 - imresize(Ig5, [lpx, lpy]);
[lpx, lpy, lpz] = size(Ig3);
mask13 = imresize(mask1, [lpx, lpy]);
mask23 = imresize(mask2, [lpx, lpy]);
Lp3 = Ig3 - imresize(Ig4, [lpx, lpy]);
[lpx, lpy, lpz] = size(Ig2);
mask12 = imresize(mask1, [lpx, lpy]);
mask22 = imresize(mask2, [lpx, lpy]);
Lp2 = Ig2 - imresize(Ig3, [lpx, lpy]);
[lpx, lpy, lpz] = size(Ig1);
mask11 = imresize(mask1, [lpx, lpy]);
mask21 = imresize(mask2, [lpx, lpy]);
Lp1 = Ig1 - imresize(Ig2, [lpx, lpy]);


%Start gaussian blend on im2copy
IG1 = imfilter(im2copy,gFilter,'same');
im2copy = imresize(im2copy, .5);
IG2 = imfilter(im2copy,gFilter,'same');
im2copy = imresize(im2copy, .5);
IG3 = imfilter(im2copy,gFilter,'same');
im2copy = imresize(im2copy, .5);
IG4 = imfilter(im2copy,gFilter,'same');
im2copy = imresize(im2copy, .5);
IG5 = imfilter(im2copy,gFilter,'same');
im2copy = imresize(im2copy, .5);

%Create Laplacian images for im2copy
LP5 = IG5;
[lpx, lpy, lpz] = size(IG4);
LP4 = IG4 - imresize(IG5, [lpx, lpy]);
[lpx, lpy, lpz] = size(IG3);
LP3 = IG3 - imresize(IG4, [lpx, lpy]);
[lpx, lpy, lpz] = size(IG2);
LP2 = IG2 - imresize(IG3, [lpx, lpy]);
[lpx, lpy, lpz] = size(IG1);
LP1 = IG1 - imresize(IG2, [lpx, lpy]);


Lp5 = Lp5.*mask15 + LP5.*mask25;
Lp4 = Lp4.*mask14 + LP4.*mask24;
Lp3 = Lp3.*mask13 + LP3.*mask23;
Lp2 = Lp2.*mask12 + LP2.*mask22;
Lp1 = Lp1.*mask11 + LP1.*mask21;



%Finish
[lpx, lpy, lpz] = size(Lp4);
Lp4 = Lp4 + imresize(Lp5, [lpx, lpy]);
[lpx, lpy, lpz] = size(Lp3);
Lp3 = Lp3 + imresize(Lp4, [lpx, lpy]);
[lpx, lpy, lpz] = size(Lp2);
Lp2 = Lp2 + imresize(Lp3, [lpx, lpy]);
[lpx, lpy, lpz] = size(Lp1);
Lp1 = Lp1 + imresize(Lp2, [lpx, lpy]);

imout = Lp1;
end

