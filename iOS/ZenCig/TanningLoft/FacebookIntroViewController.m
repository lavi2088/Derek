//
//  FacebookIntroViewController.m
//  TanningLoft
//
//  Created by Lavi on 30/06/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "FacebookIntroViewController.h"
#import "SocialWeightDetailDBClass.h"
@interface FacebookIntroViewController ()

@end

@implementation FacebookIntroViewController
@synthesize points;
@synthesize containerView,tooltipImg;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
          self.navigationItem.title=@"Facebook";
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchDown];
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
    self.points.text=[(SocialWeightDetailDBClass *)[[tanningDelegate.dbClass fetchSocialPointWeight] objectAtIndex:0]FacebookPoints];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;   // iOS 7 specific
    self.navigationController.navigationBar.translucent = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    
    if (self.view.bounds.size.height<=380) {
        
        containerView.frame=CGRectMake(self.containerView.frame.origin.x, -10, self.containerView.frame.size.width, self.containerView.frame.size.height);
        tooltipImg.hidden=YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)facebookBtnClicked:(id)sender{
    
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    appDelegate.viewStatus=@"Home";
    
    if (FBSession.activeSession.state == FBSessionStateOpen) {
        // To-do, show logged in view
        FacebookArticleViewController *fbArticle=[[FacebookArticleViewController alloc]init];
        
        [self.navigationController pushViewController:fbArticle animated:YES];
        
    } else {
        // No, display the login page.
        // [self showLoginView];
        
        AppDelegate *delegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
        [delegate openSession];
    }

}

-(IBAction)backButtonClicked:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
