//
//  ViewController.h
//  OpenCV_RealTimeTriangleDetection
//
//  Created by Kim SAVAROCHE on 29/04/2016.
//  Copyright (c) 2016 Kim SAVAROCHE. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "ShapeDetector.h"
#import <opencv2/videoio/cap_ios.h>

using namespace cv;

@interface ViewController : UIViewController<CvVideoCameraDelegate> {
}

@property IBOutlet UIImageView *cameraView;
@property CvVideoCamera* videoCamera;
@property UIImage *cameraImage;

@end
