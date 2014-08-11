//
//  AboutUsViewController.m
//  TanningLoft
//
//  Created by Lavi on 23/06/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController
@synthesize containerView,lbl1,lbl2;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.backBarButtonItem.title=@"Back";
        self.navigationItem.title=@"About Us";
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchDown];
        [button setTitle:@"" forState:UIControlStateNormal];
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
    if (self.view.bounds.size.height<=380) {
        
        containerView.frame=CGRectMake(self.containerView.frame.origin.x, 10, self.containerView.frame.size.width, self.containerView.frame.size.height);
//        lbl1.font=[UIFont fontWithName: @"Helvetica-Bold" size:13.0];
//        lbl2.font=[UIFont fontWithName: @"Helvetica-Bold" size:13.0];
//        lbl2.frame=CGRectMake(self.lbl2.frame.origin.x, 151-35, self.lbl2.frame.size.width, self.lbl2.frame.size.height);
    }
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
