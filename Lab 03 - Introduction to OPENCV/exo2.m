% NGUYEN Thanh-Long
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
C1 = uint8(filter2(fspecial('average',4),C));

% Filter with size = 10x10
C2 = uint8(filter2(fspecial('average',10),C));

% Filter with size = 20x20
C3 = uint8(filter2(fspecial('average',50),C));

%Show Images:
figure;
imshow([A B C; C1 C2 C3]);

%View in 3D:
figure;
surf(C1);
surf(C3);

% Comment
% Comment the link between the size of a filter in spatial and frequency
% domain.
% In short, the higher filter size would lead to the better noise reduction
% however, it also blurred out the image. 