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
    Mat threshold_output;
    int thresh = 155;
    int maxval = 255;
    std::vector<std::vector<cv::Point> > contours;
    std::vector<Vec4i> hierarchy;
    int kernel_size = 3;
    Scalar green = Scalar( 0, 255, 0 );
    Scalar red = Scalar( 255, 0, 0);
    Scalar blue = Scalar( 0, 0, 255);
    
    /// Convert image to gray and blur it
    cvtColor( image, image_copy, CV_BGR2GRAY );
    blur( image_copy, image_copy, cv::Size(kernel_size,kernel_size) );
    
    /// Detect edges using Threshold
    threshold( image_copy, threshold_output, thresh, maxval, THRESH_BINARY_INV );
    
    // ===== PHASE : 1
    
    /// Find contours
    findContours( threshold_output, contours, hierarchy, CV_RETR_TREE, CV_CHAIN_APPROX_SIMPLE, cv::Point(0, 0) );
    
    /// Find the convex hull object for each contour
    std::vector<std::vector<cv::Point> >hull( contours.size() );
    for( int i = 0; i < contours.size(); i++ )
    {
        convexHull( Mat(contours[i]), hull[i], false );
    }
    
    /// Draw hull contours
    Mat drawing = Mat::zeros( threshold_output.size(), CV_8UC3 );
    for( int i = 0; i< contours.size(); i++ )
    {
        drawContours( drawing, contours, i, blue, 4, 8, std::vector<Vec4i>(), 0, cv::Point() );
        drawContours( drawing, hull, i, red, 4, 8, std::vector<Vec4i>(), 0, cv::Point() );
        // drawContours( image, hull, i, red, 4, 8, std::vector<Vec4i>(), 0, cv::Point() );
    }
    
    // ===== PHASE : 2 - is there a triangle ?
    // Use Canny instead of threshold to catch squares with gradient shading
    cv::Mat bw;
    cv::Canny(drawing, bw, 0, 50, 5);
    // Find contours
    std::vector<std::vector<cv::Point> > contours2;
    cv::findContours(bw.clone(), contours2, CV_RETR_EXTERNAL, CV_CHAIN_APPROX_SIMPLE);
    
    std::vector<cv::Point> approx;
    float EPS_COEFFICIENT = 0.03;
    for (int i = 0; i < contours2.size(); i++)
    {
        // Approximate contour with accuracy proportional
        // to the contour perimeter
        cv::approxPolyDP(cv::Mat(contours2[i]), approx, cv::arcLength(cv::Mat(contours2[i]), true)*EPS_COEFFICIENT, true);
        
        // Skip small or too big or non-convex objects
        if ( std::fabs(cv::contourArea(contours2[i])) > 2500 && cv::isContourConvex(approx))
        {
            if (approx.size() == 3)
            {
                printf("TRI : %f \n", std::fabs(cv::contourArea(contours2[i])));
                drawContours( drawing, contours2, i, green, 4, 8, std::vector<Vec4i>(), 0, cv::Point() );
                // drawContours( image, contours2, i, blue, 4, 8, std::vector<Vec4i>(), 0, cv::Point() );
            }
        }
    }
    
    image = drawing;
}
#endif

@end