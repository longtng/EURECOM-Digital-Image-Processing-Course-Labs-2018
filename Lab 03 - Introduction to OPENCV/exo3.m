%NGUYEN Thanh-Long
% Create matrix
A=uint8(ones(256,256)*64);
A(128-64+1:128+64,128-64+1:128+64)=192;

% Generate noisy image 
B = uint8(zeros(256,256));
for i=1:10000
    xx = uint8((255*rand(1)+1));
    yy = uint8((255*rand(1)+1));
    B(xx,yy)= uint8(255*rand(1));
end
C=A+B;

% Compared
imshow([A C]);

% Filter with size = 5x5
C1 = uint8(medfilt2(C,[2 2]));

% Filter with size = 10x10
C2 = uint8(medfilt2(C,[15 10]));

% Filter with size = 20x20
C3 = uint8(medfilt2(C,[100 100]));

%Show Images:
imshow([A B C; C1 C2 C3]);

% Comment
% What are the observed differences for a given filter size when the image
% is filtered by average or by median?
% Compare with average filter, the higher filter size would lead to the better noise reduction
% however, it also reduced shapeliness of the image. 
% In brief, median do not blurred out the image with high value of filter
% but reduced the shapeliness. 