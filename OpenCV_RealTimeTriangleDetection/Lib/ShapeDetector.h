//
//  ShapeDetector.h
//  OpenCV_RealTimeTriangleDetection
//
//  Created by Kim SAVAROCHE on 02/05/2016.
//  Copyright © 2016 Kim SAVAROCHE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIImage.h>
#import <opencv2/opencv.hpp>

#import "ImageProcesser.h"

static const int THRESHOLD_VALUE = 155;
static const int THRESHOLD_MAX = 255;
static const int THRESHOLD_TYPE = cv::THRESH_BINARY_INV;

static const int CANNY_LOW_THRESHOLD = 0;
static const int CANNY_HIGH_THRESHOLD = 50;
static const int CANNY_KERNEL_SIZE = 5;
static const float CANNY_EPS_COEFFICIENT = 0.04;

static const cv::Scalar red = cv::Scalar(255, 0, 0);
static const cv::Scalar green = cv::Scalar(0, 255, 0);
static const cv::Scalar blue = cv::Scalar(0, 0, 255);
static const cv::Scalar yellow = cv::Scalar(255, 255,0);

@interface ShapeDetector : NSObject{
    cv::Mat _thresholdOutput;
    std::vector<std::vector<cv::Point>> _thresholdContours;

    std::vector<std::vector<cv::Point>> _cannyContours;
    std::vector<cv::Point2f> _cannyMc;

    int _iBiggestShape;
}

-(void)cleanUp;

-(void)findBiggestShapeFromImage:(cv::Mat&)imgSrc verticesNb:(int)nbVertices minArea:(int)areaMin;
-(void)findThresholdContoursFromImage:(cv::Mat&)imgSrc;
-(void)findCannyContoursFromImage:(cv::Mat&)imgSrc;

-(void)drawBiggestShapeOnImage:(cv::Mat&)imgSrc;
-(void)drawThresholdContoursOnImage:(cv::Mat&)imgSrc;
-(void)drawCannyContoursOnImage:(cv::Mat&)imgSrc;

-(bool)isShapeFound;

@end