function mergedImage = userstitch(im1, im2)

points = 7;
imshow(im1)
im1_coords = ginput(points);

close all; 
imshow(im2);
im2_coords = ginput(points);
close all;

H = computeHomography(im1_coords(:,1), im1_coords(:,2), im2_coords(:,1), im2_coords(:,2));
mergedImage = stitchPlanar(im1,im2,H);

end