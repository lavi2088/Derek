//
//  EarnPointViewController.h
//  TanningLoft
//
//  Created by Lavi on 09/05/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "AppDelegate.h"
#import "FacebookArticleViewController.h"
#import "InstagramLoginViewController.h"
#import "NearbyVenuesViewController.h"
#import "FacebookIntroViewController.h"
@interface EarnPointViewController : UIViewController
{
    UIBarButtonItem *barBtn;
}
@property(nonatomic,retain) IBOutlet UIView *containerView;
@property(nonatomic,retain) IBOutlet UIImageView *bgImg;
@property(nonatomic,retain) IBOutlet UILabel *termsLbl;
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;

-(IBAction)showFacebookView:(id)sender;
-(IBAction)showTwitterView:(id)sender;
@end
