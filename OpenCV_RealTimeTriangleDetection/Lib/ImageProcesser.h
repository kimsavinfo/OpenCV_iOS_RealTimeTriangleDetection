//
// Created by Kim SAVAROCHE on 02/05/2016.
// Copyright (c) 2016 Kim SAVAROCHE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIImage.h>
#import <opencv2/opencv.hpp>

static const int IMG_PRCSS_KERNEL_SIZE = 3;

@interface ImageProcesser : NSObject{

}

+ (void)BGR2GRAY:(cv::Mat&)imgSrc :(cv::Mat&)imgOutput;

+ (void)blur:(cv::Mat&)imgSrc :(cv::Mat&)imgOutput;

@end