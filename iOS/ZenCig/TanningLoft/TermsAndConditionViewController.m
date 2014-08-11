//
//  TermsAndConditionViewController.m
//  MyMobiPoints
//
//  Created by Macmini on 20/12/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "TermsAndConditionViewController.h"
#import "AppDelegate.h"
#import "Constant.h"
// 7.0 and above
#define IS_DEVICE_RUNNING_IOS_7_AND_ABOVE() ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending)

@interface TermsAndConditionViewController ()

@end

@implementation TermsAndConditionViewController
@synthesize webview;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title=@"Terms and Condition";
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
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;   // iOS 7 specific
    self.navigationController.navigationBar.translucent = NO;
    
    if(IS_DEVICE_RUNNING_IOS_7_AND_ABOVE())// only for iOS 7 and above
    {
        CGRect frame = self.view.frame;
        frame.origin.y += 20;
        frame.size.height -= 20;
        self.view.frame = frame;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    
    NSURL *nsurl=[NSURL URLWithString:[NSString stringWithFormat:@"%@termsandcondition.html",tanningDelegate.hostString]];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    
    NSLog(@"RRRRRR%@",nsrequest);
    [self.webview loadRequest:nsrequest];
    self.webview.scalesPageToFit=YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)backBtnClicked:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
