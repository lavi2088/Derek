//
//  FacebookArticleViewController.m
//  TanningLoft
//
//  Created by Lavi on 22/05/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "FacebookArticleViewController.h"
#import "FaceBookTblVwCellViewController.h"
#import "AppDelegate.h"
#import "Constant.h"
#import "ActivityLogDBClass.h"
#import <QuartzCore/QuartzCore.h>
#import <FacebookSDK/FacebookSDK.h>
@interface FacebookArticleViewController ()
{
    NSInteger cauroselCurrentIndex;
}

@end

@implementation FacebookArticleViewController

@synthesize userNameLbl,sharePhotos,FBTblVwOfArticles,articleDesc,articleTite,pictureNameArray,userProfileImage,pictureServerArray,carousel,titleLbl,descLbl,shareBtn,tempvw;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

    
    self.pictureNameArray=[[NSMutableArray alloc]init];
    [self.pictureNameArray addObject:@"bed1"];
    [self.pictureNameArray addObject:@"bed2"];
    [self.pictureNameArray addObject:@"bed3"];
    [self.pictureNameArray addObject:@"bed2"];
    [self.pictureNameArray addObject:@"bed3"];
    
    self.pictureServerArray=[[NSMutableArray alloc]init];
    [pictureServerArray addObject:[NSString stringWithFormat:@"%@image/bed1@1x.png",tanningDelegate.hostString]];
    [pictureServerArray addObject:[NSString stringWithFormat:@"%@image/bed1@2x.png",tanningDelegate.hostString]];
    [pictureServerArray addObject:[NSString stringWithFormat:@"%@image/bed1@3x.png",tanningDelegate.hostString]];
    [pictureServerArray addObject:@"bed2"];
    [pictureServerArray addObject:@"bed3"];

    
    
    self.articleTite=[[NSMutableArray alloc]init];
    [self.articleTite addObject:@"ERGOLIN ADVANTAGE 400 MAXIMUM EXPOSURE 15 MINUTES"];
    [self.articleTite addObject:@"SUNDASH 252 RADIUS EXPOSURE 12 MINUTES"];
    [self.articleTite addObject:@"ERGOLIN ADVANTAGE 400 MAXIMUM EXPOSURE 12 MINUTES"];
    
    self.articleDesc=[[NSMutableArray alloc]init];
    [self.articleDesc addObject:@"The advantage 400 ensures the highest tanning results with a perfect combination of 3 VIT Max high-pressure facials, 40 Turbo Power tanning lamps and a reflex neck tanner. In addition, its comfort Colling ventilation, with cool air coming from facial and body zone outlets, is infinitely variable and keeps clients feeling fresh durning the tanning session."];
    [self.articleDesc addObject:@"TheSundash 252 Radius is equipped with 52, 2-meter SHO-RUVA tanning lamps.It delivers a beautifully even, full-body tan in a 12- minute exposure schedule for those tanners who are on the go. With an open aair tanning environment the Sundash offers over 6.5 feet of vertical tanning power."];
    [self.articleDesc addObject:@"The advantage 400 ensures the highest tanning results with a perfect combination of 3 VIT Max high-pressure facials, 40 Turbo Power tanning lamps and a reflex neck tanner. In addition, its comfort Colling ventilation, with cool air coming from facial and body zone outlets, is infinitely variable and keeps clients feeling fresh durning the tanning session."];

    [super viewDidLoad];
    self.title = @"Facebook";
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
//                                              initWithTitle:@"Logout"
//                                              style:UIBarButtonItemStyleBordered
//                                              target:self
//                                              action:@selector(logoutButtonWasPressed:)];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(sessionStateChanged:)
     name:UIDocumentStateChangedNotification
     object:nil];
    
    dbClass =[[DBConnectionClass alloc]init];
    
    //Carousel config
    
    cauroselCurrentIndex=0;
    
    //configure carousel
    carousel.type = iCarouselTypeCoverFlow2;
    //navItem.title = @"CoverFlow2";
    
    self.carousel.clipsToBounds = YES; //This is main point
    
    //[self toggleOrientation];
    
    self.carousel.vertical=NO;
    self.carousel.scrollSpeed=0.0;
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;   // iOS 7 specific
    self.navigationController.navigationBar.translucent = NO;

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (FBSession.activeSession.isOpen) {
        [self populateUserDetails];
    }
    socialShareDetails=[[NSMutableArray alloc]init];
    socialShareDetails=[tanningDelegate.dbClass fetchSocialDetail];
    [FBTblVwOfArticles reloadData];
    [carousel reloadData];
    
    [shareBtn setTitle:[NSString stringWithFormat:@"Share & Earn %@ points",[(SocialWeightDetailDBClass *)[[tanningDelegate.dbClass fetchSocialPointWeight] objectAtIndex:0]FacebookPoints]] forState:UIControlStateNormal];
}

