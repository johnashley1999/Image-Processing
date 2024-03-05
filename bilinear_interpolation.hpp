#ifndef BILINEAR_INTERPOLATION_HPP
#define BILINEAR_INTERPOLATION_HPP

#include <opencv2/core.hpp>

cv::Mat bilinearInterpolation(const cv::Mat& img, const int xnew, const int xold);

#endif