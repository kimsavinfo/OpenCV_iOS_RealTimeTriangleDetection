//
//  ViewController.h
//  OpenCV_RealTimeTriangleDetection
//
//  Created by Kim SAVAROCHE on 29/04/2016.
//  Copyright (c) 2016 Kim SAVAROCHE. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "../Lib/OpencvContourDetector.h"

@interface ViewController : UIViewController {
    UIImage *cameraImage;
}

@property (weak, nonatomic) IBOutlet UIImageView *cameraView;



@end
