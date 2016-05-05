//
//  ShapeDetector.m
//  OpenCV_RealTimeTriangleDetection
//
//  Created by Kim SAVAROCHE on 02/05/2016.
//  Copyright © 2016 Kim SAVAROCHE. All rights reserved.
//

#import "ShapeDetector.h"

@implementation ShapeDetector

-(void)cleanUp {
    _thresholdOutput = cv::Mat();
    _thresholdContours.clear();
    _cannyContours.clear();
    _cannyMc.clear();
    _iBiggestShape = -1;
}

-(void)findBiggestShapeFromImage:(cv::Mat&)imgSrc verticesNb:(int)nbVertices minArea:(int)areaMin{
    std::vector<cv::Point> approx;
    float biggestArea = 0;
    float area;

    [self cleanUp];
    cv::Mat imgCopy = cv::Mat::zeros( imgSrc.size(), CV_8UC3 );
    [self findThresholdContoursFromImage:imgSrc];
    [self drawThresholdContoursOnImage:imgCopy];
    [self findCannyContoursFromImage:imgCopy];

    for (int i = 0; i < _cannyContours.size(); i++) {
        // Approximate contour with accuracy proportional
        // to the contour perimeter
        cv::approxPolyDP(cv::Mat(_cannyContours[i]), approx,
                cv::arcLength(cv::Mat(_cannyContours[i]), true)*CANNY_EPS_COEFFICIENT, true);

        area = std::fabs(cv::contourArea(_cannyContours[i]));

        // Skip small or too big or non-convex objects
        // Skip the shapes which are not in the center
        if ( area > areaMin && cv::isContourConvex(approx) && _cannyMc[i].y > 170 && _cannyMc[i].y < 230) {
            if (approx.size() == nbVertices) {
                if(area > biggestArea){
                    std::cout << "Shape : " << area << "(" <<  _cannyMc[i].x << ";" << _cannyMc[i].y << ")";
                    _iBiggestShape = i;
                }
            }
        }
    }
}

-(void)findThresholdContoursFromImage:(cv::Mat&)imgSrc {
    cv::Mat imageCopy;
    std::vector<cv::Vec4i> thresholdHierarchy;

    /// Put the image in grayscale and blur it
    [ImageProcesser BGR2GRAYImage:imgSrc outputImg:imageCopy];
    [ImageProcesser blurImage:imageCopy outputImg:imageCopy];

    /// Threshold : detect edges
    threshold( imageCopy, _thresholdOutput, THRESHOLD_VALUE, THRESHOLD_MAX, THRESHOLD_TYPE);

    /// Find contours from detected edges
    findContours( _thresholdOutput, _thresholdContours, thresholdHierarchy,
            CV_RETR_TREE, CV_CHAIN_APPROX_SIMPLE, cv::Point(0, 0) );
}

// minArea = 2000 for example
-(void)findCannyContoursFromImage:(cv::Mat&)imgSrc{
    cv::Mat imageCopy;

    /// Canny : catch squares with gradient shading
    cv::Canny(imgSrc, imageCopy, CANNY_LOW_THRESHOLD, CANNY_HIGH_THRESHOLD, CANNY_KERNEL_SIZE);

    /// Find contours
    cv::findContours(imageCopy.clone(), _cannyContours, CV_RETR_EXTERNAL, CV_CHAIN_APPROX_SIMPLE);

    /// For each contour :
    std::vector<cv::Moments> cannyMu(_cannyContours.size());
    _cannyMc.reserve(_cannyContours.size());
    for(int i = 0; i < _cannyContours.size(); i++ ) {
        /// - find moments
        cannyMu[i] = moments( _cannyContours[i], false );
        /// - find mass centers
        _cannyMc[i] = cv::Point2f( cannyMu[i].m10/cannyMu[i].m00 , cannyMu[i].m01/cannyMu[i].m00 );
    }

}

-(void)drawBiggestShapeOnImage:(cv::Mat&)imgSrc{
    if(_iBiggestShape > -1) {
        drawContours(imgSrc, _cannyContours, _iBiggestShape, green, 4, 8, std::vector<cv::Vec4i>(), 0, cv::Point());
        circle(imgSrc, _cannyMc[_iBiggestShape], 4, green, 3, 8, 0);
    }
}

-(void)drawThresholdContoursOnImage:(cv::Mat&)imgSrc {
    /// For each contour, we find the convex hull object
    std::vector<std::vector<cv::Point>>thresholdHull( _thresholdContours.size() );

    /// Drawing contours and hull
    for( int i = 0; i<_thresholdContours.size(); i++ ) {
        drawContours( imgSrc, _thresholdContours, i, blue, 4, 8, std::vector<cv::Vec4i>(), 0, cv::Point() );

        convexHull( cv::Mat(_thresholdContours[i]), thresholdHull[i], false );
        drawContours( imgSrc, thresholdHull, i, red, 4, 8, std::vector<cv::Vec4i>(), 0, cv::Point() );
    }
}

-(void)drawCannyContoursOnImage:(cv::Mat&)imgSrc {
    for(int i = 0; i < _cannyContours.size(); i++ ) {
        drawContours( imgSrc, _cannyContours, i, yellow, 4, 8, std::vector<cv::Vec4i>(), 0, cv::Point() );
        circle( imgSrc, _cannyMc[i], 3, yellow, 3, 8, 0 );
    }
}

- (bool)isShapeFound {
    return _iBiggestShape == -1 ? false : true;
}


@end
