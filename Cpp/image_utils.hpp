// image_utils.hpp
#ifndef IMAGE_UTILS_HPP
#define IMAGE_UTILS_HPP

#include <opencv2/core.hpp> // Include the core header for cv::Mat

void displayImage(const std::string& imgName, const cv::Mat& img);

cv::Mat RGBtoGray(const cv::Mat& img);

#endif
