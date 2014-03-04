manual = 1;
auto = 0;

%read in images

 im1 = 'laptop_00.JPG'
 im2 = 'laptop_01.JPG'

% % 
% im1 = im2double(imread(im1));
% im2 = im2double(imread(im2));

%Manual Stiching Below
if(manual)
    
    [footballx, footbally, footballz] = size(imread(im1));
 
im1 = im2double(imread(im1));
im2 = im2double(imread(im2));
im2 = imresize(im2, [footballx, footbally]);
    
    
userstitch(im1,im2);
end

%Automatic Stiching Below
if(auto)      
im1 = imresize(im1, .25);
im2 = imresize(im2, .25);   
    
autostitch(im1,im2);



end
