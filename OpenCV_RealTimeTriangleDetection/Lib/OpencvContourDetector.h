//
// Created by Kim SAVAROCHE on 27/03/2016.
// Copyright (c) 2016 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OpencvConverter.h"

static const float EPS_COEFFICIENT = 0.15;

@interface OpencvContourDetector : NSObject
{
    CvSeq *contours;
    CvSeq *contourPoints;
    CvMemStorage *contoursStorage;

    CvSeq *biggestPolygon;
    bool isBiggestPolygonFound;
}

-(id)initWithImage:(UIImage *)_imageRGBA;

-(void)findContours:(UIImage *)_imageRGBA;

-(void)findBiggestPolygon:(int)_nbVerticies;

-(UIImage *)drawBiggestPolygon:(UIImage *)_imageRGBA :(int)_red :(int)_green :(int)_blue;

-(CvSeq *)contourPoints;

@end