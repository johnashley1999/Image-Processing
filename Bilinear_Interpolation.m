% John Ashley
% Bilinear Interpolation
% 2/27/2024

%% Disc Image Bilinear Interpolation Test
clc

%Original Image
concDiscs = Disc_3(256, 32,64,96); %Draw 3 disc image 

%Create dimension and scale factors for test images
dims = [160 180];
sf = 3;

%Create Original Test Image
testArrayOrig = concDiscs(dims(1):dims(2), dims(1):dims(2));
 
% Create Shrink and Shrink Test Image
N = round(size(concDiscs,1)/sf)
shrink = Bilin_interp(concDiscs,N,N); 
testArrayS = shrink(int16(dims(1)/sf):int16(dims(2)/sf), int16(dims(1)/sf):int16(dims(2)/sf)); 

% Create Zoom and Zoom Test Image
N = size(concDiscs,1)*sf 
zoom = Bilin_interp(concDiscs,N,N); 
testArrayZ = zoom(dims(1)*sf:dims(2)*sf, dims(1)*sf:dims(2)*sf); 

%-------------------------------------
%Plot Original, Shrink, and Zoom Image
%-------------------------------------
figure(1)
subplot(2,3,1);
image(concDiscs)
axis ij; axis tight;colormap(gray(256));rotate3d on; axis equal             
title('Original Image 256x256'); ylabel('x axis'), xlabel('y axis')

subplot(2,3,2)         
image(shrink);         
axis ij; axis tight;colormap(gray(256));rotate3d on; axis equal        
title('Shrink & Bilinear Interpolation 128x128'); ylabel('x axis'), xlabel('y axis')
        
subplot(2,3,3)          
image(zoom);            
axis ij;axis tight;colormap(gray(256));rotate3d on; axis equal              
title('Zoom & Bilinear Interpolation 512x512'); ylabel('x axis'), xlabel('y axis')

%-----------------------------------------
%Plot Original, Shrink, & Zoom Test Images
%-----------------------------------------
subplot(2,3,4)
image(testArrayOrig)
axis ij; rotate3d on; axis equal; axis tight;
title('Original Test Array 20x20'); ylabel('x axis'), xlabel('y axis')  

subplot(2,3,5)
image(testArrayS)
axis ij; rotate3d on; axis equal; axis tight;
title('Shrink Test Array 20x20'); ylabel('x axis'), xlabel('y axis')  

subplot(2,3,6)
image(testArrayZ)
axis ij; rotate3d on; axis equal; axis tight;
title('Zoom Test Array 20x20'); ylabel('x axis'); xlabel('y axis');            

%% Image Test Bilinear Interpolation Test
clc

%Import Original Image
PocketWatchImage = imread('/Users/johnashley/Documents/Image Processing/Test_Images/PocketWatch(1250dpi).tif');

%Get pixel dimensions
[x,y] = size(PocketWatchImage);

%Create dimension and scale factors for test images
dims = [1340 1459];
sf = 3;
stretchF = 2

%Create Original Test Image
testArrayOrig = PocketWatchImage(dims(1):dims(2), dims(1):dims(2));

% Create Shrink and Shrink Test Image
xS = round(x/sf)
yS = round(y/sf)
shrink = Bilin_interp(PocketWatchImage, xS, yS); 
testArrayS = shrink(int16(dims(1)/sf):int16(dims(2)/sf), int16(dims(1)/sf):int16(dims(2)/sf)); 

% Create Zoom and Zoom Test Image
xZ = x*sf
yZ = y*sf
zoom = Bilin_interp(PocketWatchImage,xZ, yZ); 
testArrayZ = zoom(dims(1)*sf:dims(2)*sf, dims(1)*sf:dims(2)*sf); 

% Create Stretch Wide Image
xSW = int16(x/stretchF);
ySW = y*stretchF;
stretchWide = Bilin_interp(PocketWatchImage,xSW, ySW); 

% Create Stretch Long Image
xSL = x*stretchF
ySL = int16(y/stretchF)
stretchLong = Bilin_interp(PocketWatchImage,xSL, ySL); 


%-------------------------------------
%Plot Original, Shrink, and Zoom Image
%-------------------------------------
figure(2)
subplot(2,3,1);
image(PocketWatchImage)
axis ij; axis tight; axis equal; colormap(gray(256));rotate3d on;           
title('Original Textbook Image'); ylabel('x axis'), xlabel('y axis')

subplot(2,3,2)         
image(shrink);         
axis ij; axis tight;colormap(gray(256));rotate3d on; axis equal        
title('Shrink & Bilinear Interpolation 128x128'); ylabel('x axis'), xlabel('y axis')
        
