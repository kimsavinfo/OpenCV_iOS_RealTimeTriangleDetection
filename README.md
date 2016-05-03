# OpenCV_iOS_RealTimeTriangleDetection
With openCV iOS : find in real time a triangle shape drawn by hands

![test01](screenshots/test01.png)

## How do I import openCV iOS ?

### Link Libraries
Go to Project > Build Phases > Link Binary With Libraries
* Accelerate.framework
* AssetsLibrary.framework
* AVFoundation.framework
* CoreGraphics.framework
* CoreImage.framework
* CoreMedia.framework
* CoreVideo.framework
* Foundation.framework
* QuartzCore.framework
* UIKit.framework

![import_frameworks](screenshots/import_frameworks.png)

### Import openCV 2
Drag and drop opencv2.framework in the directory frameworks :
* check Copy the items
* check create groups 
* check add to targets "project"
* in ViewController.h add the line : "#import <opencv2/opencv.hpp>"
* don't forget to rename ViewController.m in ViewController.mm

### Versions

OS X : El Capitan 10.11.4

XCode : 7.3

OpenCV 3.1.0 