//
//  IstagramViewController.m
//  TanningLoft
//
//  Created by Lavi on 01/06/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "IstagramViewController.h"
#import "IstagramCustomCell.h"
#import "TwitterTblVwCellViewController.h"
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>
#import "CaptureImageViewController.h"
#import "AppDelegate.h"
#import "Constant.h"
#import "SocialWeightDetailDBClass.h"

@interface IstagramViewController ()

@end

@implementation IstagramViewController
@synthesize userNameLbl,sharePhotos,FBTblVwOfArticles,articleDesc,articleTite,pictureNameArray,userProfileImage,pictureServerArray;
@synthesize webview=_webview;
@synthesize points;
@synthesize containerView,tooltipImg;
@synthesize scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.navigationItem.title=@"Instagram";
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchDown];
        [button setTitle:@" " forState:UIControlStateNormal];
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
    
       self.title = @"ZENCIG";
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
//                                              initWithTitle:@"Back"
//                                              style:UIBarButtonItemStyleBordered
//                                              target:self
//                                              action:@selector(backButtonPressed:)];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(sessionStateChanged:)
     name:UIDocumentStateChangedNotification
     object:nil];
    
    dbClass=[[DBConnectionClass alloc]init];

    tanningDelegate.instagramShareStatus=NO;
    
    NSUserDefaults *standardUserDefaults=[NSUserDefaults standardUserDefaults];
    [standardUserDefaults setBool:NO forKey:@"intaStatus"];
    [standardUserDefaults synchronize];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;   // iOS 7 specific
    self.navigationController.navigationBar.translucent = NO;
    
    self.scrollView.contentSize=CGSizeMake(320, 455);
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (FBSession.activeSession.isOpen) {
        [self populateUserDetails];
    }
    
    FBTblVwOfArticles.delegate=self;
    FBTblVwOfArticles.dataSource=self;
    
//    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    spinner.center = CGPointMake(160, 100);
//    spinner.hidesWhenStopped = NO;
//    
//    [_webview addSubview:spinner];
   
    self.points.text=[NSString stringWithFormat:@"%@ points",[(SocialWeightDetailDBClass *)[[tanningDelegate.dbClass fetchSocialPointWeight] objectAtIndex:0]InstagramPoints]];
    
    if (self.view.bounds.size.height<=380) {
        
        containerView.frame=CGRectMake(self.containerView.frame.origin.x, 0, self.containerView.frame.size.width, self.containerView.frame.size.height);
        tooltipImg.hidden=YES;
    }
}

//#pragma mark -Webview delegate
//
//-(BOOL) webView:(UIWebView*)inWeb
//shouldStartLoadWithRequest:(NSURLRequest*)inRequest
// navigationType:(UIWebViewNavigationType)inType{
//    if (inType == UIWebViewNavigationTypeLinkClicked) {
//        [[UIApplication sharedApplication] openURL:[inRequest URL]];
//        return NO;
//    }
//    return YES;
//}
//
//- (void)webViewDidStartLoad:(UIWebView *)webView{
//    
//    //[UIApplication sharedApplication].isNetworkActivityIndicatorVisible = YES;
//}
//
//- (void)webViewDidFinishLoad:(UIWebView *)webView{
//    
//    // finished loading, hide the activity indicator in the status bar
//	//[UIApplication sharedApplication].isNetworkActivityIndicatorVisible = NO;
//    
//    NSString *currentURL = _webview.request.URL.absoluteString;
//	NSLog(@"Current URL  %@",currentURL);
//}
//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
//    
//}
//#pragma mark -End of webview delegate

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
                 self.userNameLbl.text = user.name;
                 self.userProfileImage.profileID = [user objectForKey:@"id"];
                 
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
                                              defaultAudience:FBSessionDefaultAudienceFriends
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
    
    UIButton *tempBtn=(UIButton *)sender;
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"bed%d",tempBtn.tag+1]];
    
    //UIImage *image = [UIImage imageNamed:@"MGInstagramPhoto"];
    if ([MGInstagram isAppInstalled])
    {
        [MGInstagram postImage:image withCaption:@"@ZENCIG" inView:self.view];
    
        tanningDelegate.instagramShareStatus=YES;
        
        NSUserDefaults *standardUserDefaults=[NSUserDefaults standardUserDefaults];
        [standardUserDefaults setBool:YES forKey:@"intaStatus"];
        [standardUserDefaults synchronize];
    }
    else
        [self.notInstalledAlert show];
}

