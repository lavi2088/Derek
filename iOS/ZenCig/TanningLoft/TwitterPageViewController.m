//
//  TwitterPageViewController.m
//  TanningLoft
//
//  Created by Lavi on 25/05/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "TwitterPageViewController.h"
#import "TwitterTblVwCellViewController.h"
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>
#import "AppDelegate.h"
#import "Constant.h"
#import "ActivityLogDBClass.h"
#import "SocialWeightDetailDBClass.h"
#import <QuartzCore/QuartzCore.h>
#import "FHSTwitterEngine.h"

ACAccountStore *accountStore;
ACAccountType *accountType;
ACAccount *twitterAccount;
NSInteger currentIndex=-1;
@interface TwitterPageViewController ()<FHSTwitterEngineAccessTokenDelegate>
{
    NSString *latestTweetURL;
    NSInteger cauroselCurrentIndex;
}

@end

@implementation TwitterPageViewController
@synthesize userNameLbl,tweetBtn,TwitterTblVwOfArticles,articleDesc,articleTite,pictureNameArray,userProfileImage;
@synthesize dataSource,carousel,titleLbl,descLbl,shareBtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
- (void)getTwitterAccountInformation
{
    accountStore = [[ACAccountStore alloc] init];
    accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
        if(granted) {
            NSArray *accountsArray = [accountStore accountsWithAccountType:accountType];
            
            if ([accountsArray count] > 0) {
                twitterAccount = [accountsArray objectAtIndex:0];
                self.userNameLbl.text=twitterAccount.username;
                NSLog(@"username%@",twitterAccount.username);
                NSLog(@"desc....%@",twitterAccount.accountType);
                [self getInfo];
              
                
                
            }
        }
    }];
}

