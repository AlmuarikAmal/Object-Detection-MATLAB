## Practice on Segmentation
Specifically, this code performs the following operations as follow:
	- Read an input image ‘rice1.png' and convert it to grayscale if it's not already.
	- Create a mask by thresholding the image based on the mode value of pixel intensities.
	- Add a border to the mask to ensure that edges are visible.
	- Remove border effects by indexing.
	- Fill holes in the mask.
	- Perform erosion mask to image to remove small connections between objects.
	- Count the number of objects (rice grains) in the processed image and display the result.

After all, This code aims to analyze the image and count the number of segment exist in the image.
