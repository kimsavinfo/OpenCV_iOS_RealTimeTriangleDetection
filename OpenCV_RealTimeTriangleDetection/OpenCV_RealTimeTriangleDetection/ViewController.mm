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
    [self.videoCamera start];
}

-(void)initVideoCamera{
    _videoCamera = [[CvVideoCamera alloc] initWithParentView:_cameraView];
    _videoCamera.delegate = self;
    _videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionFront;
    _videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset352x288;
    _videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    _videoCamera.rotateVideo = YES;
    _videoCamera.defaultFPS = 30;
    _videoCamera.grayscaleMode = NO;

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
    [shapeDetector findBiggestShapeFromImage:image verticesNb:3 minArea:1000];
    [shapeDetector drawThresholdContoursOnImage:imgDarkBg];
    [shapeDetector drawBiggestShapeOnImage:imgDarkBg];

    image = imgDarkBg;
}

@end