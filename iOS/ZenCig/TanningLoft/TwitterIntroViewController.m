//
//  TwitterIntroViewController.m
//  TanningLoft
//
//  Created by Lavi on 30/06/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "TwitterIntroViewController.h"
#import "FHSTwitterEngine.h"

#define kOAuthConsumerKey				@"Ut2Vsenrg9dxW28vRNXpKA"		//REPLACE ME
#define kOAuthConsumerSecret			@"IPw0IJpeOoQRUxgvIv8ffCdeGbifJ0zbCka2u3Rj4"		//REPLACE ME

@interface TwitterIntroViewController ()<FHSTwitterEngineAccessTokenDelegate>

@end

@implementation TwitterIntroViewController
@synthesize points;
@synthesize containerView,tooltipImg;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title=@"Twitter";
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchDown];
        [button setTitle:@" " forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:14]];
        button.frame=CGRectMake(0, 0, 30, 30);
        [button setBackgroundImage:[UIImage imageNamed:@"back_d"] forState:UIControlStateNormal];
        
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        [self.navigationItem setLeftBarButtonItem:barButtonItem];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.points.text=[(SocialWeightDetailDBClass *)[[tanningDelegate.dbClass fetchSocialPointWeight] objectAtIndex:0]TwitterPoints];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;   // iOS 7 specific
    self.navigationController.navigationBar.translucent = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    if (self.view.bounds.size.height<=380) {
        
        containerView.frame=CGRectMake(self.containerView.frame.origin.x, -10, self.containerView.frame.size.width, self.containerView.frame.size.height);
        tooltipImg.hidden=YES;
    }
    
//    [[FHSTwitterEngine sharedEngine]loadAccessToken];
//    NSString *username = [[FHSTwitterEngine sharedEngine]loggedInUsername];// self.engine.loggedInUsername;
//    if (username.length > 0) {
//        //loggedInUserLabel.text = [NSString stringWithFormat:@"Logged in as %@",username];
//    } else {
//        //loggedInUserLabel.text = @"You are not logged in.";
//    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)twitterBtnClicked:(id)sender{
    if ([TWTweetComposeViewController canSendTweet]) {
        NSLog(@"I can send tweets.");
        // Initialize Tweet Compose View Controller
        TwitterPageViewController *vc = [[TwitterPageViewController alloc] init];
        // Settin The Initial Text
        //        [vc setInitialText:@"This tweet was sent using the new Twitter framework available in iOS 5."];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        // Show Alert View When The Application Cannot Send Tweets
        NSString *message = @"The application cannot send a tweet at the moment. This is because it cannot reach Twitter or you don't have a Twitter account associated with this device.";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops" message:message delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        //[alertView show];
        
            TwitterPageViewController *vc = [[TwitterPageViewController alloc] init];
            // Settin The Initial Text
            //        [vc setInitialText:@"This tweet was sent using the new Twitter framework available in iOS 5."];
            [self.navigationController pushViewController:vc animated:YES];
//        }];
        
    }
}

- (void)storeAccessToken:(NSString *)accessToken {
    [[NSUserDefaults standardUserDefaults]setObject:accessToken forKey:@"SavedAccessHTTPBody"];
}

- (NSString *)loadAccessToken {
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"SavedAccessHTTPBody"];
}

-(IBAction)backBtnClicked:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}



@end