- (void) getInfo
{
    // Request access to the Twitter accounts
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error){
        if (granted) {
            NSArray *accounts = [accountStore accountsWithAccountType:accountType];
            // Check if the users has setup at least one Twitter account
            if (accounts.count > 0)
            {
                ACAccount *twitterAccount = [accounts objectAtIndex:0];
                // Creating a request to get the info about a user on Twitter
                SLRequest *twitterInfoRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:[NSURL URLWithString:@"https://api.twitter.com/1.1/users/show.json"] parameters:[NSDictionary dictionaryWithObject: self.userNameLbl.text forKey:@"screen_name"]];
                [twitterInfoRequest setAccount:twitterAccount];
                // Making the request
                [twitterInfoRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // Check if we reached the reate limit
                        if ([urlResponse statusCode] == 429) {
                            NSLog(@"Rate limit reached");
                            return;
                        }
                        // Check if there was an error
                        if (error) {
                            NSLog(@"Error: %@", error.localizedDescription);
                            return;
                        }
                        // Check if there is some response data
                        if (responseData) {
                            NSError *error = nil;
                            NSArray *TWData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
                            // Filter the preferred data
                            NSString *screen_name = [(NSDictionary *)TWData objectForKey:@"screen_name"];
                             NSLog(@"screen_name %@",screen_name);
                            NSString *name = [(NSDictionary *)TWData objectForKey:@"name"];
                            int followers = [[(NSDictionary *)TWData objectForKey:@"followers_count"] integerValue];
                            int following = [[(NSDictionary *)TWData objectForKey:@"friends_count"] integerValue];
                            int tweets = [[(NSDictionary *)TWData objectForKey:@"statuses_count"] integerValue];
                            NSString *profileImageStringURL = [(NSDictionary *)TWData objectForKey:@"profile_image_url_https"];
                            NSString *bannerImageStringURL =[(NSDictionary *)TWData objectForKey:@"profile_banner_url"];
                            // Update the interface with the loaded data
                            //nameLabel.text = name;
//                            usernameLabel.text= [NSString stringWithFormat:@"@%@",screen_name];
//                            tweetsLabel.text = [NSString stringWithFormat:@"%i", tweets];
//                            followingLabel.text= [NSString stringWithFormat:@"%i", following];
//                            followersLabel.text = [NSString stringWithFormat:@"%i", followers];
                            NSString *lastTweet = [[(NSDictionary *)TWData objectForKey:@"status"] objectForKey:@"text"];
                            
                            NSLog(@"latest tweet %@",[[[[[(NSDictionary *)TWData objectForKey:@"status"]objectForKey:@"entities"] objectForKey:@"media"] objectAtIndex:0] objectForKey:@"url"]);
                           // lastTweetTextView.text= lastTweet;
                            // Get the profile image in the original resolution
                            profileImageStringURL = [profileImageStringURL stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
                            [self getProfileImageForURLString:profileImageStringURL];
                            // Get the banner image, if the user has one
//                            if (bannerImageStringURL) {
//                                NSString *bannerURLString = [NSString stringWithFormat:@"%@/mobile_retina", bannerImageStringURL];
//                                [self getBannerImageForURLString:bannerURLString];
//                            } else {
//                                bannerImageView.backgroundColor = [UIColor underPageBackgroundColor];
//                            }
                        }
                    });
                }];
            }
        } else {
            NSLog(@"No access granted");
        }
    }];
}
- (void) getProfileImageForURLString:(NSString *)urlString;
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    userProfileImage.image = [UIImage imageWithData:data];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[FHSTwitterEngine sharedEngine]permanentlySetConsumerKey:@"Ut2Vsenrg9dxW28vRNXpKA" andSecret:@"IPw0IJpeOoQRUxgvIv8ffCdeGbifJ0zbCka2u3Rj4"];
    [[FHSTwitterEngine sharedEngine]setDelegate:self];
    
    [self getTwitterAccountInformation];
    
    self.pictureNameArray=[[NSMutableArray alloc]init];
    [self.pictureNameArray addObject:@"bed1"];
    [self.pictureNameArray addObject:@"bed2"];
    [self.pictureNameArray addObject:@"bed3"];
    [self.pictureNameArray addObject:@"bed2"];
    [self.pictureNameArray addObject:@"bed3"];
    
    
    self.articleTite=[[NSMutableArray alloc]init];
    [self.articleTite addObject:@"ERGOLIN ADVANTAGE 400 MAXIMUM EXPOSURE 15 MINUTES"];
    [self.articleTite addObject:@"SUNDASH 252 RADIUS EXPOSURE 12 MINUTES"];
    [self.articleTite addObject:@"ERGOLIN ADVANTAGE 400 MAXIMUM EXPOSURE 12 MINUTES"];
    
    self.articleDesc=[[NSMutableArray alloc]init];
    [self.articleDesc addObject:@"The advantage 400 ensures the highest tanning results with a perfect combination of 3 VIT Max high-pressure facials, 40 Turbo Power tanning lamps and a reflex neck tanner. In addition, its comfort Colling ventilation, with cool air coming from facial and body zone outlets, is infinitely variable and keeps clients feeling fresh durning the tanning session."];
    [self.articleDesc addObject:@"TheSundash 252 Radius is equipped with 52, 2-meter SHO-RUVA tanning lamps.It delivers a beautifully even, full-body tan in a 12- minute exposure schedule for those tanners who are on the go. With an open aair tanning environment the Sundash offers over 6.5 feet of vertical tanning power."];
    [self.articleDesc addObject:@"The advantage 400 ensures the highest tanning results with a perfect combination of 3 VIT Max high-pressure facials, 40 Turbo Power tanning lamps and a reflex neck tanner. In addition, its comfort Colling ventilation, with cool air coming from facial and body zone outlets, is infinitely variable and keeps clients feeling fresh durning the tanning session."];
    
    [super viewDidLoad];
    self.title = @"Re-Tweet & Earn Points";
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
//                                              initWithTitle:@"Logout"
//                                              style:UIBarButtonItemStyleBordered
//                                              target:self
//                                              action:@selector(logoutButtonWasPressed:)];
    dbClass=[[DBConnectionClass alloc]init];
    
    socialShareDetails=[[NSMutableArray alloc]init];
    socialShareDetails=[tanningDelegate.dbClass fetchSocialDetail];
    
    //Carousel config
    
    cauroselCurrentIndex=0;
    
    //configure carousel
    carousel.type = iCarouselTypeCoverFlow2;
    //navItem.title = @"CoverFlow2";
    
    self.carousel.clipsToBounds = YES; //This is main point
    
    //[self toggleOrientation];
    
    self.carousel.vertical=NO;
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;   // iOS 7 specific
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [[FHSTwitterEngine sharedEngine]loadAccessToken];
    NSString *username = [[FHSTwitterEngine sharedEngine]loggedInUsername];// self.engine.loggedInUsername;
    
    if (username.length > 0) {
       // _loggedInUserLabel.text = [NSString stringWithFormat:@"Logged in as %@",username];
    } else {
       // _loggedInUserLabel.text = @"You are not logged in.";
    }
    
    [carousel reloadData];
    
    [shareBtn setTitle:[NSString stringWithFormat:@"Tweet for %@ points",[(SocialWeightDetailDBClass *)[[tanningDelegate.dbClass fetchSocialPointWeight] objectAtIndex:0]TwitterPoints]] forState:UIControlStateNormal];
    
}

