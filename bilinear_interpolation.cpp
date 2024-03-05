// John Ashley
// 3/5/2024
// Bilinear Interpolation

// This file is used to perform bilinear interpolation to resize images.

#include <iostream>
#include <algorithm>
#include <opencv2/core.hpp>


cv::Mat bilinearInterpolation(const cv::Mat& img, const int xNew, const int yNew){

    cv::Mat resultImg(xNew, yNew, img.type());

    double xRatio = static_cast<double>(img.rows - 1) / (xNew - 1);
    double yRatio = static_cast<double>(img.cols - 1) / (yNew - 1);

    for (int x = 0; x < xNew; ++x){

        double xShift = std::max(1.0, std::min(static_cast<double>(x) * xRatio, static_cast<double>(img.rows)));

        int x0 = static_cast<int>(std::floor(xShift));
        int x1 = static_cast<int>(std::ceil(xShift));

        double dx = xShift - x0;

        for (int y = 0; y < yNew; ++y){    
            double yShift = std::max(1.0, std::min(static_cast<double>(y) * yRatio, static_cast<double>(img.cols)));

            int y0 = static_cast<int>(std::floor(yShift));
            int y1 = static_cast<int>(std::ceil(yShift));

            double dy = yShift - y0;

            double xCol1 = (1.0-dx)*img.at<uchar>(x0, y0) + dx * img.at<uchar>(x1, y0);
            double xCol2 = (1.0-dx)*img.at<uchar>(x0, y1) + dx * img.at<uchar>(x1, y1);

            resultImg.at<uchar>(x,y) = static_cast<uchar>(std::round((1-dy)*xCol1 + dy*xCol2));


        }
    }


    return resultImg;
}
