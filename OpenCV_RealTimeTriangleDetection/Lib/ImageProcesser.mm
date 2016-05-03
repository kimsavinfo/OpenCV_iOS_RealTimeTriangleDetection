//
// Created by Kim SAVAROCHE on 02/05/2016.
// Copyright (c) 2016 Kim SAVAROCHE. All rights reserved.
//

#import "ImageProcesser.h"


@implementation ImageProcesser {}

+(void)BGR2GRAY:(cv::Mat&)imgSrc :(cv::Mat&)imgOutput {
    cv::cvtColor( imgSrc, imgOutput, CV_BGR2GRAY );
}

+(void)blur:(cv::Mat&)imgSrc :(cv::Mat&)imgOutput {
    blur( imgSrc, imgOutput, cv::Size(IMG_PRCSS_KERNEL_SIZE, IMG_PRCSS_KERNEL_SIZE) );
}

@end