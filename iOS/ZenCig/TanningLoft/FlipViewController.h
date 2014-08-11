//
//  FlipViewController.h
//  MyMobiPoints
//
//  Created by Macmini on 30/12/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPFlipViewController.h"

@interface FlipViewController : UIViewController<MPFlipViewControllerDelegate, MPFlipViewControllerDataSource>
@property(nonatomic,retain)NSString *socialType;
@property (strong, nonatomic) MPFlipViewController *flipViewController;

@end
