//
//  TwitterIntroViewController.h
//  TanningLoft
//
//  Created by Lavi on 30/06/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "AppDelegate.h"
#import "TwitterPageViewController.h"
#import <Twitter/Twitter.h>



@interface TwitterIntroViewController : UIViewController
@property(nonatomic,retain)IBOutlet UILabel *points;
@property(nonatomic,retain)IBOutlet UIView *containerView;
@property(nonatomic,retain)IBOutlet UIImageView *tooltipImg;
-(IBAction)twitterBtnClicked:(id)sender;
-(IBAction)backBtnClicked:(id)sender;
@end
