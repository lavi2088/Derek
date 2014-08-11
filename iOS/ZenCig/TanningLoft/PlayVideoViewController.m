//
//  PlayVideoViewController.m
//  MyMobiPoints
//
//  Created by Macmini on 31/12/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "PlayVideoViewController.h"

@interface PlayVideoViewController ()

@end

@implementation PlayVideoViewController
@synthesize webView,videoURL;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.navigationItem.title=@"Video";
        
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
    
    NSURL *nsurl=[NSURL URLWithString:videoURL];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    
    //  NSURLRequest* request1 = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    NSLog(@"RRRRRR%@",nsrequest);
    [self.webView loadRequest:nsrequest];
    self.webView.scalesPageToFit=YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)backBtnClicked:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)webViewDidStartLoad:(UIWebView*)sender
{
    
}

- (void)webViewDidFinishLoad:(UIWebView*)sender
{
    UIWebView *webView1=(UIWebView *)sender;
    if (webView1.isLoading)
        return;
    
    NSURLRequest* request = self.webView.request;
    
    NSLog(@"New Address is : %@", request.URL.absoluteString);
    
        
}

@end