-(void)viewDidAppear:(BOOL)animated{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)TweetBtnCliked:(id)sender;
{
    UIButton *tempBtn=(UIButton *)sender;
    currentIndex=cauroselCurrentIndex;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:cauroselCurrentIndex inSection:0];
    TwitterTblVwCellViewController *cell = (TwitterTblVwCellViewController *)[self.TwitterTblVwOfArticles cellForRowAtIndexPath:indexPath];
    
    PackageDetailDBClass *pkgObj=[[PackageDetailDBClass alloc]init];
    pkgObj=[socialShareDetails objectAtIndex:cauroselCurrentIndex];
    
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        SLComposeViewController *sheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        SLComposeViewControllerCompletionHandler completionBlock = ^(SLComposeViewControllerResult result){
            if (result == SLComposeViewControllerResultCancelled) {
                NSLog(@"Cancelled");
            } else {
                NSLog(@"Done %d",result);
                [self getTweetURLAfterTweet];
            }
            
            [sheet dismissViewControllerAnimated:YES completion:Nil];
        };
        sheet.completionHandler = completionBlock;
        
        //Adding the Text to the post value from iOS
        [sheet setInitialText:pkgObj.pkgTitle];
        UIImage *image = [self imageWithView:cell.shareView];
        [sheet addImage:image];
        [sheet addURL:[NSURL URLWithString:pkgObj.pkgLink]];
        [self presentViewController:sheet animated:YES completion:Nil];
    }
    
}


- (void)storeAccessToken:(NSString *)accessToken {
    [[NSUserDefaults standardUserDefaults]setObject:accessToken forKey:@"SavedAccessHTTPBody"];
}

