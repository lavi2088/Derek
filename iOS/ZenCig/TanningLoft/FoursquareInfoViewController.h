//
//  FoursquareInfoViewController.h
//  TanningLoft
//
//  Created by Lavi on 30/06/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Constant.h"

@interface FoursquareInfoViewController : UIViewController
@property(nonatomic,retain) IBOutlet UILabel *points;
@property(nonatomic,retain)IBOutlet UIView *containerView;
@property(nonatomic,retain)IBOutlet UIImageView *tooltipImg;
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;

-(IBAction)fourSquareBtnClicked:(id)sender;
-(IBAction)backBtnClicked:(id)sender;
@end
