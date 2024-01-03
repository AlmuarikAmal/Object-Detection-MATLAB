clc;
clear all;   % All variables are deleted
close all;   % All figures are closed

folder = '';    % Define a default folder or leave it empty

% Use uigetfile to prompt the user to select a file
[filename, path] = uigetfile(fullfile(folder, '*.*'), 'Select an Image File');

% Check if the user clicked Cancel
if isequal(filename, 0)
    disp('User canceled the file selection.');
else

original_img = imread(filename); % read input image from user 

[rows, columns, channels] = size(original_img); % check size of image if channels = 3, convert RGB to Grayscale image

if channels > 1 
    original_img = im2gray(original_img);  % converting RGB image to Gray image
end 
figure(1)
subplot(2,2,1) , imshow(original_img), title('Gray scale image', 'FontSize',7);

% mask creation 
Tmode_val= mode(original_img(:));   % find the most frequent intensity value(mode), since mode is robust to outliers (if exist)
% thresholding based on mode value
mask = original_img < (Tmode_val - 2) | original_img > (Tmode_val + 2); % (-2, +2 —> allows for more variation in input image (consider cases where intensity values = mode) also, it assumes input image always uint8

% show mask with border added, otherwise the edges will be invisible
figure(1)
subplot(2,2,2) , imshow(padarray(mask,[10 10],0,'both'),'border','tight'), title('Masked Image with border added', 'FontSize',7);

% remove border effects by using indexing after mask applied 
border_width = 10;
mask = mask(border_width+1: end-border_width, border_width+1: end-border_width);
mask = padarray(mask, [1 1]*border_width, 'replicate', 'both'); % this line ensures the mask have same size as the original image 

mask = imfill(mask,'holes'); % fill holes 
figure(1)
subplot(2,2,3), imshow(mask), title('image after filling holes & removing border effect','FontSize',7);

SE = strel('disk', 7); 	 % create structure element 'disk' shape with radius 7,radius = 7 picked, based on multiple experiment 
mask = imerode(mask,SE); % use erosion mask to get rid of bridges and small connections between objects
figure(1)
subplot(2,2,4), imshow(mask), title('final processed image','FontSize',7);

ComponentsCount = bwconncomp(mask); 	% check the number of objects found, using default connectivity (i.e., 4)
fprintf("the number of segments exist in an image is: ");
Count = ComponentsCount.NumObjects			% show number of objects found 
end
