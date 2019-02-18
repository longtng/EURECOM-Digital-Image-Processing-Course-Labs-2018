% Name: NGUYEN Thanh-Long 
% A. Squares
imglena=imread('lena.tif');
imglenarsgr=rgb2gray(imresize(imglena,[128 128]));
fs=uint8(ones(1024,1024)*32);
fs(512-256+1:512+256,512-256+1:512+256)=64;
fs(512-128+1:512+128,512-128+1:512+128)=128;
fs(512-64+1:512+64,512-64+1:512+64)=imglenarsgr;
imshow(fs);

% B. Mosaic
vide=uint8(zeros(size(imglena,1),size(imglena,2)));
R=fliplr(cat(3,imglena(:,:,1),vide,vide));
B=flipud(cat(3,vide,vide,imglena(:,:,3)));
G=fliplr(flipud(cat(3,vide,imglena(:,:,2),vide)));
finalB=[imglena B; R G];
imshow(finalB);

% C. 3D image
imglenahs = imresize(imglena,0.5);
imglenahsgr = rgb2gray(imglenahs);
set(surface,'Linestyle','none');
surf(imglenahsgr);
colormap(gray(256));

% D. Bitplane Slicing
bit1=double(bitget(uint8(imglenahsgr),1));
bit2=double(bitget(uint8(imglenahsgr),2));
bit3=double(bitget(uint8(imglenahsgr),3));
bit4=double(bitget(uint8(imglenahsgr),4));
bit5=double(bitget(uint8(imglenahsgr),5));
bit6=double(bitget(uint8(imglenahsgr),6));
bit7=double(bitget(uint8(imglenahsgr),7));
bit8=double(bitget(uint8(imglenahsgr),8));
bitplane=[bit1 bit2 bit3 bit4; bit5 bit6 bit7 bit8];
imshow(bitplane);