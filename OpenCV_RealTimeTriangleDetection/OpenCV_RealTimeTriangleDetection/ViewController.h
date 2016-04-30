//
//  ViewController.h
//  OpenCV_RealTimeTriangleDetection
//
//  Created by Kim SAVAROCHE on 29/04/2016.
//  Copyright (c) 2016 Kim SAVAROCHE. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <opencv2/opencv.hpp>
#import <opencv2/videoio/cap_ios.h>

using namespace cv;

@interface ViewController : UIViewController<CvVideoCameraDelegate> {
    IBOutlet UIImageView *cameraView;
    CvVideoCamera* videoCamera;
    UIImage *cameraImage;
}

@end
