//
//  SocialViewController.m
//  TanningLoft
//
//  Created by Lavi on 30/06/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "SocialViewController.h"

@interface SocialViewController ()

@end

@implementation SocialViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.navigationItem.title=@"Social";
        
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
}

-(void)viewWillAppear:(BOOL)animated{
    
    NSString *url=[NSString stringWithFormat:@"http://www.tanningloft.ca/social"];
    NSURL *nsurl=[NSURL URLWithString:url];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    NSLog(@"RRRRRR%@",nsrequest);
    [self.webview loadRequest:nsrequest];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidStartLoad:(UIWebView*)sender
{
    
    for ( id object in self.webview.subviews ) {
        if ([object isMemberOfClass:[UIActivityIndicatorView class]]) {
            actView = (UIActivityIndicatorView*)object;
        }
    }
    NSLog(@"Web view did start loading");
    [actView startAnimating];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView*)sender
{
    [actView stopAnimating];
}

-(IBAction)backBtnClicked:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
