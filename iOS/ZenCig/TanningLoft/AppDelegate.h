//
//  AppDelegate.h
//  TanningLoft
//
//  Created by Lavi on 09/05/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <sqlite3.h>
#import "IstagramViewController.h"
#import "DBConnectionClass.h"
#import "CaptureImageViewController.h"
#import "GetServerCurrentTimeWebService.h"
#import "Instagram.h"

#define IOS_NEWER_OR_EQUAL_TO_6 ( [ [ [ UIDevice currentDevice ] systemVersion ] floatValue ] >= 6.0 )
@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate,FBLoginViewDelegate>
{
    UINavigationController *earnPointNavController;
     UINavigationController *redeemNavController;
     UINavigationController *browseNavController;
     UINavigationController *reserveNavController;
     UINavigationController *spinWheelNavController;
    UITabBarController *tabBarController;
    
    NSString *docsDir;
    NSArray *dirPaths;
    sqlite3 *appreaderDB;
    
    NSString *viewStatus;
    
    NSURLConnection  *pointDetailConnection;
    NSMutableData *pointDataArray;
    DBConnectionClass *dbClass;
    
    NSURLConnection  *shareDetailConnection;
    NSMutableData *shareDataArray;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) NSString *viewStatus;
@property (strong, nonatomic) NSString *hostString;
@property (strong, nonatomic) NSString *currentServerTime;

@property(nonatomic,retain)UINavigationController *earnPointNavController;
@property(nonatomic,retain)UINavigationController *redeemNavController;
@property(nonatomic,retain)UINavigationController *browseNavController;
@property(nonatomic,retain)UINavigationController *reserveNavController;
@property(nonatomic,retain)UINavigationController *spinWheelNavController;
@property(nonatomic,retain)UITabBarController *tabBarController;
@property (strong, nonatomic) NSString *accessToken;
@property (strong, nonatomic) NSString *instagramId;
@property (assign, nonatomic) BOOL instagramShareStatus;
@property(nonatomic,retain) DBConnectionClass *dbClass;
@property(nonatomic,retain)NSMutableArray *activityStatusID;
@property(nonatomic,retain)NSTimer *activityTimer;
@property (strong, nonatomic) Instagram *instagram;

- (void)openSession;

-(void)switchRootView;
-(void)callActivityStatusService;
@end