subplot(2,3,3)          
image(zoom);            
axis ij;axis tight;colormap(gray(256));rotate3d on; axis equal              
title('Zoom & Bilinear Interpolation 512x512'); ylabel('x axis'), xlabel('y axis')

%-----------------------------------------
%Plot Original, Shrink, & Zoom Test Images
%-----------------------------------------
subplot(2,3,4);
image(testArrayOrig)
axis ij; rotate3d on; axis equal; axis tight;
title('Original Test Array 20x20'); ylabel('x axis'), xlabel('y axis')  

subplot(2,3,5)
image(testArrayS)
axis ij; rotate3d on; axis equal; axis tight;
title('Shrink Test Array 20x20'); ylabel('x axis'), xlabel('y axis')  

subplot(2,3,6)
image(testArrayZ)
axis ij; rotate3d on; axis equal; axis tight;
title('Zoom Test Array 20x20'); ylabel('x axis'); xlabel('y axis'); 

%----------------------------------------------------
%Plot Original, Stretch Wide, and Stretch Long Images
%----------------------------------------------------
figure(3)
subplot(1,3,1);
image(PocketWatchImage)
axis ij; axis tight; axis equal; colormap(gray(256));rotate3d on;           
title('Original Textbook Image'); ylabel('x axis'), xlabel('y axis')

subplot(1,3,2);
image(stretchWide)
axis ij; axis tight; axis equal; colormap(gray(256));rotate3d on;           
title('Strecthed Wide Image'); ylabel('x axis'), xlabel('y axis')

subplot(1,3,3);
image(stretchLong)
axis ij; axis tight; axis equal; colormap(gray(256));rotate3d on;           
title('Strecthed Long Image'); ylabel('x axis'), xlabel('y axis')


%**************************************************************************
% Functions
%**************************************************************************

%--------------------------------------------------------------------------
% Bilinear Interpolation Function
function [BL_Image] = Bilin_interp(A, xnew, ynew)
    
    % Get dimensions of input image
    [xold, yold] = size(A); % Get the size of the input matrix

    % Convert to type double for precision
    A = double(A);  
    
    % Initialize New image
    BL_Image = zeros(xnew, ynew); 
    
    % Calculate conversions
    xratio = (xold - 1)/(xnew - 1);
    yratio = (yold - 1)/(ynew - 1);

    for x = 1:xnew
        % map pixel to old image location
        x_shift = x*xratio;

        % Enforce original image boundaries
        x_shift = max(1, min(x_shift, xold-.0001));

        % Determine surrounding coordinates of location
        x0 = floor(x_shift);
        x1 = ceil(x_shift);

        % Calculate interpolation distance x
        dx = x_shift - x0;

        for y = 1:ynew

            % map y pixel to new image location
            y_shift = y*yratio;

            % Enforce original image boundaries
            y_shift = max(1, min(y_shift, yold-.0001));
            
            % Determine surrounding coordinates of location
            y0 = floor(y_shift);
            y1 = ceil(y_shift);

            % Calculate interpolation distance y
            dy = y_shift - y0;
            
            % Perform Interpolation (weight values from surrounding pixels)
            x_col_1 = (1-dx) * A(x0, y0) + dx * A(x1, y0);
            x_col_2 = (1-dx) * A(x0, y1) + dx * A(x1, y1);
            BL_Image(x, y) = (1-dy) * x_col_1 + dy * x_col_2;
        end
    end
    
    % Convert Image back to integer
    BL_Image = uint8(BL_Image); 
end

%--------------------------------------------------------------------------
% Create Disc to demonstrate Bilinear Interpolation
function [concDiscs] = Disc_3(N, A, B, C)

concDiscs = zeros(N,N);    % define initial zero matrices 
shift = N/2;                % Value to shift circle to center of image

% For loop to calculate and set intensity values for the image
    for iy = 1:N
        for ix = 1:N
            %Small Circle
            if A^2 >= (ix - shift)^2+ (iy - shift)^2 %check if pixel is in small circle
                concDiscs(ix,iy) = 0;

            % Middle Circle
            elseif B^2 >= (ix - shift)^2+ (iy - shift)^2 %check if pixel is in medium circle
                concDiscs(ix,iy) = 127;

            %Large Circle
            elseif C^2 >= (ix - shift)^2+ (iy - shift)^2 
                concDiscs(ix,iy) = 190;
            
            %pixel is not in a circle  
            else 
                concDiscs(ix,iy) = 255;
            end
        end
    end
end

