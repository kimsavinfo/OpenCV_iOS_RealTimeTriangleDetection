//
// Created by Kim SAVAROCHE on 27/03/2016.
// Copyright (c) 2016 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIImage.h>
#import <opencv2/opencv.hpp>

@interface OpencvConverter : NSObject {

}

+ (cv::Mat)UIImage2cvMat:(UIImage *)image;

+ (cv::Mat)UIImage2cvMatGray:(UIImage *)image;

+ (UIImage *)cvMat2UIImage:(cv::Mat)cvMat;

@end