//
//  FoursquareInfoViewController.m
//  TanningLoft
//
//  Created by Lavi on 30/06/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "FoursquareInfoViewController.h"
#import "NearbyVenuesViewController.h"
#import "SocialWeightDetailDBClass.h"

@interface FoursquareInfoViewController ()

@end

@implementation FoursquareInfoViewController
@synthesize points;
@synthesize containerView,tooltipImg;
@synthesize scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title=@"Four Square";
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
     self.points.text=[NSString stringWithFormat:@"%@ points",[(SocialWeightDetailDBClass *)[[tanningDelegate.dbClass fetchSocialPointWeight] objectAtIndex:0]FourSquarePoints]];
    
    if (self.view.bounds.size.height<=380) {
        
        containerView.frame=CGRectMake(self.containerView.frame.origin.x, 0, self.containerView.frame.size.width, self.containerView.frame.size.height);
        tooltipImg.hidden=YES;
    }
    
    scrollView.contentSize=CGSizeMake(320, 455);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)fourSquareBtnClicked:(id)sender{
    NearbyVenuesViewController *nearVC=[[NearbyVenuesViewController alloc]init];
    
    [self.navigationController pushViewController:nearVC animated:YES];
}

-(IBAction)backBtnClicked:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