-(void)logoutButtonWasPressed:(id)sender {
    
    NSHTTPCookieStorage* cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray* facebookCookies = [cookies cookiesForURL:
                                [NSURL URLWithString:@"http://login.facebook.com"]];
    
    for (NSHTTPCookie* cookie in facebookCookies) {
        [cookies deleteCookie:cookie];
    }
    
    if (FBSession.activeSession.isOpen) {
        [FBSession.activeSession closeAndClearTokenInformation];
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"]) {
        [defaults removeObjectForKey:@"FBAccessTokenKey"];
        [defaults removeObjectForKey:@"FBExpirationDateKey"];
        [defaults synchronize];
    }
    
}


- (void)populateUserDetails
{
    if (FBSession.activeSession.isOpen) {
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection,
           NSDictionary<FBGraphUser> *user,
           NSError *error) {
             if (!error) {
                 self.userNameLbl.text =  user.name;
                 self.userProfileImage.profileID = [user objectForKey:@"id"];
                 
                 //user.username
               
             }
         }];
    }
}

- (void)sessionStateChanged:(NSNotification*)notification {
    [self populateUserDetails];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -

// Convenience method to perform some action that requires the "publish_actions" permissions.
- (void) performPublishAction:(void (^)(void)) action {
    // we defer request for permission to post to the moment of post, then we check for the permission
    if ([FBSession.activeSession.permissions indexOfObject:@"publish_actions"] == NSNotFound) {
        // if we don't already have the permission, then we request it now
        [FBSession.activeSession requestNewPublishPermissions:@[@"publish_actions"]
                                              defaultAudience:FBSessionDefaultAudienceEveryone
                                            completionHandler:^(FBSession *session, NSError *error) {
                                                if (!error) {
                                                    action();
                                                }
                                                //For this example, ignore errors (such as if user cancels).
                                            }];
    } else {
        action();
    }
    
}

-(IBAction)SharePhotosBtnClicked:(id)sender;
{
    // Just use the icon image from the application itself.  A real app would have a more
    // useful way to get an image.
    UIImage *img = [UIImage imageNamed:@"Icon-72@2x.png"];
    
    [self performPublishAction:^{
        
        [FBRequestConnection startForUploadPhoto:img
                               completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                                   [self showAlert:@"Photo Post" result:result error:error];
                                   self.sharePhotos.enabled = YES;
                               }];
        
        self.sharePhotos.enabled = NO;
    }];

}

