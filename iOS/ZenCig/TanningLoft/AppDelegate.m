//
//  AppDelegate.m
//  TanningLoft
//
//  Created by Lavi on 09/05/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import "EarnPointViewController.h"
#import "ReedemViewController.h"
#import "BrowseViewController.h"
#import "ReserveViewController.h"
#import "SpinWheelViewController.h"
#import "AccountViewController.h"
#import "ConnectFacebookViewController.h"
#import "DBConnectionClass.h"
#import "AccountNavigationViewController.h"
#import "ActivityLogDBClass.h"
#import "ActivityStatusService.h"
#import "UserDetailDBClass.h"
#import "InitialActivityLogWebService.h"
#import "SocialWeightDetailDBClass.h"
#import "SignUpViewController.h"
#import "LoginFirstTimeViewController.h"
#import "CallUserDetails.h"
#import <Accounts/Accounts.h>

#define APP_ID @"2db30e7f2255480687c3da1ce3e3fce2"

ActivityStatusService *activityService;

@implementation AppDelegate
@synthesize earnPointNavController,redeemNavController,browseNavController,spinWheelNavController,reserveNavController,tabBarController,viewStatus,dbClass,currentServerTime;
@synthesize hostString,accessToken,instagramId,instagramShareStatus,activityStatusID,activityTimer;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    // -applicationDidFinishLaunching:
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    //[UIApplication sharedApplication].applicationIconBadgeNumber=0 ;
    
    self.instagram = [[Instagram alloc] initWithClientId:APP_ID
                                                delegate:nil];
    
    hostString=@"http://mymobipoints.com/sb-admin/sb-admin/";
    [[NSUserDefaults standardUserDefaults] registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],@"tanfirstLaunch",nil]];
    
    [FBProfilePictureView class];
    
    // Customize the title text for *all* UINavigationBars
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor colorWithRed:16.0/255.0 green:16.0/255.0 blue:16.0/255.0 alpha:1.0],
      UITextAttributeTextColor,
      [UIColor colorWithRed:16.0/255.0 green:16.0/255.0 blue:16.0/255.0 alpha:0.2],
      UITextAttributeTextShadowColor,
      [NSValue valueWithUIOffset:UIOffsetMake(0, -1)],
      UITextAttributeTextShadowOffset,
      [UIFont fontWithName:@"Avenir" size:20.0],
      UITextAttributeFont,
      nil]];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:16.0/255.0 green:16.0/255.0 blue:16.0/255.0 alpha:1.0], NSForegroundColorAttributeName,nil]];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    ConnectFacebookViewController *connectVC=[[ConnectFacebookViewController alloc]init];
    LoginFirstTimeViewController *signupVC=[[LoginFirstTimeViewController alloc]init];
    
    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    
    EarnPointViewController *earnPointViewController=[[EarnPointViewController alloc]initWithNibName:@"EarnPointNew" bundle:nil];
    earnPointNavController=[[UINavigationController alloc]initWithRootViewController:earnPointViewController];
    
    ReedemViewController *redeemViewController=[[ReedemViewController alloc]initWithNibName:@"ReedemViewController" bundle:nil];
    redeemNavController=[[UINavigationController alloc]initWithRootViewController:redeemViewController];
    
    BrowseViewController *browseViewController=[[BrowseViewController alloc]initWithNibName:@"BrowseDetailVC" bundle:nil];
    browseNavController=[[UINavigationController alloc]initWithRootViewController:browseViewController];
    
    AccountNavigationViewController *reserveViewController=[[AccountNavigationViewController alloc]initWithNibName:@"AccountNavigationViewController" bundle:nil];
    reserveNavController=[[UINavigationController alloc]initWithRootViewController:reserveViewController];
    
    SpinWheelViewController *spinViewController=[[SpinWheelViewController alloc]initWithNibName:@"SpinWheelViewController" bundle:nil];
    spinWheelNavController=[[UINavigationController alloc]initWithRootViewController:spinViewController];
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[earnPointNavController, redeemNavController,browseNavController,reserveNavController,spinWheelNavController];
    self.tabBarController.selectedIndex=0;
    
    self.window.rootViewController=signupVC;
    
    dbClass=[[DBConnectionClass alloc]init];
    
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor colorWithRed:246.0/255.0 green:31.0/255.0 blue:38.0/255.0 alpha:1.0]];
    [self.tabBarController.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.window makeKeyAndVisible];
    
    [self initDatabase];
    
    if([dbClass connected])
    {
    
    GetServerCurrentTimeWebService *getService=[[GetServerCurrentTimeWebService alloc] init];
    
    [getService callCurrentServerTimeService];
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"tanfirstLaunch"])
    {
        if (activityTimer) {
            [activityTimer invalidate];
        }
        
    }
    InitialActivityLogWebService *initialServiceObj=[[InitialActivityLogWebService alloc]init];
    if ([self.dbClass fetchLastUpdateTime].count) {
        
        [initialServiceObj callManualSync];
        [self callActivityStatusService];
    }
    }
    else{
        [dbClass showNetworkALert];
    }
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        [standardUserDefaults setObject:@"" forKey:@"messagesynctime"];
        //[standardUserDefaults setBool:NO forKey:@"intaStatus"];
        [standardUserDefaults synchronize];
    }
    
    
    //SetTab Bar  Images
    UITabBar *tabBar = tabBarController.tabBar;
    UITabBarItem *item0 = [tabBar.items objectAtIndex:0];
    UITabBarItem *item1 = [tabBar.items objectAtIndex:1];
    UITabBarItem *item2 = [tabBar.items objectAtIndex:2];
    UITabBarItem *item3 = [tabBar.items objectAtIndex:3];
    UITabBarItem *item4 = [tabBar.items objectAtIndex:4];
    
    [item0 setFinishedSelectedImage:[UIImage imageNamed:@"sp_earnIcon"]
        withFinishedUnselectedImage:[UIImage imageNamed:@"sp_earnIcon"]];
    
    [item1 setFinishedSelectedImage:[UIImage imageNamed:@"st_redeem"]
        withFinishedUnselectedImage:[UIImage imageNamed:@"st_redeem"]];
    
    [item2 setFinishedSelectedImage:[UIImage imageNamed:@"st_deal"]
        withFinishedUnselectedImage:[UIImage imageNamed:@"st_deal"]];
    
    [item3 setFinishedSelectedImage:[UIImage imageNamed:@"st_account"]
        withFinishedUnselectedImage:[UIImage imageNamed:@"st_account"]];
    
    [item4 setFinishedSelectedImage:[UIImage imageNamed:@"st_spin"]
        withFinishedUnselectedImage:[UIImage imageNamed:@"st_spin"]];
    
    // Change the tabbar's background and selection image through the appearance proxy
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"sp_tabbg"]];
    
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"zen_tabsel"]];
    
    [tabBarController.tabBar setClipsToBounds:YES];
    
    // Text appearance values for the tab in normal state
    NSDictionary *normalState = @{
                                  UITextAttributeTextColor : [UIColor whiteColor],
                                  UITextAttributeTextShadowColor: [UIColor clearColor],
                                  UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0.0, 1.0)],
                                  UITextAttributeFont:[UIFont fontWithName:@"Avenir-Medium" size:11]
                                  };
    
    // Text appearance values for the tab in highlighted state
    NSDictionary *selectedState = @{
                                    UITextAttributeTextColor : [UIColor whiteColor],
                                    UITextAttributeTextShadowColor: [UIColor clearColor],
                                    UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0.0, 1.0)],
                                    UITextAttributeFont:[UIFont fontWithName:@"Avenir-Medium" size:11]
                                    };
    
    [[UITabBarItem appearance] setTitleTextAttributes:normalState forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:selectedState forState:UIControlStateHighlighted];
    tabBarController.selectedIndex=0;
    
    
    
    if([standardUserDefaults boolForKey:@"intaStatus"]){
        
        NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"https://api.instagram.com/v1/users/%@/media/recent/?access_token=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"instagramid"],[[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"]] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        pointDetailConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
        
        NSLog(@"%@",theRequest);
        if (pointDetailConnection) {
            // Inform the user that the download failed.
            pointDataArray=[[NSMutableData alloc ]init];
            
            //  [recievedData writeToFile:path atomically:YES];
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Congratulations!" message:[NSString stringWithFormat:@"You have successfully shared a post to Instagram. You currently have %@ points pending. Our team will review your post shortly, once approved your %@ points willbe awarded to your Account. ",[(SocialWeightDetailDBClass *)[[tanningDelegate.dbClass fetchSocialPointWeight] objectAtIndex:0]InstagramPoints],[(SocialWeightDetailDBClass *)[[tanningDelegate.dbClass fetchSocialPointWeight] objectAtIndex:0]InstagramPoints]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [alert show];
            
            
            
            NSLog(@"JSON download youtube");
        }
        else {
            NSLog(@"JSON download fail");
        }
        
        instagramShareStatus=NO;
        
        [standardUserDefaults setBool:NO forKey:@"intaStatus"];
        [standardUserDefaults synchronize];
    }
    
    return YES;
}

