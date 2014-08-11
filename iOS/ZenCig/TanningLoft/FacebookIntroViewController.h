//
//  FacebookIntroViewController.h
//  TanningLoft
//
//  Created by Lavi on 30/06/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Constant.h"
#import <FacebookSDK/FacebookSDK.h>
#import "FacebookArticleViewController.h"

@interface FacebookIntroViewController : UIViewController
@property(nonatomic,retain)IBOutlet UILabel *points;
@property(nonatomic,retain)IBOutlet UIView *containerView;
@property(nonatomic,retain)IBOutlet UIImageView *tooltipImg;
-(IBAction)facebookBtnClicked:(id)sender;
-(IBAction)backBtnClicked:(id)sender;
@end