-(IBAction)shareBtnClicked:(id)sender{
    
    UIButton *btn=(UIButton *)sender;
    
    PackageDetailDBClass *pkgObj=[[PackageDetailDBClass alloc]init];
    pkgObj=[socialShareDetails objectAtIndex:cauroselCurrentIndex];
    
    NSMutableDictionary *params =
    [NSMutableDictionary dictionaryWithObjectsAndKeys:
     pkgObj.pkgTitle , @"name",
     pkgObj.pkgDescription , @"description",
     pkgObj.pkgLink, @"link",
     [NSString stringWithFormat:@"%@%@",tanningDelegate.hostString,pkgObj.pkgImagePath], @"picture",
     nil];
    
    // Invoke the dialog
    
    
    [FBWebDialogs presentFeedDialogModallyWithSession:nil
                                           parameters:params
                                              handler:
     ^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
         if (error) {
             // Error launching the dialog or publishing a story.
             NSLog(@"Error publishing story.");
         } else {
             if (result == FBWebDialogResultDialogNotCompleted) {
                 // User clicked the "x" icon
                 NSLog(@"User canceled story publishing.");
             } else {
                 
                 if([tanningDelegate.dbClass connected]){
                 // Handle the publish feed callback
                 NSDictionary *urlParams = [self parseURLParams:[resultURL query]];
                 if (![urlParams valueForKey:@"post_id"]) {
                     // User clicked the Cancel button
                     NSLog(@"User canceled story publishing.");
                 } else {
                     // User clicked the Share button
                     NSString *msg = [NSString stringWithFormat:
                                      @"Posted story, id: %@",
                                      [urlParams valueForKey:@"post_id"]];
                     
                     NSLog(@"%@", msg);
                     NSArray* postidArray = [[urlParams valueForKey:@"post_id"] componentsSeparatedByString: @"_"];
                     NSString* userid = [postidArray objectAtIndex: 0];
                     NSString* postid = [postidArray objectAtIndex: 1];
                     
                     NSString *url=[NSString stringWithFormat:@"https://www.facebook.com/%@/posts/%@",userid,postid];
                     NSLog(@"%@", url);
                     // Show the result in an alert
                     [[[UIAlertView alloc] initWithTitle:@"Congratulations!"
                                                 message:[NSString stringWithFormat:@"You have successfully shared a post to Facebook. You currently have %@ points pending.Our team will review your post shortly, once approved your %@ points will be awarded to your Account. ",[(SocialWeightDetailDBClass *)[[tanningDelegate.dbClass fetchSocialPointWeight] objectAtIndex:0]FacebookPoints],[(SocialWeightDetailDBClass *)[[tanningDelegate.dbClass fetchSocialPointWeight] objectAtIndex:0]FacebookPoints] ]
                                                delegate:nil
                                       cancelButtonTitle:@"OK"
                                       otherButtonTitles:nil]
                      show];
                     
                     NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@receivePost.php?userid=%@&username=%@&socialtype=F&sharedurl=%@&bonuspoint=%@&postid=%@",tanningDelegate.hostString,[dbClass getUserName],self.userNameLbl.text,url,[(SocialWeightDetailDBClass *)[[tanningDelegate.dbClass fetchSocialPointWeight] objectAtIndex:0]FacebookPoints],postid]stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]   cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
                     shareDetailConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
                     
                     NSLog(@"theRequest %@  &&&& %@",theRequest,[NSURL URLWithString:[NSString stringWithFormat:@"%@receivePost.php?userid=%@&username=%@&socialtype=F&sharedurl=%@&bonuspoint=%@&postid=%@",tanningDelegate.hostString,[dbClass getUserName],self.userNameLbl.text,url,[(SocialWeightDetailDBClass *)[[tanningDelegate.dbClass fetchSocialPointWeight] objectAtIndex:0]FacebookPoints],postid]]);
                     if (shareDetailConnection) {
                         // Inform the user that the download failed.
                         shareDataArray=[[NSMutableData alloc ]init];
                         
                         //  [recievedData writeToFile:path atomically:YES];
                         NSLog(@"JSON download youtube");
                         
                         // Logging Activity
                         
                         //(activityId TEXT,username TEXT , socialtype TEXT, activitytype TEXT,activitytitle TEXT, activitydate TEXT, expiredate TEXT, amount TEXT,point TEXT, status TEXT
                         
                         ActivityLogDBClass *activityClass=[[ActivityLogDBClass alloc]init];
                         activityClass.activityId=postid;
                         activityClass.activitytitle=@"Facebook share";
                         activityClass.username=[dbClass getUserName];
                         activityClass.socialtype=@"F";
                         activityClass.activitytype=@"S";
                         activityClass.activitydate=[NSString stringWithFormat:@"%@",[tanningDelegate.dbClass FormattedDateFromDate:[NSDate date]]];
                         activityClass.expiredate=[NSString stringWithFormat:@"%@",[tanningDelegate.dbClass FormattedDateFromDate:[NSDate date]]];
                         activityClass.amount=@"0";
                         activityClass.point=[(SocialWeightDetailDBClass *)[[tanningDelegate.dbClass fetchSocialPointWeight] objectAtIndex:0]FacebookPoints];
                         activityClass.status=@"P";
                         [tanningDelegate.dbClass insertActivityData:activityClass];
                         
                         //Add activity to server
                         
                         NSURLRequest *activityRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@ActivityLog.php?activityId=%@&userid=%@&firstname=%@&lastname=%@&socialtype=F&activitytype=S&activitytitle=Facebook share&activitydate=%@&expiredate=%@&amount=0&redeempoint=%@&status=P",tanningDelegate.hostString,postid,[dbClass getUserName],[dbClass getFirstName],[dbClass getLastName],[tanningDelegate.dbClass FormattedDateFromDate:[NSDate date]],[tanningDelegate.dbClass FormattedDateFromDate:[NSDate date]],[(SocialWeightDetailDBClass *)[[tanningDelegate.dbClass fetchSocialPointWeight] objectAtIndex:0]FacebookPoints]] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
                         NSURLConnection *activityDetailConnection = [[NSURLConnection alloc] initWithRequest:activityRequest delegate:self];
                         
                         NSLog(@"%@",[[NSString stringWithFormat:@"%@ActivityLog.php?activityId=%@&userid=%@&firstname=%@&lastname=%@&socialtype=F&activitytype=S&activitytitle=Facebook share&activitydate=%@&expiredate=%@&amount=0&redeempoint=5&status=P",tanningDelegate.hostString,postid,[dbClass getUserName],[dbClass getFirstName],[dbClass getLastName],[tanningDelegate.dbClass FormattedDateFromDate:[NSDate date]],[tanningDelegate.dbClass FormattedDateFromDate:[NSDate date]]] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]);
                         
                         if (activityDetailConnection) {
                             
                             [tanningDelegate.dbClass updateSocialShareStatus:@"0":pkgObj.pkgID];
                             socialShareDetails=[[NSMutableArray alloc]init];
                             socialShareDetails=[tanningDelegate.dbClass fetchSocialDetail];
                             [FBTblVwOfArticles reloadData];
                             [carousel reloadData];
                             
                         }
                         else{
                             
                         }

                         
                     }
                     else {
                         NSLog(@"JSON download fail");
                     }
                 }
                     //End of Facebook Complete
                 }
                 else{
                     UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Network" message:@"No Network Found" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alert show];
                 }
             }
         }
     }];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if(shareDetailConnection==connection){
        
        [shareDataArray setLength:0];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if(shareDetailConnection==connection){
        
        [shareDataArray appendData:data];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (connection==shareDetailConnection) {
        
    }
    
}

/**
 * A function for parsing URL parameters.
 */
- (NSDictionary*)parseURLParams:(NSString *)query {
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val =
        [[kv objectAtIndex:1]
         stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [params setObject:val forKey:[kv objectAtIndex:0]];
    }
    return params;
}

// UIAlertView helper for post buttons
- (void)showAlert:(NSString *)message
           result:(id)result
            error:(NSError *)error {
    
    NSString *alertMsg;
    NSString *alertTitle;
    if (error) {
        alertTitle = @"Error";
        if (error.fberrorShouldNotifyUser ||
            error.fberrorCategory == FBErrorCategoryPermissions ||
            error.fberrorCategory == FBErrorCategoryAuthenticationReopenSession) {
            alertMsg = error.fberrorUserMessage;
        } else {
            alertMsg = @"Operation failed due to a connection problem, retry later.";
        }
    } else {
        NSDictionary *resultDict = (NSDictionary *)result;
        alertMsg = [NSString stringWithFormat:@"Successfully posted '%@'.", message];
        NSString *postId = [resultDict valueForKey:@"id"];
        if (!postId) {
            postId = [resultDict valueForKey:@"postId"];
        }
        if (postId) {
            alertMsg = [NSString stringWithFormat:@"%@\nPost ID: %@", alertMsg, postId];
        }
        alertTitle = @"Congratulations!";
        alertMsg=[NSString stringWithFormat:@"You have successfully shared a post to Facebook. You currently have %@ points pending.Our team will review your post shortly, once approved your %@ points will be awarded to your Account. ",[(SocialWeightDetailDBClass *)[[tanningDelegate.dbClass fetchSocialPointWeight] objectAtIndex:0]FacebookPoints],[(SocialWeightDetailDBClass *)[[tanningDelegate.dbClass fetchSocialPointWeight] objectAtIndex:0]FacebookPoints] ];
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle
                                                        message:alertMsg
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
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
    
    FaceBookTblVwCellViewController *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"FaceBookTblVwCellViewController" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    // Here we use the provided setImageWithURL: method to load the web image
    // Ensure you use a placeholder image otherwise cells will be initialized with no image
    //   // [cell.imageView setImageWithURL:[NSURL URLWithString:@"http://example.com/image.jpg"]
    //                   placeholderImage:[UIImage imageNamed:@"placeholder"]];
    PackageDetailDBClass *pkgObj=[[PackageDetailDBClass alloc]init];
    pkgObj=[socialShareDetails objectAtIndex:indexPath.row];
    
    cell.shareBtn.tag=indexPath.row;
    [cell.shareBtn addTarget:self action:@selector(shareBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    //cell.imgVw.image=[UIImage imageNamed:[pictureNameArray objectAtIndex:indexPath.row]];
    //cell.lbl1.text=[NSString stringWithFormat:@"Level %d",indexPath.row+1];
    cell.title.text=pkgObj.pkgTitle;
    cell.desc.text=pkgObj.pkgDescription ;
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath=[NSString stringWithFormat:@"%@/upload/%@",docDir,pkgObj.imgName];
    cell.imgVw.image=[UIImage imageWithContentsOfFile:filePath];
    
    return cell;
}


#pragma Faceboo Fetch Email

- (void)fetchUserDetails {
    
     
}

-(IBAction)backButtonClicked:(id)sender{
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
        
        [view addSubview:topBgImg];
        
    }
    
    PackageDetailDBClass *pkgClass=[[PackageDetailDBClass alloc]init];
    pkgClass=[socialShareDetails objectAtIndex:(index % [self numberOfItemsInCarousel:carousel])];
    
    cauroselCurrentIndex=index % [self numberOfItemsInCarousel:carousel];
    
    titleLbl.text=pkgClass.pkgTitle;
    descLbl.text=pkgClass.pkgDescription;
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath=[NSString stringWithFormat:@"%@/upload/%@",docDir,pkgClass.imgName];
    topBgImg.image=[UIImage imageWithContentsOfFile:filePath];
   //tempvw.image=[UIImage imageWithContentsOfFile:filePath];
    
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
