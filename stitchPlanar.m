function mergedImage = stitchPlanar(im1, im2, H)

[im1y, im1x, a] = size(im1);
[mesh1x,mesh1y, mesh1z] = meshgrid(1:im1x, 1:im1y, 1);
[mesh2x,mesh2y, mesh2z] = meshgrid(1:1.5*im1x, 1:1.5*im1y, 1);


tmp = [mesh2x(:) mesh2y(:) ones(size(mesh2x(:)))]*transpose(H);

mesh2xheight = tmp(:,1)./tmp(:,3);
mesh2yheight = tmp(:,2)./tmp(:,3);
mesh2xsize = size(mesh2x);
mesh2ysize = size(mesh2y);
mesh2x_h = reshape( mesh2xheight, mesh2xsize);
mesh2y_h = reshape( mesh2yheight, mesh2ysize);

im1mesh = zeros(size(mesh2x));
im2mesh = zeros(size(mesh2x));
im1mask = zeros(size(mesh2x));
im2mask = zeros(size(mesh2x));

for i=1:3
im1mesh(:,:,i) = interp2(mesh1x,mesh1y,im1(:,:,i), mesh2x, mesh2y,'linear',0);
im2mesh(:,:,i) = interp2(mesh1x,mesh1y,im2(:,:,i),mesh2x_h, mesh2y_h,'linear',0);
im1mask(:,:,i) = interp2(mesh1x,mesh1y,ones(size(im1(:,:,i))),mesh2x, mesh2y, 'linear', 0);
im2mask(:,:,i) = interp2(mesh1x,mesh1y,ones(size(im2(:,:,i))),mesh2x_h, mesh2y_h,'linear',0);
end

mask = (im1mask + im2mask) ./2;
mergedImage = (im1mesh+im2mesh)./(2*mask);
keyboard;
end