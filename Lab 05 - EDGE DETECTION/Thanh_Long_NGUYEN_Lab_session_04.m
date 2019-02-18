% NGUYEN Thanh-Long
%ImProc Lab05
%%
%%Step 01: Load the image and artifically add some noise
    img = imread('ic2.tif'); %read image
    imshow(img);
    nimg = imnoise(img,'gaussian',0.05);
    
    %plot the original image
    figure(); 
    subplot(1,2,1);
    imshow(img);
    title('Original Image');
    
    %plot the noised image
    subplot(1,2,2); 
    imshow(nimg);
    title('Noised Image');

%% Step 02: de-noise the image
    % Average filtering:
        afnimg01 = uint8(filter2(fspecial('average',2),nimg));
        afnimg02 = uint8(filter2(fspecial('average',5),nimg));
        afnimg03 = uint8(filter2(fspecial('average',50),nimg));

    %Meadian filtering:
        Mdnimg01 = uint8(medfilt2(nimg,[2 2]));
        Mdnimg02 = uint8(medfilt2(nimg,[5 5]));
        Mdnimg03 = uint8(medfilt2(nimg,[50 50]));

    %Wiener filtering:
        Wnnimg01 = uint8(wiener2(nimg,[2 2]));
        Wnnimg02 = uint8(wiener2(nimg,[5 5]));
        Wnnimg03 = uint8(wiener2(nimg,[50 50]));

    %plot all the output
    figure('Name','outputs'); 
    imshow([afnimg01 afnimg02 afnimg03; 
            Mdnimg01 Mdnimg02 Mdnimg03; 
            Wnnimg01 Wnnimg02 Wnnimg03]);
    title('De-noise methods - ouputs comparison');

    %plot athe final choice
    figure('Name','Final choice - Weiner filter');
    subplot(1,1,1);
    imshow(Wnnimg02);
    title('Final choice - Weiner filter with 5 5');

%% Step 03: highlight edges:
    % Technique 01: 
        % Horizontal Gradient:
            Gx = [0 0 0;1 0 -1; 0 0 0];
            horimage = imfilter(double(Wnnimg02)/255, Gx);

        % Vertical Gradient:
            Gy = [0 1 0;0 0 0; 0 -1 0];
            verimage = imfilter(double(Wnnimg02)/255, Gy);

        %Norm of Gradient:
            threshhold = graythresh(double(Wnnimg02)/255);
            edgeGrad = sqrt((horimage.^2) + (verimage.^2));
            edgeGrad = im2bw(edgeGrad, threshhold); %binarizing 
            edgeGrad = bwmorph(edgeGrad, 'thin');

        %plot the Horizontal Gradient
        figure('Name','Edge Gradient');
        subplot(1,3,1);
        imshow(horimage);
        title('Horizontal Gradient');
            
        %plot the Vertical Gradient
        subplot(1,3,2);
        imshow(verimage);
        title('Vertical Gradient');
            
        %plot the Gradient
        subplot(1,3,3);
        imshow(edgeGrad);
        title('Gradient');

    % Technique 02: Laplacian 
        edgeLap = edge(double(Wnnimg02)/255,'zerocross');
        edgeLap = bwmorph(edgeLap, 'thin'); %morphological performance

    % Technique 03: Canny Edge Detector
        edgeCan = edge(double(Wnnimg02)/255,'canny');
        edgeCan = bwmorph(edgeCan, 'thin'); %morphological performance

    %Plotting    
        figure('Name','Edge Comparision');
       
        subplot(1,3,1);
        imshow(edgeGrad);
        title('Gradient');
            
        subplot(1,3,2);
        imshow(edgeLap);
        title('Laplacian');
            
        subplot(1,3,3);
        imshow(edgeCan);
        title('Canny');
        
%% Step 04: Compute the Radon transform:
    Radimg = radon(edgeCan);
    figure('Name','Expected output for the computation of the Radon transform');
    
    %Plotting
    subplot(1,1,1);
    imshow(Radimg,[]);
    title('Radon transform');
%% Step 05: Choose points in Radon transform and observe associated lines:
    interactiveLine(edgeCan,Radimg,5);

%% Step 06: Find the image orientation and rotate it:
    % maxCol = max(Radimg, [], 1);
    maxCol = max(Radimg);

    maxVal = maxCol(1:90)+maxCol(91:180);
    indMax = find(maxVal == max(maxVal));

    %plot the V
    figure('Name', 'V and V(1:90)+V(91:180)');
    plot(1:90, maxVal);
    hold;
    plot(1:180, maxCol);
    
    %Rotate Image
    rotatedImg01 = imrotate(img, 90-indMax);
    rotatedImg02 = imrotate(img, -indMax);

    %Plotting
    figure('Name','Post-processing: Find the image orientation and rotate it');
    subplot(1,3,1);
    imshow(img);
    title('Original Image');

    subplot(1,3,2);
    imshow(rotatedImg01);
    title('Rotated Image');
    
    subplot(1,3,3);
    imshow(rotatedImg02);
    title('Rotated Image');
    