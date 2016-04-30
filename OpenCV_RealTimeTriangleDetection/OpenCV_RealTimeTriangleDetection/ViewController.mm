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
    
    self->videoCamera = [[CvVideoCamera alloc] initWithParentView:cameraView];
    self->videoCamera.delegate = self;
    self->videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionFront;
    self->videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset352x288;
    self->videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    self->videoCamera.rotateVideo = YES;
    self->videoCamera.defaultFPS = 30;
    self->videoCamera.grayscaleMode = NO;

    [self->videoCamera start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Protocol CvVideoCameraDelegate

#ifdef __cplusplus
- (void)processImage:(Mat&)image;
{
    Mat image_copy;
    Mat canny_output;
    int lowThreshold = 100;
    std::vector<std::vector<cv::Point> > contours;
    std::vector<Vec4i> hierarchy;
    int ratio = 2.3;
    int kernel_size = 3;
    
    /// Convert image to gray and blur it
    cvtColor(image, image_copy, CV_BGRA2BGR);
    blur(image_copy, image_copy, cv::Size(kernel_size,kernel_size));
    
    /// Detect edges using canny
    Canny( image_copy, canny_output, lowThreshold, lowThreshold*ratio, kernel_size );
    
    /// Find contours
    findContours( canny_output, contours, hierarchy, CV_RETR_TREE , CV_CHAIN_APPROX_SIMPLE, cv::Point(0, 0) );
    
    /// Draw contours
    Scalar green = Scalar( 0, 255, 0 );
    Scalar red = Scalar( 0, 0, 255 );
    for( int i = 0; i< contours.size(); i++ )
    {
        drawContours( image, contours, i, red, 2, 8, hierarchy, 0, cv::Point() );
        // drawContours( image, contours, i, green, 2, 8, hierarchy, 0, cv::Point() );
    }
}
#endif

@end