-(void)initDatabase{
    
    //Creating database
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    NSString* databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Tanningloft.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    NSLog(@"filemgr %@",databasePath);
    
    if ([filemgr fileExistsAtPath: databasePath ] == NO)
    {
		const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS userdetail (userid TEXT PRIMARY KEY, firstName TEXT, lastName TEXT, deviceTokenNo TEXT, memberSince TEXT, email TEXT, isActive TEXT)";
            
            
            
            if (sqlite3_exec(appreaderDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                NSLog(@"Failed to log");
                
                // status.text = @"Failed to create table";
            }
            else{
                NSLog(@"userdetail table created");
            }
            
            
            sqlite3_close(appreaderDB);
            
        } else {
            // status.text = @"Failed to open/create database";
        }
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS purchasedetail (ArticleId TEXT , ArticleTitle TEXT, Amount TEXT, AddedDate TEXT,ExpireDate TEXT, ArticleDesc TEXT, type TEXT, redeemedDate TEXT, isRedeemed TEXT)";
            
            
            
            if (sqlite3_exec(appreaderDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                NSLog(@"Failed to log");
                
                // status.text = @"Failed to create table";
            }
            else{
                NSLog(@"purchasedetail table created");
            }
            
            
            sqlite3_close(appreaderDB);
            
        } else {
            // status.text = @"Failed to open/create database";
        }
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS socialPointsDetail (facbookPoint TEXT , twitterPoint TEXT, istagramPoint TEXT,fourSquarePoint TEXT, spinningWheel TEXT)";
            
            
            
            if (sqlite3_exec(appreaderDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                NSLog(@"Failed to log");
                
                // status.text = @"Failed to create table";
            }
            else{
                NSLog(@"socialPointsDetail table created");
            }
            
            
            sqlite3_close(appreaderDB);
            
        } else {
            // status.text = @"Failed to open/create database";
        }
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            char *errMsg;
            
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS PackageDetailTable (pkgId TEXT,pkgTitle TEXT , pkgDescription TEXT, pkgImagePath TEXT,pkgPoints TEXT, pkgAmount TEXT, AddedDate TEXT, isActive TEXT,pkgType TEXT, imgname TEXT,pkgDurationType TEXT)";
            
            
            
            if (sqlite3_exec(appreaderDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                NSLog(@"PackageDetailTable Failed to log %s",errMsg);
                
                // status.text = @"Failed to create table";
            }
            else{
                NSLog(@"PackageDetailTable table created");
            }
            
            
            sqlite3_close(appreaderDB);
            
        }
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            char *errMsg;
            
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS ActivityLog (activityId TEXT,username TEXT , socialtype TEXT, activitytype TEXT,activitytitle TEXT, activitydate TEXT, expiredate TEXT, amount TEXT,point TEXT, status TEXT)";
            
            
            
            if (sqlite3_exec(appreaderDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                NSLog(@"ActivityLog Failed to log %s",errMsg);
                
                // status.text = @"Failed to create table";
            }
            else{
                NSLog(@"ActivityLog table created");
            }
            
            
            sqlite3_close(appreaderDB);
            
        }
        else {
            // status.text = @"Failed to open/create database";
        }
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            char *errMsg;
            
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS SocialPointWeight (FacebookPoints TEXT,TwitterPoints TEXT , InstagramPoints TEXT, FourSquarePoints TEXT,UpdatedDate TEXT)";
            
            
            
            if (sqlite3_exec(appreaderDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                NSLog(@"SocialWeight Failed to log %s",errMsg);
                
                // status.text = @"Failed to create table";
            }
            else{
                NSLog(@"SocialWeight table created");
            }
            
            
            sqlite3_close(appreaderDB);
            
        }
        else {
            // status.text = @"Failed to open/create database";
        }
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            char *errMsg;
            
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS SocialShareDetails (Id TEXT,Title TEXT , Description TEXT, ImgPath TEXT,AddedDate TEXT, Hyperlink TEXT,imgname TEXT, isActive TEXT)";
            
            
            
            if (sqlite3_exec(appreaderDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                NSLog(@"SocialShareDetails Failed to log %s",errMsg);
                
                // status.text = @"Failed to create table";
            }
            else{
                NSLog(@"SocialShareDetails table created");
            }
            
            
            sqlite3_close(appreaderDB);
            
        }
        else {
            // status.text = @"Failed to open/create database";
        }
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            char *errMsg;
            
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS SyncDetails (lasttime TEXT)";
            
            if (sqlite3_exec(appreaderDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                NSLog(@"SyncDetails Failed to log %s",errMsg);
                
                // status.text = @"Failed to create table";
            }
            else{
                NSLog(@"SyncDetails table created");
            }
            
            
            sqlite3_close(appreaderDB);
            
        }
        else {
            // status.text = @"Failed to open/create database";
        }
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            char *errMsg;
            
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS message (id TEXT, title TEXT, description TEXT, type TEXT, date TEXT, voucher_id TEXT, voucher_amount TEXT, voucher_point TEXT, voucher_expiry TEXT, isActive TEXT)";
            
            if (sqlite3_exec(appreaderDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                NSLog(@"message Failed to log %s",errMsg);
                
                // status.text = @"Failed to create table";
            }
            else{
                NSLog(@"message table created");
            }
            
            
            sqlite3_close(appreaderDB);
            
        }
        else {
            // status.text = @"Failed to open/create database";
        }
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            char *errMsg;
            
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS tbl_socialpost (socialid TEXT, title TEXT, description TEXT, imgpath TEXT, addeddate TEXT, link TEXT, imgname TEXT, isactive TEXT, pointvalue TEXT, isvalidforcoupon TEXT, couponcode TEXT, savingper TEXT, tags TEXT, amount TEXT, type TEXT, subtype TEXT, extra TEXT, colorcode TEXT, isfeatured TEXT, writername TEXT, expiredate TEXT, logoimagename TEXT, logoimagepath TEXT)";
            
            if (sqlite3_exec(appreaderDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                NSLog(@"tbl_socialpost Failed to log %s",errMsg);
                
                // status.text = @"Failed to create table";
            }
            else{
                NSLog(@"tbl_socialpost table created");
            }
            
            sqlite3_close(appreaderDB);
        }
        else {
            // status.text = @"Failed to open/create database";
        }
        
        
    }
    else{
        
        NSLog(@"Error file manager");
    }
    
    
    //End of database
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDir = [paths objectAtIndex:0];
    
    NSError *error;
    
    NSString *dataPath = [documentsDir stringByAppendingPathComponent:@"upload"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
        
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error];
    
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"tanfirstLaunch"])
    {
        if (activityTimer) {
            [activityTimer invalidate];
        }
        // [self callActivityStatusService];
    }
    
    InitialActivityLogWebService *initialServiceObj=[[InitialActivityLogWebService alloc]init];
    if ([self.dbClass fetchLastUpdateTime].count) {
        
        [initialServiceObj callManualSync];
        [self callActivityStatusService];
    }
    
    
    UINavigationController *navcon = (UINavigationController*)tabBarController.selectedViewController;
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    
    if([standardUserDefaults boolForKey:@"intaStatus"]){
        
        NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"https://api.instagram.com/v1/users/%@/media/recent/?access_token=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"instagramid"],[[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"]] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        pointDetailConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
        
        NSLog(@"%@",theRequest);
        if (pointDetailConnection) {
            // Inform the user that the download failed.
            pointDataArray=[[NSMutableData alloc ]init];
            
            //  [recievedData writeToFile:path atomically:YES];
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Congratulations!" message:[NSString stringWithFormat:@"You have successfully shared a post to Instagram. You currently have %@ points pending. Our team will review your post shortly, once approved your %@ points will be awarded to your Account. ",[(SocialWeightDetailDBClass *)[[tanningDelegate.dbClass fetchSocialPointWeight] objectAtIndex:0]InstagramPoints],[(SocialWeightDetailDBClass *)[[tanningDelegate.dbClass fetchSocialPointWeight] objectAtIndex:0]InstagramPoints]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [alert show];
            
            
            
            NSLog(@"JSON download youtube");
        }
        else {
            NSLog(@"JSON download fail");
        }
        [standardUserDefaults setBool:NO forKey:@"intaStatus"];
        [standardUserDefaults synchronize];
    }
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [activityTimer invalidate];
}

- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
    switch (state) {
        case FBSessionStateOpen: {
            
            if ([self.viewStatus isEqualToString:@"Connect"]) {
                
                // [self switchRootView];
                
                dbClass=[[DBConnectionClass alloc]init];
                
                if ([[NSUserDefaults standardUserDefaults] boolForKey:@"tanfirstLaunch"]) {
                    
                    if (FBSession.activeSession.isOpen) {
                        [[FBRequest requestForMe] startWithCompletionHandler:
                         ^(FBRequestConnection *connection,
                           NSDictionary<FBGraphUser> *user,
                           NSError *error) {
                             if (!error) {
                                 
                                 UserDetailDBClass *userDBClass=[[UserDetailDBClass alloc]init];
                                 
                                 userDBClass.userId=[user objectForKey:@"email"];
                                 userDBClass.firstname=user.first_name;
                                 userDBClass.lastname=user.last_name;
                                 userDBClass.memberSince=@"";
                                 userDBClass.tokenNo=@"";
                                 userDBClass.email=[user objectForKey:@"email"];
                                 userDBClass.isActive=@"1";
                                 
                                 [tanningDelegate.dbClass insertUserDetail:userDBClass];
                                 [tanningDelegate switchRootView];
                                 
                                 
                                 //user.username
                                 
                             }
                             
                             NSLog(@"user mexican %@",user);
                         }];
                    }
                    
                }
                
                
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"tanfirstLaunch"];
                
            }
            else{
                
                
                FacebookArticleViewController *fbArticle=[[FacebookArticleViewController alloc]init];
                
                // [self.earnPointNavController pushViewController:fbArticle animated:YES];
                
            }
        }
            break;
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed:
            
            break;
        default:
            break;
    }
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:error.localizedDescription
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}



