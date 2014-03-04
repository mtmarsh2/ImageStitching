function [H] = computeHomography(x1, y1, x2, y2)

points = 7;
A = zeros(2*points, 9);
T1 = [1/std(x1) 0 -mean(x1)/std(x1); 0 1/std(y1) -mean(y1)/std(y1); 0 0 1];
T2 = [1/std(x2) 0 -mean(x2)/std(x2); 0 1/std(y2) -mean(y2)/std(y2); 0 0 1];
     
 for i=1:points
    pt = [x1(i); y1(i); 1];
    pt = T1*pt;
    nx1(i) = pt(1);
    ny1(i) = pt(2);
    pt = [x2(i); y2(i); 1];
    pt = T2*pt;
    nx2(i) = pt(1);
    ny2(i) = pt(2);
end
    i=1;
    while(i<=2*points)
          A(i,1) = -nx1(ceil(i/2));
          A(i,2) = -ny1(ceil(i/2));
          A(i,3) = -1;
          A(i,4:6) = 0;
          A(i,7) = nx1(ceil(i/2)).*nx2(ceil(i/2));
          A(i,8) = ny1(ceil(i/2)).*nx2(ceil(i/2));
          A(i,9) = nx2(ceil(i/2));
          i=i+1;
               
          A(i,1:3) = 0;
          A(i,4) = -nx1(ceil(i/2));
          A(i,5) = -ny1(ceil(i/2));
          A(i,6) = -1;
          A(i,7) = nx1(ceil(i/2)).*ny2(ceil(i/2));
          A(i,8) = ny1(ceil(i/2)).*ny2(ceil(i/2));
          A(i,9) = ny2(ceil(i/2));
          i=i+1;
              
    end
      
[H,S,V] = svd(A);
hn = V(:, end);  
Hn = reshape(hn,[3,3]);
Hn = transpose(Hn);
Hn = T2\(Hn*T1);
H = Hn./Hn(3,3);
        
end
