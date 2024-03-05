#include <opencv2/imgcodecs.hpp>
#include <opencv2/highgui.hpp>
#include <opencv2/imgproc.hpp>
#include <iostream>

#include "image_utils.hpp"
#include "bilinear_interpolation.hpp"

using namespace cv;
using namespace std; 


int main() {

    string path = "Resources/test.png";
    
    Mat img = imread(path); 

    displayImage("Original", img);

    Mat grayImg = RGBtoGray(img);

    displayImage("Gray Image", grayImg);

    Mat shrinkImg = bilinearInterpolation(grayImg, 255, 255);

    displayImage("Shrunk Image", shrinkImg);

    Mat growImg = bilinearInterpolation(grayImg, 511, 511);

    displayImage("Grow Image", growImg);

    cv::waitKey(0);

    return 0; 
}