- (void)openSession
{
    
    [FBSession.activeSession closeAndClearTokenInformation];
    
    NSArray *permissions = [NSArray arrayWithObjects:@"email, publish_actions, publish_stream", nil];
    
#ifdef IOS_NEWER_OR_EQUAL_TO_6
    permissions = nil;
    permissions = [NSArray arrayWithObjects:@"email",nil];
#endif
    
    NSLog(@"\npermissions = %@", permissions);
    [FBSession openActiveSessionWithReadPermissions:permissions
                                       allowLoginUI:YES
                                  completionHandler:
     ^(FBSession *session,
       FBSessionState state, NSError *error) {
         if(error)
         {
             NSLog(@"Session error");
             
         }
         else
             [self sessionStateChanged:session state:state error:error];
     }];
    
}

-(void)fbResync
{
    ACAccountStore *accountStore;
    ACAccountType *accountTypeFB;
    if ((accountStore = [[ACAccountStore alloc] init]) && (accountTypeFB = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook] ) ){
        
        NSArray *fbAccounts = [accountStore accountsWithAccountType:accountTypeFB];
        id account;
        if (fbAccounts && [fbAccounts count] > 0 && (account = [fbAccounts objectAtIndex:0])){
            
            [accountStore renewCredentialsForAccount:account completion:^(ACAccountCredentialRenewResult renewResult, NSError *error) {
                //we don't actually need to inspect renewResult or error.
                if (error){
                    
                }
            }];
        }
    }
}

