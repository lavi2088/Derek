//
//  EarnPointViewController.m
//  TanningLoft
//
//  Created by Lavi on 09/05/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "EarnPointViewController.h"
#import "TwitterPageViewController.h"
#import <Twitter/Twitter.h>
#import "AccountViewController.h"
#import "IstagramViewController.h"
#import "AppDelegate.h"
#import "SettingViewController.h"
#import "TwitterIntroViewController.h"
#import "FoursquareInfoViewController.h"
#import "IGViewController.h"
#import "CallUserDetails.h"
#import "TermsAndConditionViewController.h"
#import "FlipViewController.h"

UIWebView *webview;

@interface EarnPointViewController ()

@end

@implementation EarnPointViewController
@synthesize containerView,bgImg,termsLbl,scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.title = NSLocalizedString(@"Earn Points", @"Earn Points");
       // self.tabBarItem.image = [UIImage imageNamed:@"earnedpoint"];
        self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:230.0/255.0 green:226.0/255.0 blue:225.0/255.0 alpha:1.0];
         self.navigationItem.title=@"Share & Earn Points";

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // Customize the title text for *all* UINavigationBars
    
    self.navigationController.navigationBar.clipsToBounds = YES;
    
    termsLbl.userInteractionEnabled = YES;
    UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(termsAction:)];
    [termsLbl addGestureRecognizer:gr];
    gr.numberOfTapsRequired = 1;
    gr.cancelsTouchesInView = NO;
    
    
    // here you go with iOS 7
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
            self.edgesForExtendedLayout = UIRectEdgeNone;   // iOS 7 specific
    self.navigationController.navigationBar.translucent = NO;
}



-(void)viewWillAppear:(BOOL)animated{
    // Customize the title text for *all* UINavigationBars
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor colorWithRed:16.0/255.0 green:16.0/255.0 blue:16.0/255.0 alpha:1.0],
      UITextAttributeTextColor,
      [UIColor colorWithRed:16.0/255.0 green:16.0/255.0 blue:16.0/255.0 alpha:0.2],
      UITextAttributeTextShadowColor,
      [NSValue valueWithUIOffset:UIOffsetMake(0, -1)],
      UITextAttributeTextShadowOffset,
      [UIFont fontWithName:@"Avenir" size:20.0],
      UITextAttributeFont,
      nil]];
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:230.0/255.0 green:226.0/255.0 blue:225.0/255.0 alpha:1.0];
    NSLog(@"self.view.bounds.size.height %f",self.view.bounds.size.height);
//    barBtn=[[UIBarButtonItem alloc] initWithTitle:@"My Purchases"
//                                            style:UIBarButtonItemStylePlain target:self action:@selector(showSetting:)];
//    self.navigationItem.rightBarButtonItem = barBtn;
    if ([[UIScreen mainScreen] bounds].size.height<=480) {
        
        containerView.frame=CGRectMake(self.containerView.frame.origin.x, 0, self.containerView.frame.size.width, self.containerView.frame.size.height);
        //self.scrollView.contentSize=CGSizeMake(320, 450);
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showFacebookView:sender{
    
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    appDelegate.viewStatus=@"Home";
    
    if (FBSession.activeSession.state == FBSessionStateOpen) {
        // To-do, show logged in view
        //FacebookArticleViewController *fbArticle=[[FacebookArticleViewController alloc]init];
        FlipViewController *flipVC=[[FlipViewController alloc]init];
        flipVC.socialType=@"facebook";
        [self.navigationController pushViewController:flipVC animated:YES];
        
    } else {
        // No, display the login page.
        // [self showLoginView];
        
        AppDelegate *delegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
        [delegate openSession];
    }

}
-(IBAction)showTwitterView:(id)sender
{
    if ([TWTweetComposeViewController canSendTweet]) {
        NSLog(@"I can send tweets.");
        // Initialize Tweet Compose View Controller
        TwitterPageViewController *vc = [[TwitterPageViewController alloc] init];
        // Settin The Initial Text
//        [vc setInitialText:@"This tweet was sent using the new Twitter framework available in iOS 5."];
        
        FlipViewController *flipVC=[[FlipViewController alloc]init];
        flipVC.socialType=@"twitter";
        
         [self.navigationController pushViewController:flipVC animated:YES];
    }
    else {
        // Show Alert View When The Application Cannot Send Tweets
        NSString *message = @"The application cannot send a tweet at the moment. This is because it cannot reach Twitter or you don't have a Twitter account associated with this device.";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops" message:message delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alertView show];
    }
    
//    TwitterIntroViewController *twitterIntro=[[TwitterIntroViewController alloc]init];
//    [self.navigationController pushViewController:twitterIntro animated:YES];
}

-(IBAction)showAccount:(id)sender{
    
    AccountViewController *acVC=[[AccountViewController alloc]init];
    
    [self.navigationController pushViewController:acVC animated:YES];
    
    [barBtn setAction:@selector(doneBtn:)];
}

-(IBAction)doneBtn:(id)sender{
    
     [self.navigationController popViewControllerAnimated:YES];
    [barBtn setAction:@selector(showAccount:)];
}

-(IBAction)istagramBtnClick:(id)sender{

    if ([[(UserDetailDBClass *)[[tanningDelegate.dbClass fetchUserDetail] objectAtIndex:0] isActive] integerValue]) {
        IGViewController *istVC=[[IGViewController alloc]init];
        [self.navigationController pushViewController:istVC animated:YES];
    }
    else{
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Admin Restricted" message:@"You are not allowed to post any social content, admin has blocked your access." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
}

-(IBAction)fourSquareBtnClicked:(id)sender{
    
    FoursquareInfoViewController *fourVC=[[FoursquareInfoViewController alloc]init];
    
    [self.navigationController pushViewController:fourVC animated:YES];
}

-(IBAction)showSetting:(id)sender{
    
    SettingViewController *settingVC=[[SettingViewController alloc]init];
    
    [self.navigationController pushViewController:settingVC animated:YES];
}

-(IBAction)termsAction:(id)sender{
    
    TermsAndConditionViewController *termsVC=[[TermsAndConditionViewController alloc]init];
    
    [self.navigationController pushViewController:termsVC animated:YES];
}

@end