- (NSString *)loadAccessToken {
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"SavedAccessHTTPBody"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 260;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [socialShareDetails count];    //count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"Cell";
    
    TwitterTblVwCellViewController *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TwitterTblVwCellViewController" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    PackageDetailDBClass *pkgObj=[[PackageDetailDBClass alloc]init];
    pkgObj=[socialShareDetails objectAtIndex:indexPath.row];
    
    //cell.imgVw.image=[UIImage imageNamed:[pictureNameArray objectAtIndex:indexPath.row]];
    //cell.lbl1.text=[NSString stringWithFormat:@"Level %d",indexPath.row+1];
    cell.title.text=pkgObj.pkgTitle ;
    cell.desc.text=pkgObj.pkgDescription ;
    cell.tweetBtn.tag=indexPath.row;
    [cell.tweetBtn addTarget:self action:@selector(TweetBtnCliked:) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath=[NSString stringWithFormat:@"%@/upload/%@",docDir,pkgObj.imgName];
    cell.imgVw.image=[UIImage imageWithContentsOfFile:filePath];
    
    return cell;
}

- (void)getLatestTweeUrlTimeLine {
    ACAccountStore *account = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [account
                                  accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [account requestAccessToAccountsWithType:accountType
                                     options:nil completion:^(BOOL granted, NSError *error)
     {
         if (granted == YES)
         {
             NSArray *arrayOfAccounts = [account
                                         accountsWithAccountType:accountType];
             
             if ([arrayOfAccounts count] > 0)
             {
                 ACAccount *twitterAccount = [arrayOfAccounts lastObject];
                 
                 NSURL *requestURL = [NSURL URLWithString:@"http://api.twitter.com/1/statuses/home_timeline.json"];
                 
                 NSMutableDictionary *parameters =
                 [[NSMutableDictionary alloc] init];
                 [parameters setObject:@"1" forKey:@"count"];
                 [parameters setObject:@"0" forKey:@"include_entities"];
                 
                 SLRequest *postRequest = [SLRequest
                                           requestForServiceType:SLServiceTypeTwitter
                                           requestMethod:SLRequestMethodGET
                                           URL:requestURL parameters:parameters];
                 
                 postRequest.account = twitterAccount;
                 
                 [postRequest performRequestWithHandler:
                  ^(NSData *responseData, NSHTTPURLResponse
                    *urlResponse, NSError *error)
                  {
                      self.dataSource = [NSJSONSerialization
                                         JSONObjectWithData:responseData
                                         options:NSJSONReadingMutableLeaves
                                         error:&error];
                      
                      if (self.dataSource.count != 0) {
                          dispatch_async(dispatch_get_main_queue(), ^{
                             // [self.tweetTableView reloadData];
                              
                              NSLog(@"Result $$$$ %@",dataSource[0]);
                              
                              NSDictionary *tweet = dataSource[0];
                              
                              NSString *tweetURL =[NSString stringWithFormat:@"https://twitter.com/%@/status/%@",twitterAccount.username,tweet[@"id"]] ;
                              
                              [self sendTweetdetailToDashboard:tweetURL];
                              
                          });
                      }
                  }];
             }
         } else {
             // Handle failure to get account access
         }
     }];
}

-(void)sendTweetdetailToDashboard:(NSString *)tweeturl{
    
    float x = arc4random_uniform(10000000);
    
    PackageDetailDBClass *pkgObj=[[PackageDetailDBClass alloc]init];
    pkgObj=[socialShareDetails objectAtIndex:currentIndex];

    
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@receivePost.php?userid=%@&username=%@&socialtype=T&sharedurl=%@&bonuspoint=%@&postid=%f",tanningDelegate.hostString,[dbClass getUserName],self.userNameLbl.text,tweeturl,[(SocialWeightDetailDBClass *)[[tanningDelegate.dbClass fetchSocialPointWeight] objectAtIndex:0]TwitterPoints],x] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    shareDetailConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if (shareDetailConnection) {
        // Inform the user that the download failed.
        shareDataArray=[[NSMutableData alloc ]init];
        
        //  [recievedData writeToFile:path atomically:YES];
        NSLog(@"JSON download youtube");
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Congratulations!" message:[NSString stringWithFormat:@"You have successfully shared a tweet to Twitter. You currently have %@ points pending.Our team will review your post shortly, once approved your %@ points will be awarded to your Account. ",[(SocialWeightDetailDBClass *)[[tanningDelegate.dbClass fetchSocialPointWeight] objectAtIndex:0]TwitterPoints],[(SocialWeightDetailDBClass *)[[tanningDelegate.dbClass fetchSocialPointWeight] objectAtIndex:0]TwitterPoints]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        
        ActivityLogDBClass *activityClass=[[ActivityLogDBClass alloc]init];
        activityClass.activityId=[NSString stringWithFormat:@"%f",x];
        activityClass.activitytitle=@"Twitter post";
        activityClass.username=[dbClass getUserName];
        activityClass.socialtype=@"T";
        activityClass.activitytype=@"S";
        activityClass.activitydate=[NSString stringWithFormat:@"%@",[tanningDelegate.dbClass FormattedDateFromDate:[NSDate date]]];
        activityClass.expiredate=[NSString stringWithFormat:@"%@",[tanningDelegate.dbClass FormattedDateFromDate:[NSDate date]]];
        activityClass.amount=@"0";
        activityClass.point=[(SocialWeightDetailDBClass *)[[tanningDelegate.dbClass fetchSocialPointWeight] objectAtIndex:0]TwitterPoints];
        activityClass.status=@"P";
        [tanningDelegate.dbClass insertActivityData:activityClass];
        
      
        //Add activity to server
        
        NSURLRequest *activityRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@ActivityLog.php?activityId=%f&userid=%@&firstname=%@&lastname=%@&socialtype=T&activitytype=S&activitytitle=Twitter Post&activitydate=%@&expiredate=%@&amount=0&redeempoint=%@&status=P",tanningDelegate.hostString,x,[tanningDelegate.dbClass getUserName],[tanningDelegate.dbClass getFirstName],[tanningDelegate.dbClass getLastName],[tanningDelegate.dbClass FormattedDateFromDate:[NSDate date]],[tanningDelegate.dbClass FormattedDateFromDate:[NSDate date]],[(SocialWeightDetailDBClass *)[[tanningDelegate.dbClass fetchSocialPointWeight] objectAtIndex:0]TwitterPoints]] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        NSURLConnection *activityDetailConnection = [[NSURLConnection alloc] initWithRequest:activityRequest delegate:self];
        
        NSLog(@"%@",[[NSString stringWithFormat:@"%@ActivityLog.php?activityId=%f&userid=%@&firstname=%@&lastname=%@&socialtype=T&activitytype=S&activitytitle=Twitter Post&activitydate=%@&expiredate=%@&amount=0&redeempoint=3&status=P",tanningDelegate.hostString,x,[tanningDelegate.dbClass getUserName],[tanningDelegate.dbClass getFirstName],[tanningDelegate.dbClass getLastName],[NSDate date],[NSDate date]] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]);
        
        if (activityDetailConnection) {
            [tanningDelegate.dbClass updateSocialShareStatus:@"0":pkgObj.pkgID];
            socialShareDetails=[[NSMutableArray alloc]init];
            socialShareDetails=[tanningDelegate.dbClass fetchSocialDetail];
            [TwitterTblVwOfArticles reloadData];
            [carousel reloadData];
        }
        
    }
    else {
        NSLog(@"JSON download fail");
    }
}

-(IBAction)backBtnClicked:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(UIImage *) imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}


