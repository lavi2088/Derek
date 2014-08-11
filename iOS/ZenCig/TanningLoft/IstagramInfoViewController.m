//
//  IstagramInfoViewController.m
//  TanningLoft
//
//  Created by Lavi on 23/06/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "IstagramInfoViewController.h"

@interface IstagramInfoViewController ()

@end

@implementation IstagramInfoViewController
@synthesize points;
@synthesize containerView,tooltipImg;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
     self.points.text=[NSString stringWithFormat:@" points"];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
