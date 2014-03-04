function h = computehomography_RANSAC(x1,y1,x2,y2)

tolerance = 10;
pts = 7;
N = 150;
db = 0;
hb = [];

for i=1:N
[rows, z] = size(x1);
arrx1 = zeros(pts,1);
arry1 = arrx1;
arrx2 = arrx1;
arry2 = arrx1;
 
for j=1:pts
samples(j) = ceil(rand(1)*rows);
arrx1(j) = x1(samples(j));
arrx2(j) = x2(samples(j));
arry1(j) = y1(samples(j));
arry2(j) = y2(samples(j));
end
[a, b] = size(x1);
counter = 0;
 %get new homography
h = computeHomography(arrx1,arry1,arrx2,arry2);
        
for j=1:a    
pt = h*[x1(j);y1(j);1];      
p1 = ceil(pt(2)/pt(3));
p2 = ceil(pt(1)/pt(3));
distance = (p1-y2(j))*(p1-y2(j)) + (p2-x2(j))*(p2-x2(j));       
if (distance <= tolerance)
counter = counter+1;
end             
end

d = counter/a;
   
if(d > db)
    %if so, change current homography
    hb = h;
   db = d;
end
   
end

h = hb;

end