- (void) getTweetURLAfterTweet
{
    // Request access to the Twitter accounts
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error){
        if (granted) {
            NSArray *accounts = [accountStore accountsWithAccountType:accountType];
            // Check if the users has setup at least one Twitter account
            if (accounts.count > 0)
            {
                ACAccount *twitterAccount = [accounts objectAtIndex:0];
                // Creating a request to get the info about a user on Twitter
                SLRequest *twitterInfoRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:[NSURL URLWithString:@"https://api.twitter.com/1.1/users/show.json"] parameters:[NSDictionary dictionaryWithObject: self.userNameLbl.text forKey:@"screen_name"]];
                [twitterInfoRequest setAccount:twitterAccount];
                // Making the request
                [twitterInfoRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // Check if we reached the reate limit
                        if ([urlResponse statusCode] == 429) {
                            NSLog(@"Rate limit reached");
                            return;
                        }
                        // Check if there was an error
                        if (error) {
                            NSLog(@"Error: %@", error.localizedDescription);
                            return;
                        }
                        // Check if there is some response data
                        if (responseData) {
                            NSError *error = nil;
                            NSArray *TWData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
                            // Filter the preferred data
                            NSString *screen_name = [(NSDictionary *)TWData objectForKey:@"screen_name"];
                            NSLog(@"screen_name %@",screen_name);
                            
                            NSLog(@"latest tweet %@",[[[[[(NSDictionary *)TWData objectForKey:@"status"]objectForKey:@"entities"] objectForKey:@"media"] objectAtIndex:0] objectForKey:@"url"]);
                            latestTweetURL=[[[[[(NSDictionary *)TWData objectForKey:@"status"]objectForKey:@"entities"] objectForKey:@"media"] objectAtIndex:0] objectForKey:@"url"];
                            
                            [self sendTweetdetailToDashboard:latestTweetURL];
                            
                        }
                    });
                }];
            }
        } else {
            NSLog(@"No access granted");
        }
    }];
}