//Instagram Handling

// YOU NEED TO CAPTURE igAPPID:// schema
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [self.instagram handleOpenURL:url];
}


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    if (!([url.absoluteString rangeOfString:[NSString stringWithFormat:@"authorize#access_token="]].location==NSNotFound)) {
        return [self.instagram handleOpenURL:url];
    }
    else{
        
        return [FBSession.activeSession handleOpenURL:url];
    }
}

-(void)switchRootView{
    
    self.window.rootViewController = self.tabBarController;
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if(pointDetailConnection==connection){
        
        [pointDataArray setLength:0];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if(pointDetailConnection==connection){
        
        [pointDataArray appendData:data];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (connection==pointDetailConnection) {
        
        NSString *responseString = [[NSString alloc] initWithData:pointDataArray encoding:NSUTF8StringEncoding];
        // [responseData release];
        
        NSLog(@"responseString %@",responseString);
        
        NSError *error;
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSMutableDictionary *jsonDictionary = [parser objectWithString:responseString error:nil];
        
        NSArray *nodes = (NSArray*)[jsonDictionary objectForKey:@"data"];
        
        NSLog(@"NSDictionary link %@",[[nodes objectAtIndex:0] objectForKey:@"link"]);
        
        float x = arc4random_uniform(10000000);
        
        NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@receivePost.php?userid=%@&username=%@&socialtype=I&sharedurl=%@&bonuspoint=%@&postid=%f",tanningDelegate.hostString,[dbClass getUserName],[dbClass getFirstName],[[nodes objectAtIndex:0] objectForKey:@"link"],[(SocialWeightDetailDBClass *)[[self.dbClass fetchSocialPointWeight] objectAtIndex:0]InstagramPoints],x] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        
        shareDetailConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
        
        if (shareDetailConnection) {
            // Inform the user that the download failed.
            shareDataArray=[[NSMutableData alloc ]init];
            
            //  [recievedData writeToFile:path atomically:YES];
            NSLog(@"JSON download youtube");
            
            ActivityLogDBClass *activityClass=[[ActivityLogDBClass alloc]init];
            activityClass.activityId=[NSString stringWithFormat:@"%f",x];
            activityClass.activitytitle=@"Instagram photo";
            activityClass.username=[dbClass getUserName];
            activityClass.socialtype=@"I";
            activityClass.activitytype=@"S";
            activityClass.activitydate=[NSString stringWithFormat:@"%@",[dbClass FormattedDateFromDate:[NSDate date]]];
            activityClass.expiredate=[NSString stringWithFormat:@"%@",[dbClass FormattedDateFromDate:[NSDate date]]];
            activityClass.amount=@"0";
            activityClass.point=[(SocialWeightDetailDBClass *)[[tanningDelegate.dbClass fetchSocialPointWeight] objectAtIndex:0]InstagramPoints];
            activityClass.status=@"P";
            [tanningDelegate.dbClass insertActivityData:activityClass];
            
            //Add activity to server
            
            NSURLRequest *activityRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@ActivityLog.php?activityId=%f&userid=%@&firstname=%@&lastname=%@&socialtype=I&activitytype=S&activitytitle=Instagram photo&activitydate=%@&expiredate=%@&amount=0&redeempoint=%@&status=P",tanningDelegate.hostString,x,[dbClass getUserName],[dbClass getFirstName],[dbClass getLastName],[dbClass FormattedDateFromDate:[NSDate date]],[dbClass FormattedDateFromDate:[NSDate date]],[(SocialWeightDetailDBClass *)[[tanningDelegate.dbClass fetchSocialPointWeight] objectAtIndex:0]InstagramPoints]] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
            NSURLConnection *activityDetailConnection = [[NSURLConnection alloc] initWithRequest:activityRequest delegate:self];
            
            NSLog(@"%@",[[NSString stringWithFormat:@"%@ActivityLog.php?activityId=%f&userid=%@&firstname=%@&lastname=%@&socialtype=I&activitytype=S&activitytitle=Instagram photo&activitydate=%@&expiredate=%@&amount=0&redeempoint=10&status=P",tanningDelegate.hostString,x,[dbClass getUserName],[dbClass getFirstName],[dbClass getLastName],[NSDate date],[NSDate date]] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]);
        }
        else {
            NSLog(@"JSON download fail");
        }
        
        for (NSDictionary *node in nodes){
            
            NSLog(@"NSDictionary link %@", [node objectForKey:@"link"]);
            
        }
        
    }
    
}

-(void)callActivityStatusService{
    activityService=[[ActivityStatusService alloc]init];
    
    [activityService triggerActivityStatusService];
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
	NSLog(@"My token is: %@", deviceToken);
    
    NSString *newString = [[NSString stringWithFormat:@"%@",deviceToken] stringByReplacingOccurrencesOfString:@" " withString:@""];
    newString = [[NSString stringWithFormat:@"%@",newString] stringByReplacingOccurrencesOfString:@"<" withString:@""];
    newString = [[NSString stringWithFormat:@"%@",newString] stringByReplacingOccurrencesOfString:@">" withString:@""];
    [self.dbClass insertTokenDetail:newString];
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
	NSLog(@"Failed to get token, error: %@", error);
}

- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo{
    NSLog(@"%@",userInfo);
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Notification !" message:[[userInfo valueForKey:@"aps"] valueForKey:@"alert"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    
    [self callActivityStatusService];
}



@end
