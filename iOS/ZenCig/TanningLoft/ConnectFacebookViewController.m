//
//  ConnectFacebookViewController.m
//  TanningLoft
//
//  Created by Lavi on 03/06/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "ConnectFacebookViewController.h"
#import "AppDelegate.h"

@interface ConnectFacebookViewController ()

@end

@implementation ConnectFacebookViewController

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
    
    if (FBSession.activeSession.state == FBSessionStateOpen) {
        // To-do, show logged in view
        // FacebookArticleViewController *fbArticle=[[FacebookArticleViewController alloc]init];
        
        //[self.navigationController pushViewController:fbArticle animated:YES];
        
        AppDelegate *appDelegate=[[UIApplication sharedApplication]delegate];
        
        [appDelegate switchRootView];
        
    }
    else{
        
        NSLog(@"Login");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)connectFacebookBtn:(id)sender{
    
    NSLog(@"Bundle ID: %@",[[NSBundle mainBundle] bundleIdentifier]);
    
     AppDelegate *appDelegate=[[UIApplication sharedApplication]delegate];
    
    appDelegate.viewStatus=@"Connect";
    
    if (FBSession.activeSession.state == FBSessionStateOpen) {
        // To-do, show logged in view
       // FacebookArticleViewController *fbArticle=[[FacebookArticleViewController alloc]init];
        
        //[self.navigationController pushViewController:fbArticle animated:YES];
        
       
        
        [appDelegate switchRootView];
        
    } else {
        // No, display the login page.
        // [self showLoginView];
        
        AppDelegate *delegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
        [delegate openSession];
    }
    
   
}

@end
