//
//  IGViewController.m
//  InstagramClient
//
//  Created by Cristiano Severini on 12/07/12.
//  Copyright (c) 2012 Crino. All rights reserved.
//

#import "IGViewController.h"

#import "AppDelegate.h"
#import "IstagramViewController.h"
#import "IstagramInfoViewController.h"
@interface IGViewController ()

@end

@implementation IGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
  
}

-(void)viewWillAppear:(BOOL)animated{
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    // here i can set accessToken received on previous login
    appDelegate.instagram.accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"];
    appDelegate.instagram.sessionDelegate = self;
    if ([appDelegate.instagram isSessionValid]) {
        IstagramViewController *istaVC=[[IstagramViewController alloc] initWithNibName:@"IstagramInfoViewController" bundle:nil];
        
        tanningDelegate.accessToken=[[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"];
        
        NSArray *accessTokenArray = [tanningDelegate.accessToken componentsSeparatedByString: @"."];
        
        tanningDelegate.instagramId=[accessTokenArray objectAtIndex:0];
        
        [[NSUserDefaults standardUserDefaults] setObject:[accessTokenArray objectAtIndex:0] forKey:@"instagramid"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self.navigationController pushViewController:istaVC animated:YES];
    }
    else
    {
        [appDelegate.instagram authorize:[NSArray arrayWithObjects:@"comments", @"likes", nil]];
    }
    
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(void)login {
    AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [appDelegate.instagram authorize:[NSArray arrayWithObjects:@"comments", @"likes", nil]];
}

#pragma - IGSessionDelegate

-(void)igDidLogin {
    NSLog(@"Instagram did login");
    // here i can store accessToken
    AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [[NSUserDefaults standardUserDefaults] setObject:appDelegate.instagram.accessToken forKey:@"accessToken"];
	[[NSUserDefaults standardUserDefaults] synchronize];
    
    IstagramViewController *istaVC=[[IstagramViewController alloc]initWithNibName:@"IstagramInfoViewController" bundle:nil];
    
   // NSArray *chunks = [[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"];
    
    //NSLog(@"[chunks objectAtIndex:1] %@",[chunks objectAtIndex:1]);
    tanningDelegate.accessToken=[[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"];
    
    NSArray *accessTokenArray = [tanningDelegate.accessToken componentsSeparatedByString: @"."];
    
    tanningDelegate.instagramId=[accessTokenArray objectAtIndex:0];
    [[NSUserDefaults standardUserDefaults] setObject:[accessTokenArray objectAtIndex:0] forKey:@"instagramid"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.navigationController pushViewController:istaVC animated:YES];
}

-(void)igDidNotLogin:(BOOL)cancelled {
    
    NSLog(@"Instagram did not login");
    
    NSString* message = nil;
    if (cancelled) {
        message = @"Access cancelled!";
    } else {
        message = @"Access denied!";
    }
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    [alertView show];
}

-(void)igDidLogout {
    NSLog(@"Instagram did logout");
    // remove the accessToken
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"accessToken"];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)igSessionInvalidated {
    NSLog(@"Instagram session was invalidated");
}

@end
