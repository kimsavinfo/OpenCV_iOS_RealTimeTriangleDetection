//
//  TriangleDetectionLigthBackground.m
//  OpenCV_RealTimeTriangleDetection
//
//  Created by Kim SAVAROCHE on 29/04/2016.
//  Copyright © 2016 Kim SAVAROCHE. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "../Lib/OpencvContourDetector.h"

@interface TriangleDetectionLigthBackground : XCTestCase

@end

@implementation TriangleDetectionLigthBackground {
    OpencvContourDetector *contourDetector;
}

- (void)setUp {
    [super setUp];
    
    UIImage *img = [UIImage imageNamed:@"triangle_hands2.jpg"];
    contourDetector = [[OpencvContourDetector alloc] initWithImage:img];
    [contourDetector findBiggestPolygon:3];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testShape3PointsCleanedBackground {
    XCTAssertEqual(3, contourDetector.contourPoints->total);
}

- (void)testShapeAreaMinCleanedBackground {
    double area = cvContourArea(contourDetector.contourPoints);
    
    XCTAssertGreaterThan(area, 6900);
}

- (void)testShapeAreaMaxCleanedBackground {
    double area = cvContourArea(contourDetector.contourPoints);
    
    XCTAssertLessThan(area, 7000);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}


@end
