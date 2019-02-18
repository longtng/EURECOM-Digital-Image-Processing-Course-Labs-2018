// NGUYEN Thanh-Long 
// nguyenta@eurecom.fr

#include "opencv2/imgproc/imgproc.hpp"
#include "opencv2/highgui/highgui.hpp"
#include <stdlib.h>
#include <iostream>
#include <stdio.h>

using namespace std;
using namespace cv;

/// Global variables

Mat src, src_gray;
Mat dst, detected_edges;

char* window_name0 = "Original Image";
char* window_name1 = "Grayscale Image";
char* window_name2 = "Image After Histogram Equalization";
char* remap_window1 = "Remap - upside down";
char* remap_window2 = "Remap - reflection in the x direction";
char* window_name4 = "Median Filtered Image";
char* window_name5 = "Gaussian Filtered Image";

int ddepth = CV_16S;
int scale = 1;
int delta = 0;
int kernel_size = 3;
char* window_name6 = "Laplace Demo";

char* window_name7 = "Sobel Demo - Simple Edge Detector";

/// Global Variables
int MAX_KERNEL_LENGTH = 6;


/** @function main */
int main( int argc, char** argv )
{

    if( argc != 2)
    {
     cout <<" Usage: display_image ImageToLoadAndDisplay" << endl;
     return -1;
    }

	// Call the appropriate function in OPENCV to load the image
	src = imread(argv[1]);

	if( !src.data )
	{ return -1; }

	// Create a window called "Original Image" and show original image
	namedWindow("Original Image", WINDOW_AUTOSIZE);		// Create a window for display.
	imshow("Original Image", src);                   // Show our image inside it.
	
	// Call the appropriate function in OPENCV to convert the image to grayscale
	cvtColor(src, src_gray, CV_RGB2GRAY);


	// Create a window called "Grayscale Image" and show grayscale image
	namedWindow("Grayscale Image", WINDOW_AUTOSIZE);		// Create a window for display.
	imshow("Grayscale Image", src_gray);                   // Show our image inside it.


	// Apply histogram equalization to the grayscale image
	equalizeHist(src_gray, dst);		//histogram equa function
	
	// Create a window called "Image After Histogram Equalization" and show the image after histogram equalization
	namedWindow("Image After Histogram Equalization", CV_WINDOW_AUTOSIZE);
	imshow("Image After Histogram Equalization", dst); // show the image


	// Apply remapping; first turn the image upside down and then reflect the image in the x direction

    // For this part, the upside down image and the flipped left image are created as the Mat variables "image_upsidedown" and "image_flippedleft". Also, map_x and map_y are created with the same size as equalized_image:
		Mat image_upsidedown;
		Mat image_flippedleft;
		Mat map_x, map_y;

	// Apply upside down operation to the image for which histogram equalization is applied.
	//	dst.create(src.size(), src.type());
		map_x.create(src.size(), CV_32FC1);
		map_y.create(src.size(), CV_32FC1);
		
		for (int j = 0; j < src.rows; j++)
		{
			for (int i = 0; i < src.cols; i++) {
				map_x.at<float>(j, i) = (float)i;
				map_y.at<float>(j, i) = (float)(src.rows - j);
			}
		}

	// Create a window called "Remap - upside down" and show the image after applying remapping - upside down
		remap(dst, image_upsidedown, map_x, map_y, INTER_LINEAR, BORDER_CONSTANT, Scalar(0, 0, 0));		//upside down function
		namedWindow("Remap - upsidedown", WINDOW_AUTOSIZE);
		imshow("Remap - upsidedown", image_upsidedown);			// Show the image

	// Apply reflection in the x direction operation to the image for which histogram equalization is applied.
		for (int j = 0; j < src.rows; j++)
		{
			for (int i = 0; i < src.cols; i++) {
				map_x.at<float>(j, i) = (float)(src.cols - i);
				map_y.at<float>(j, i) = (float)j;
			}
		}
	
	// Create a window called "Remap - reflection in the x direction" and show the image after applying remapping - reflection in the x direction
		remap(dst, image_flippedleft, map_x, map_y, INTER_LINEAR, BORDER_CONSTANT, Scalar(0, 0, 0));		//upside down function
		namedWindow("Remap - reflection in the x direction", WINDOW_AUTOSIZE);
		imshow("Remap - reflection in the x direction", image_flippedleft);			// Show the image
   
	// Apply Median Filter to the Image for which histogram equalization is applied 
		Mat mdf;
		for (int i = 1; i < MAX_KERNEL_LENGTH; i = i + 2)
		{
			medianBlur(dst, mdf, i);
		}

	// Create a window called "Median Filtered Image" and show the image after applying median filtering
		namedWindow("Median Filtered Image", WINDOW_AUTOSIZE);
		imshow("Median Filtered Image", mdf);			// Show the image

	
    // Remove noise from the image for which histogram equalization is applied by blurring with a Gaussian filter
		Mat gaf;
		for (int i = 1; i < MAX_KERNEL_LENGTH; i = i + 2)
		{
			GaussianBlur(dst, gaf, Size(3, 3), 0, 0);
		}

	// Create a window called "Gaussian Filtered Image" and show the image after applying Gaussian filtering
		namedWindow("Gaussian Filtered Image", WINDOW_AUTOSIZE);
		imshow("Gaussian Filtered Image", gaf);			// Show the image

	/// Apply Laplace function to compute the edge image using the Laplace Operator
		Mat llf; 
		Mat abs_llf;
		Laplacian(gaf, llf, ddepth, kernel_size, scale, delta, BORDER_DEFAULT);
		convertScaleAbs(llf, abs_llf);

    /// Create window called "Laplace Demo" and show the edge image after applying Laplace Operator
		namedWindow("Laplace Demo", WINDOW_AUTOSIZE);
		imshow("Laplace Demo", abs_llf);			// Show the image


	// Apply Sobel Edge Detection
	/// Appropriate variables grad, grad_x and grad_y, abs_grad_x and abs_grad_y are generated
	Mat grad;
	Mat grad_x, grad_y;
	Mat abs_grad_x, abs_grad_y;

	/// Compute Gradient X
	Sobel(gaf, grad_x, ddepth, 1, 0, 3, scale, delta, BORDER_DEFAULT);
	convertScaleAbs(grad_x, abs_grad_x);

	/// Compute Gradient Y
	Sobel(gaf, grad_y, ddepth, 0, 1, 3, scale, delta, BORDER_DEFAULT);
	convertScaleAbs(grad_y, abs_grad_y);

	/// Compute Total Gradient (approximate)
	addWeighted(abs_grad_x, 0.5, abs_grad_y, 0.5, 0, grad);

	/// Create window called "Sobel Demo - Simple Edge Detector" and show Sobel edge detected image
	namedWindow("Sobel Demo - Simple Edge Detector", WINDOW_AUTOSIZE);
	imshow("Sobel Demo - Simple Edge Detector", grad);			// Show the image

  /// Wait until user exit program by pressing a key
  waitKey(0);

  return 0;
  }