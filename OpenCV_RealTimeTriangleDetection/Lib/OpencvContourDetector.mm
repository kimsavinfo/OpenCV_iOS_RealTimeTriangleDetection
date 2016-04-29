//
// Created by Kim SAVAROCHE on 27/03/2016.
// Copyright (c) 2016 ___FULLUSERNAME___. All rights reserved.
//

#import "OpencvContourDetector.h"


@implementation OpencvContourDetector

-(id)initWithImage:(UIImage *)_imageRGBA
{
    self = [super init];

    if (self)
    {
        contoursStorage = cvCreateMemStorage(0);
        isBiggestPolygonFound = false;

        [self findContours:_imageRGBA];
    }

    return self;
}

-(void)findContours:(UIImage *)_imageRGBA
{
    IplImage *iplImage = new IplImage([OpencvConverter UIImage2cvMat:_imageRGBA]);

    /// In order to get the best result, we had a threshold thanks to the greyscale
    IplImage *iplImageGreyscale = cvCreateImage(cvGetSize(iplImage), 8, 1);
    cvCvtColor(iplImage, iplImageGreyscale,CV_BGR2GRAY);
    cvThreshold(iplImageGreyscale, iplImageGreyscale,128,255,CV_THRESH_BINARY);

    cvFindContours(iplImageGreyscale, contoursStorage, &contours, sizeof(CvContour), CV_RETR_LIST, CV_CHAIN_APPROX_SIMPLE, cvPoint(0,0));
}

-(void)findBiggestPolygon:(int)_nbVerticies
{
    double biggestArea = 0;
    double area = 0;
    isBiggestPolygonFound = false;

    while(contours)
    {
        CvSeq *contourPointsTmp = cvApproxPoly(contours, sizeof(CvContour), contoursStorage, CV_POLY_APPROX_DP, cvContourPerimeter(contours)* EPS_COEFFICIENT, 0);
        
        if(contourPointsTmp->total == _nbVerticies)
        {
            area = cvContourArea(contourPointsTmp);
            
            if(area > biggestArea)
            {
                contourPoints = contourPointsTmp;
                biggestPolygon = contourPointsTmp;
                biggestArea = area;
                isBiggestPolygonFound = true;
            }
        }

        contours = contours->h_next;
    }
}

-(UIImage *)drawBiggestPolygon:(UIImage *)_imageRGBA :(int)_red :(int)_green :(int)_blue
{
    IplImage*iplImage = new IplImage([OpencvConverter UIImage2cvMat:_imageRGBA]);

    if(isBiggestPolygonFound)
    {
        CvPoint *points[biggestPolygon->total];

        for(int iPoint = 0; iPoint <biggestPolygon->total; iPoint++)
        {
            points[iPoint] = (CvPoint*)cvGetSeqElem(biggestPolygon, iPoint);

            if(iPoint > 0)
            {
                cvLine(iplImage, *points[(iPoint - 1)], *points[iPoint], cvScalar(_red,_green,_blue),2);
            }
            if(iPoint == (biggestPolygon->total-1))
            {
                cvLine(iplImage, *points[iPoint], *points[0], cvScalar(_red,_green,_blue),2);
            }
        }
    }

    return [OpencvConverter cvMat2UIImage:cv::cvarrToMat(iplImage)];
}

-(CvSeq *) contourPoints{
    return contourPoints;
}


@end