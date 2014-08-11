//
//  SpinWheelViewController.h
//  TanningLoft
//
//  Created by Lavi on 09/05/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMRotaryProtocol.h"
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))

@interface SpinWheelViewController : UIViewController
{
    int counter;
    NSURLConnection  *spinDetailConnection;
    NSURLConnection  *spinUploadDetailConnection;
    NSURLConnection  *lastSpinDetailConnection;
    NSMutableData *shareDataArray;
    UIActivityIndicatorView *activityIndicator;
    NSMutableArray *spinLastData;
    NSMutableData *pointDataArray;
    UIView *dimView;
    
    BOOL touchesMoved;
    
    CGPoint lastPoint;
    NSTimeInterval lastTouchTimeStamp;
    
    double currentAngle;
    double angularSpeed;
    CATransform3D currentTransform;
    NSInteger turnDirection;
    NSMutableArray *prizeArray;
    NSInteger wheelStatus;
    
    NSURLConnection  *SpinPointsDetailConnection;
    NSMutableData *SpinPointsDataArray;
}
@property (nonatomic, strong) UILabel *valueLabel;
@property (nonatomic, retain) IBOutlet UIView *mShipWheel;

//*******************************

@property (nonatomic, retain) IBOutlet UIImageView *img1;
@property (nonatomic, retain) IBOutlet UILabel *lbl1;
@property (nonatomic, retain) IBOutlet UIImageView *img2;
@property (nonatomic, retain) IBOutlet UILabel *lbl2;
@property (nonatomic, retain) IBOutlet UIImageView *img3;
@property (nonatomic, retain) IBOutlet UILabel *lbl3;
@property (nonatomic, retain) IBOutlet UIImageView *img4;
@property (nonatomic, retain) IBOutlet UILabel *lbl4;
@property (nonatomic, retain) IBOutlet UIImageView *img5;
@property (nonatomic, retain) IBOutlet UILabel *lbl5;
@property (nonatomic, retain) IBOutlet UIImageView *img6;
@property (nonatomic, retain) IBOutlet UILabel *lbl6;
@property (nonatomic, retain) IBOutlet UIImageView *img7;
@property (nonatomic, retain) IBOutlet UILabel *lbl7;
@property (nonatomic, retain) IBOutlet UIImageView *img8;
@property (nonatomic, retain) IBOutlet UILabel *lbl8;

//*******************************

//Math Functions//
-(double)DistanceBetweenTwoPoints:(CGPoint)point1:(CGPoint) point2;
-(double)angleBetweenThreePoints:(CGPoint)x :(CGPoint)y :(CGPoint)z;
-(double)crossProduct:(CGPoint)p1 :(CGPoint)p2 :(CGPoint)p3;
-(void)spin:(double)delta;

//Spinning Animation//
- (void)runSpinAnimation;
@end