#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [socialShareDetails count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    UIImageView *topBgImg;
    //create new view if no view is available for recycling
    if (view == nil)
    {
        
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320.0f, 245.0f)] ;
        ((UIImageView *)view).image = [UIImage imageNamed:@"reedempkg_bg"];
        view.contentMode = UIViewContentModeTop;
        
        topBgImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 292)];
        
        topBgImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 245)];
        
        topBgImg.image=[UIImage imageNamed:[NSString stringWithFormat:@"bed%d",index+1]];
        
        [view addSubview:topBgImg];
        
    }
    
    PackageDetailDBClass *pkgClass=[[PackageDetailDBClass alloc]init];
    pkgClass=[socialShareDetails objectAtIndex:index];
    
    titleLbl.text=pkgClass.pkgTitle;
    descLbl.text=pkgClass.pkgDescription;
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath=[NSString stringWithFormat:@"%@/upload/%@",docDir,pkgClass.imgName];
    topBgImg.image=[UIImage imageWithContentsOfFile:filePath];
    
    return view;
}

- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
    //note: placeholder views are only displayed on some carousels if wrapping is disabled
    return 5;
}

- (UIView *)carousel:(iCarousel *)carousel placeholderViewAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200.0f, 200.0f)] ;
        ((UIImageView *)view).image = [UIImage imageNamed:@"page.png"];
        view.contentMode = UIViewContentModeCenter;
        
        label = [[UILabel alloc] initWithFrame:view.bounds] ;
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentCenter;
        label.font = [label.font fontWithSize:50.0f];
        label.tag = 1;
        [view addSubview:label];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    label.text = (index == 0)? @"[": @"]";
    
    return view;
}

- (CATransform3D)carousel:(iCarousel *)_carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    //implement 'flip3D' style carousel
    transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * carousel.itemWidth);
}

- (CGFloat)carousel:(iCarousel *)_carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            //normally you would hard-code this to YES or NO
            return YES;
        }
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
            return value * 1.05f;
        }
        case iCarouselOptionFadeMax:
        {
            if (carousel.type == iCarouselTypeCustom)
            {
                //set opacity based on distance from camera
                return 0.0f;
            }
            return value;
        }
        default:
        {
            return value;
        }
    }
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel{
    
    cauroselCurrentIndex= carousel.currentItemIndex;
    
    PackageDetailDBClass *pkgClass=[[PackageDetailDBClass alloc]init];
    pkgClass=[socialShareDetails objectAtIndex:cauroselCurrentIndex];
    
    titleLbl.text=pkgClass.pkgTitle;
    descLbl.text=pkgClass.pkgDescription;
    shareBtn.tag=index;
}

- (void)toggleOrientation
{
    //carousel orientation can be animated
    [UIView beginAnimations:nil context:nil];
    carousel.vertical = !carousel.vertical;
    [UIView commitAnimations];
    
    //update button
    // orientationBarItem.title = carousel.vertical? @"Vertical": @"Horizontal";
}

@end
