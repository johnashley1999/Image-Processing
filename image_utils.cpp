// John Ashley
// 3/5/2024

// This file is a utility folder for dealing with images.

#include <opencv2/highgui.hpp>
#include <opencv2/imgcodecs.hpp>
#include <opencv2/imgproc.hpp>
#include <iostream>

void displayImage(const std::string& imgName, const cv::Mat& img) {
    
    //cv::Mat img = cv::imread(path);
    
    if(img.empty()) {
        std::cout << "Could not read the image: " << std::endl;
        return;
    }
    
    cv::imshow(imgName, img);
}

cv::Mat RGBtoGray(const cv::Mat& img) {
    if(img.empty()) {
        std::cout << "Could not read the image: " << std::endl;
        return cv::Mat(100, 100, CV_8UC3);
    }

    cv::Mat grayImg(img.rows, img.cols, CV_8UC1);

    for (int i = 0; i < img.rows; ++i){
        for (int j = 0; j < img.cols; ++j){
            
            // Get pixel RGB values
            cv::Vec3b pixel = img.at<cv::Vec3b>(i, j);
            uchar blue = pixel[0];
            uchar green = pixel[1];
            uchar red = pixel[2];

            // Determing Gray Pixel
            uchar gray = static_cast<uchar>(0.299 * red + 0.587 * green + 0.114 * blue);

            // Set Gray Pixel
            grayImg.at<uchar>(i, j) = gray;

        }
    }

    return grayImg;
}