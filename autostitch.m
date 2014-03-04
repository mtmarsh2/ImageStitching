function mergedImage = autostitch(im1, im2)


im1copy = rgb2gray(im2double(im1));
im2copy = rgb2gray(im2double(im2));

[frames1, descriptors1] = sift(im1copy);
[frames2, descriptors2] = sift(im2copy);

x1 = frames1(1,:);
x2 = frames2(1,:);
y1 = frames1(2,:);
y2 = frames2(2,:);
D = pdist2(transpose(descriptors1), transpose(descriptors2),'euclidean');
[a,b] = size(D);


i1 = 0;
i2 = 0;

counter1 = 1;
counter2 = 1;

distarr1 = [];
distarr2 = [];
dx1 = [];
dy1 = [];
dx2 = [];
dy2 = [];

d1 = 1000000;
d2 = 1000000;

for i=1:a
   for j=1:b
   if(D(i,j) < d1)
           
   i1 = i;
   i2 = j;
   d2 = d1;
   d1 = D(i,j);
           
   distarr1(counter2) = i;
   distarr2(counter2) = j;
   counter2 = counter2+1;

   elseif D(i,j)<d2
       d2 = D(i,j);
   end
       
   end
   %check if first dist is <.7* 2nd dist
   if d1<.7*d2
       %if so grab out points out of frames
      dx1(counter1) = x1(i1);
      dy1(counter1) = y1(i1);
      dx2(counter1) = x2(i2);
      dy2(counter1) = y2(i2);
      counter1 = counter1+1;
      
   end
   
   d1 = 1000000;
   d2 = 1000000;
   
end

H = computeHomography_RANSAC(dx1(:), dy1(:), dx2(:), dy2(:));
mergedImage = stitchPlanar(im1, im2, H);

end