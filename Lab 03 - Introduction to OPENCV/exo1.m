% NGUYEN Thanh-Long
% Create value:
imglena=imread('lena.png');
imshow(imglena);
imglntrans = fftshift(fft2(imglena));

% Visualize the spectrum in 2D and 3D:
imshow(log(abs(imglntrans)+1),[]);
figure;
surf(log(abs((imglntrans))));
shading flat;

% Apply lowpass filter by using the freqLPF:
imglnmask1 = imglntrans.*freqLPF(size(imglntrans),0.1);
imglnmask2 = imglntrans.*freqLPF(size(imglntrans),0.25);
imglnmask3 = imglntrans.*freqLPF(size(imglntrans),0.5);

%convert back 
imglncb1 = ifft2(ifftshift(imglnmask1));
imglncb2 = ifft2(ifftshift(imglnmask2));
imglncb3 = ifft2(ifftshift(imglnmask3));

figure;
subplot(2,4,1);imshow(imglena);title('original');
subplot(2,4,2); imshow(imglntrans);title('transform');
subplot(2,4,3); imshow(imglncb1,[]);title('fcoupure=0.1');
subplot(2,4,4); imshow(imglnmask1);title('fcoupure=0.1');
subplot(2,4,5); imshow(imglncb2,[]);title('fcoupure=0.25');
subplot(2,4,6); imshow(imglnmask2);title('fcoupure=0.25');
subplot(2,4,7); imshow(imglncb3,[]);title('fcoupure=0.5');
subplot(2,4,8); imshow(imglnmask3);title('fcoupure=0.5');

figure;
imshow([imglena uint8(imglncb1) uint8(imglncb2) uint8(imglncb3); 
        imglntrans imglnmask1 imglnmask2 imglnmask3]);

% Comment:
% What is the Geometric Shape of the filter?
% The shape is the circle with center is the center of the image.

% What does parameter fcoupure stand for?
% The fcoupure literally is the "length" of the circle in filtering. On the
% other hand, it also represented the cut-off value that will remove all
% the frequencies value that higher than fcoupure. 

% How to modify you modify the freqLFP.m to define high pass filter instead
% of a low filter?
% In a reverse way compare to the lowpass filter - index = find(R>fcoupure);