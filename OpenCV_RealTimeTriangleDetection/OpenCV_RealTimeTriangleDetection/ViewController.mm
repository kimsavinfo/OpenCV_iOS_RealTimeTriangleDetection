//
//  ViewController.m
//  OpenCV_RealTimeTriangleDetection
//
//  Created by Kim SAVAROCHE on 29/04/2016.
//  Copyright (c) 2016 Kim SAVAROCHE. All rights reserved.
//


#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    cameraImage = [UIImage imageNamed:@"triangle_hands1.jpg"];

    if(cameraImage != nil) {
        OpencvContourDetector *contourDetector = [[OpencvContourDetector alloc] initWithImage:cameraImage];
        [contourDetector findBiggestPolygon:3];
        _cameraView.image = [contourDetector drawBiggestPolygon:cameraImage :255 :0 :0];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end