- (UIAlertView*) notInstalledAlert
{
    return [[UIAlertView alloc] initWithTitle:@"Instagram Not Installed!" message:@"Instagram must be installed on the device in order to post images" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
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
        alertTitle = @"Success";
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
    
    return 150;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [articleTite count];    //count number of row from counting arry hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"Cell";
    
    IstagramCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"istagramCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    // Here we use the provided setImageWithURL: method to load the web image
    // Ensure you use a placeholder image otherwise cells will be initialized with no image
    //   // [cell.imageView setImageWithURL:[NSURL URLWithString:@"http://example.com/image.jpg"]
    //                   placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cell.shareBtn.tag=indexPath.row;
    [cell.shareBtn addTarget:self action:@selector(shareBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    cell.imgVw.image=[UIImage imageNamed:[pictureNameArray objectAtIndex:indexPath.row]];
    //cell.lbl1.text=[NSString stringWithFormat:@"Level %d",indexPath.row+1];
    cell.title.text=[articleTite objectAtIndex:indexPath.row];
    cell.desc.text=[articleDesc objectAtIndex:indexPath.row];
    cell.tweetBtn.tag=indexPath.row;
    [cell.tweetBtn addTarget:self action:@selector(TweetBtnCliked:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

-(IBAction)TweetBtnCliked:(id)sender;
{
    UIButton *tempBtn=(UIButton *)sender;
    
    if ([TWTweetComposeViewController canSendTweet]) {
        // Initialize Tweet Compose View Controller
        TWTweetComposeViewController *vc = [[TWTweetComposeViewController alloc] init];
        // Settin The Initial Text
        [vc setInitialText:[self.articleTite objectAtIndex:tempBtn.tag]];
        // Adding an Image
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"bed%d",tempBtn.tag+1]];
        [vc addImage:image];
        // Adding a URL
        NSURL *url = [NSURL URLWithString:@"http://mobile.tutsplus.com"];
        [vc addURL:url];
        // Setting a Completing Handler
        [vc setCompletionHandler:^(TWTweetComposeViewControllerResult result) {
            
            float x = arc4random_uniform(10000000);
            NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@receivePost.php?userid=%@&username=%@&socialtype=I&sharedurl=%@&bonuspoint=%@&postid=%f",tanningDelegate.hostString,[tanningDelegate.dbClass getUserName],self.userNameLbl.text,url,[(SocialWeightDetailDBClass *)[[tanningDelegate.dbClass fetchSocialPointWeight] objectAtIndex:0]InstagramPoints],x] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
            shareDetailConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
            
            if (shareDetailConnection) {
                // Inform the user that the download failed.
                shareDataArray=[[NSMutableData alloc ]init];
                
                //  [recievedData writeToFile:path atomically:YES];
                NSLog(@"JSON download youtube");
            }
            else {
                NSLog(@"JSON download fail");
            }
            
            [self dismissModalViewControllerAnimated:YES];
        }];
        // Display Tweet Compose View Controller Modally
        [self presentViewController:vc animated:YES completion:nil];
    } else {
        // Show Alert View When The Application Cannot Send Tweets
        NSString *message = @"The application cannot send a tweet at the moment. This is because it cannot reach Twitter or you don't have a Twitter account associated with this device.";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops" message:message delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alertView show];
    }
    
}



-(IBAction)captureBtnClicked:(id)sender{
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        
        picker=[[UIImagePickerController alloc] init];
        picker.delegate=self;
        
        [picker setAllowsEditing:YES];
        
        picker.sourceType=UIImagePickerControllerSourceTypeCamera;
        //[self.navigationController pushViewController:(UIViewController *)ipc animated:YES];
        [self presentModalViewController:picker animated:YES];
        
    }
    
}

-(void) imagePickerController:(UIImagePickerController *) picker didFinishPickingMediaWithInfo :(NSDictionary *)info
{
    
    [picker dismissModalViewControllerAnimated:YES];
    
    UIImage *imageToScale=[info objectForKey:UIImagePickerControllerOriginalImage];
    CaptureImageViewController *capVC=[[CaptureImageViewController alloc]init];
    
    
    
   // imgView = [[UIImageView alloc] initWithImage:imageToScale];
    
    //[picker presentModalViewController:cropper animated:YES];
    
    [self.navigationController pushViewController:capVC animated:YES];
    
    capVC.orgImg=imageToScale;
}

-(IBAction)backButtonPressed:(id)sender{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
