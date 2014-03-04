im1 = im2double(imread('apple.jpg'));
im2 = im2double(imread('orange.jpg'));

im1 = imresize(im1, [400 400]);
im2 = imresize(im2, [400 400]);

laplacian(im1,im2);