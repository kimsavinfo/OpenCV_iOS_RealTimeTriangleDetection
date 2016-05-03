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
    
    [self initVideoCamera];
    [self->videoCamera start];
}

-(void)initVideoCamera{
    self->videoCamera = [[CvVideoCamera alloc] initWithParentView:cameraView];
    self->videoCamera.delegate = self;
    self->videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionFront;
    self->videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset352x288;
    self->videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    self->videoCamera.rotateVideo = YES;
    self->videoCamera.defaultFPS = 30;
    self->videoCamera.grayscaleMode = NO;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// ============================================
// Protocol CvVideoCameraDelegate
// ============================================

- (void)processImage:(Mat&)image {
    Mat imgDarkBg = Mat::zeros( image.size(), CV_8UC3 );

    ShapeDetector *shapeDetector = [ShapeDetector alloc];
    [shapeDetector findBiggestShape:image :3 :1000];
    [shapeDetector drawThresholdContours:imgDarkBg];
    [shapeDetector drawBiggestShape:imgDarkBg];

    image = imgDarkBg;
}

@end