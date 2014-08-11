//
//  FacebookSocialPostViewController.m
//  MyMobiPoints
//
//  Created by Macmini on 29/12/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "FacebookSocialPostViewController.h"
#import "SocialPostObj.h"
#import "PlayVideoViewController.h"

@interface FacebookSocialPostViewController ()
{
    SocialPostObj *socialObj;
    NSURLConnection  *vimeoDataConnection;
    NSMutableData *vimeoDataArray;
    NSString *latestTweetURL;
}

@end

@implementation FacebookSocialPostViewController

@synthesize scrollView;
@synthesize socialPostArray;
@synthesize socialType;

//Coupon instances
@synthesize couponVw;
@synthesize couponImgView;
@synthesize couponTitleLbl;
@synthesize couponDescLbl;
@synthesize couponSavingLbl;
@synthesize couponShareBtn;
@synthesize couponAmountLbl;
@synthesize couponBrandLbl;
@synthesize couponExpireLbl;
@synthesize couponLogoImgView;
@synthesize couponTagLbl;
@synthesize couponOfferVw;

//Picture instances
@synthesize pictureVw;
@synthesize pictureImgView;
@synthesize pictureTitleLbl;
@synthesize pictureDescLbl;
@synthesize pictureLinkLbl;
@synthesize pictureShareBtn;

//Blog instances
@synthesize blogVw;
@synthesize blogTitleImgView;
@synthesize blogTitleLbl;
@synthesize blogDescLbl;
@synthesize blogLinkLbl;
@synthesize blogWebview;
@synthesize blogShareBtn;
@synthesize writerNameLbl;
@synthesize addedDateLbl;

//Video instances
@synthesize videoVw;
@synthesize videoImgView;
@synthesize videoTitleLbl;
@synthesize videoDescLbl;
@synthesize videoShareBtn;

//podcast instances
@synthesize podcastVw;
@synthesize podcastImgView;
@synthesize podcastTitleLbl;
@synthesize podcastDescLbl;
@synthesize podcastShareBtn;
@synthesize couponImgView1;
@synthesize currentIndex;

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
    
    socialPostArray=[tanningDelegate.dbClass fetchSocialPostDetail];
    socialObj=[[SocialPostObj alloc]init];
    
    if (socialPostArray.count) {
    socialObj=[socialPostArray objectAtIndex:currentIndex];
       
    if ([socialObj.subtype isEqualToString:@"coupon"]) {
        [self.scrollView addSubview:couponVw];
        couponTitleLbl.text=socialObj.title;
        couponDescLbl.text=socialObj.description;
        couponShareBtn.tag=currentIndex;
        [couponShareBtn setTitle:[NSString stringWithFormat:@"Share and earn %@ points",socialObj.pointvalue] forState:UIControlStateNormal];
        couponSavingLbl.text=[NSString stringWithFormat:@"%@%% saving",socialObj.savingper];
        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        NSString *filePath=[NSString stringWithFormat:@"%@/upload/%@",docDir,socialObj.imgname];
        couponImgView.image=[UIImage imageWithContentsOfFile:filePath];
        couponImgView1.image=[UIImage imageWithContentsOfFile:filePath];
        
        filePath=[NSString stringWithFormat:@"%@/upload/%@",docDir,socialObj.logoimagename];
        couponLogoImgView.image=[UIImage imageWithContentsOfFile:filePath];
        
        couponTagLbl.text=socialObj.tags;
        couponBrandLbl.text=socialObj.title;
        couponAmountLbl.text=socialObj.amount;
        UIColor *color1 = [self getUIColorObjectFromHexString:socialObj.colorcode alpha:1.0];
        couponOfferVw.backgroundColor=color1;
        couponShareBtn.backgroundColor=color1;
        
        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
        
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSDate *startDate=[formatter dateFromString:tanningDelegate.currentServerTime];
        NSDate *expireDate=[formatter dateFromString:socialObj.expiredate];
        if ([self daysBetween:startDate and:expireDate]>0) {
            couponExpireLbl.text=[NSString stringWithFormat:@"%d days",[self daysBetween:startDate and:expireDate]];
            couponShareBtn.enabled=TRUE;
        }
        else if ([self hoursBetween:startDate and:expireDate]>0) {
            couponExpireLbl.text=[NSString stringWithFormat:@"%d hours",[self hoursBetween:startDate and:expireDate]];
            couponShareBtn.enabled=TRUE;
        }
        else{
            couponExpireLbl.text=@"Expired";
            couponShareBtn.enabled=FALSE;
        }
        
        if ([socialType isEqualToString:@"twitter"]) {
            [couponShareBtn addTarget:self action:@selector(TweetBtnCliked:) forControlEvents:UIControlEventTouchUpInside];
        }
        else{
            [couponShareBtn addTarget:self action:@selector(shareBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        NSLog(@"%f",self.view.bounds.size.height);
        if ([[UIScreen mainScreen] bounds].size.height<=480) {
            self.couponImgView.hidden=YES;
            self.couponImgView1.hidden=NO;
            couponShareBtn.frame=CGRectMake(self.couponImgView.frame.origin.x, self.couponImgView.frame.origin.y, couponShareBtn.frame.size.width, couponShareBtn.frame.size.height);
        }
        else{
            self.couponImgView.hidden=NO;
            self.couponImgView1.hidden=YES;
        }

    }
    else if ([socialObj.subtype isEqualToString:@"picture"]) {
        [self.scrollView addSubview:pictureVw];
        
        pictureTitleLbl.text=socialObj.title;
        pictureDescLbl.text=socialObj.description;
        pictureShareBtn.tag=currentIndex;
        [pictureShareBtn setTitle:[NSString stringWithFormat:@"Share and earn %@ points",socialObj.pointvalue] forState:UIControlStateNormal];
        pictureLinkLbl.text=[NSString stringWithFormat:@"%@",socialObj.link];
        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        NSString *filePath=[NSString stringWithFormat:@"%@/upload/%@",docDir,socialObj.imgname];
        pictureImgView.image=[UIImage imageWithContentsOfFile:filePath];
        
        if ([socialType isEqualToString:@"twitter"]) {
            [pictureShareBtn addTarget:self action:@selector(TweetBtnCliked:) forControlEvents:UIControlEventTouchUpInside];
        }
        else{
            [pictureShareBtn addTarget:self action:@selector(shareBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        }

    }
    else if ([socialObj.subtype isEqualToString:@"blog"]) {
        [self.scrollView addSubview:blogVw];
        
        blogTitleLbl.text=socialObj.title;
        blogDescLbl.text=socialObj.description;
        blogShareBtn.tag=currentIndex;
        [blogShareBtn setTitle:[NSString stringWithFormat:@"Share and earn %@ points",socialObj.pointvalue] forState:UIControlStateNormal];
        blogLinkLbl.text=[NSString stringWithFormat:@"%@",socialObj.link];
        
        if ([socialType isEqualToString:@"twitter"]) {
            [blogShareBtn addTarget:self action:@selector(TweetBtnCliked:) forControlEvents:UIControlEventTouchUpInside];
        }
        else{
            [blogShareBtn addTarget:self action:@selector(shareBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        NSString *filePath=[NSString stringWithFormat:@"%@/upload/%@",docDir,socialObj.imgname];
        blogTitleImgView.image=[UIImage imageWithContentsOfFile:filePath];
        
        writerNameLbl.text=[NSString stringWithFormat:@"by %@",socialObj.writername];
        
        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
        
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSDate *tempDate=[formatter dateFromString:socialObj.addeddate];
        
        [formatter setDateFormat:@"MMM dd yyyy"];
        
        addedDateLbl.text=[formatter stringFromDate:tempDate];
        

    }
    else if ([socialObj.subtype isEqualToString:@"video"]) {
        [self.scrollView addSubview:videoVw];
        
        if ([socialObj.link componentsSeparatedByString:@"youtube"].count>1) {
            
            videoTitleLbl.text=socialObj.title;
            videoDescLbl.text=socialObj.description;
            videoShareBtn.tag=currentIndex;
            [videoShareBtn setTitle:[NSString stringWithFormat:@"Share and earn %@ points",socialObj.pointvalue] forState:UIControlStateNormal];
            NSString *videoId=[self extractYoutubeID:socialObj.link];
            //NSLog(@"%@  %@",socialObj.link,videoId);
            if (videoId) {
                NSString *imgUrl=[NSString stringWithFormat:@"http://img.youtube.com/vi/%@/0.jpg",videoId];
                videoImgView.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]]];
            }
            
        }
        else if ([socialObj.link componentsSeparatedByString:@"vimeo"].count>1) {
            
            videoTitleLbl.text=socialObj.title;
            videoDescLbl.text=socialObj.description;
            videoShareBtn.tag=currentIndex;
            [videoShareBtn setTitle:[NSString stringWithFormat:@"Share and earn %@ points",socialObj.pointvalue] forState:UIControlStateNormal];
            NSString *videoId=[self extractVimeoID:socialObj.link];
            NSLog(@"%@  %@",socialObj.link,videoId);
            
            //************vimeoDataArray
            NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"http://vimeo.com/api/v2/video/%@.json",videoId] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
            vimeoDataConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
            
            NSLog(@"%@",theRequest);
            if (vimeoDataConnection) {
                // Inform the user that the download failed.
                vimeoDataArray=[[NSMutableData alloc ]init];
                
                NSLog(@"vimeoDataArray JSON download youtube");
            }
            else {
                NSLog(@"vimeoDataArray JSON download fail");
            }
            //************End vimeoDataArray
        }
        
        if ([socialType isEqualToString:@"twitter"]) {
            [videoShareBtn addTarget:self action:@selector(TweetBtnCliked:) forControlEvents:UIControlEventTouchUpInside];
        }
        else{
            [videoShareBtn addTarget:self action:@selector(shareBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        }

    }
    else if ([socialObj.subtype isEqualToString:@"podcast"]) {
        [self.scrollView addSubview:podcastVw];
        
        if ([socialObj.link componentsSeparatedByString:@"youtube"].count>1) {
            
            podcastTitleLbl.text=socialObj.title;
            podcastDescLbl.text=socialObj.description;
            podcastShareBtn.tag=currentIndex;
            [podcastShareBtn setTitle:[NSString stringWithFormat:@"Share and earn %@ points",socialObj.pointvalue] forState:UIControlStateNormal];
            NSString *videoId=[self extractYoutubeID:socialObj.link];
            NSLog(@"%@  %@",socialObj.link,videoId);
            NSString *imgUrl=[NSString stringWithFormat:@"http://img.youtube.com/vi/%@/0.jpg",videoId];
            podcastImgView.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]]];
        }
        else if ([socialObj.link componentsSeparatedByString:@"vimeo"].count>1) {
            
            podcastTitleLbl.text=socialObj.title;
            podcastDescLbl.text=socialObj.description;
            podcastShareBtn.tag=currentIndex;
            [podcastShareBtn setTitle:[NSString stringWithFormat:@"Share and earn %@ points",socialObj.pointvalue] forState:UIControlStateNormal];
            NSString *videoId=[self extractVimeoID:socialObj.link];
            NSLog(@"%@  %@",socialObj.link,videoId);
            
            //************vimeoDataArray
            NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"http://vimeo.com/api/v2/video/%@.json",videoId] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
            vimeoDataConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
            
            NSLog(@"%@",theRequest);
            if (vimeoDataConnection) {
                // Inform the user that the download failed.
                vimeoDataArray=[[NSMutableData alloc ]init];
                
                NSLog(@"vimeoDataArray JSON download youtube");
            }
            else {
                NSLog(@"vimeoDataArray JSON download fail");
            }
            
        }
        if ([socialType isEqualToString:@"twitter"]) {
            [podcastShareBtn addTarget:self action:@selector(TweetBtnCliked:) forControlEvents:UIControlEventTouchUpInside];
        }
        else{
            [podcastShareBtn addTarget:self action:@selector(shareBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    
    }
    
     if (![socialObj.subtype isEqualToString:@"coupon"]) {
         self.scrollView.contentSize=CGSizeMake(320, 480);
     }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)playVideo:(id)sender{
    
    PlayVideoViewController *playVC=[[PlayVideoViewController alloc]init];
    playVC.videoURL=socialObj.link;
    [self.navigationController pushViewController:playVC animated:YES];
}

-(IBAction)playPodcast:(id)sender{
    
    PlayVideoViewController *playVC=[[PlayVideoViewController alloc]init];
    playVC.videoURL=socialObj.link;
    [self.navigationController pushViewController:playVC animated:YES];
}

- (NSString *)extractYoutubeID:(NSString *)youtubeURL
{
    NSString *vID = nil;
    NSString *url = youtubeURL;
    if([url componentsSeparatedByString:@"?"].count>2)
    {
    NSString *query = [url componentsSeparatedByString:@"?"][1];
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        if ([kv[0] isEqualToString:@"v"]) {
            vID = kv[1];
            break;
        }
    }
    NSLog(@"%@", vID);
    }
    return vID;
}

- (NSString *)extractVimeoID:(NSString *)vimeoURL
{
    NSString *vID = nil;
    NSString *url = vimeoURL;
    
    NSArray *pairs = [url componentsSeparatedByString:@"/"];
    
    if (pairs.count) {
        vID=[pairs objectAtIndex:pairs.count-1];
        
        NSLog(@"%@", [pairs objectAtIndex:pairs.count-1]);
    }
    
    return vID;
}


-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if(vimeoDataConnection==connection){
        
        [vimeoDataArray setLength:0];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if(vimeoDataConnection==connection){
        
        [vimeoDataArray appendData:data];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (connection==vimeoDataConnection) {
        
        NSString *responseString = [[NSString alloc] initWithData:vimeoDataArray encoding:NSUTF8StringEncoding];
        
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        id jsonObject  = [parser objectWithString:responseString error:nil];
        
        NSLog(@"vimeoDataArray responseString %@ %@",responseString,[parser objectWithString:responseString error:nil]);
        
        if ([jsonObject isKindOfClass:[NSDictionary class]])
        {
            // treat as a dictionary, or reassign to a dictionary ivar
            NSLog(@"NSdict");
        }
        else if ([jsonObject isKindOfClass:[NSArray class]])
        {
            // treat as an array or reassign to an array ivar.
            NSLog(@"NSArray %@",[[jsonObject objectAtIndex:0] valueForKey:@"thumbnail_large"]);
            
            if ([socialObj.subtype isEqualToString:@"video"]) {
                NSString *imgUrl=[NSString stringWithFormat:@"%@",[[jsonObject objectAtIndex:0] valueForKey:@"thumbnail_large"]];
                videoImgView.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]]];
            }
            else if ([socialObj.subtype isEqualToString:@"podcast"]) {
                NSString *imgUrl=[NSString stringWithFormat:@"%@",[[jsonObject objectAtIndex:0] valueForKey:@"thumbnail_large"]];
                podcastImgView.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]]];
            }
        }
    }
}

-(IBAction)shareBtnClicked:(id)sender{
    
    UIButton *btn=(UIButton *)sender;
    
    SocialPostObj *pkgObj=[[SocialPostObj alloc]init];
    pkgObj=[socialPostArray objectAtIndex:btn.tag];
    
    NSMutableDictionary *params =
    [NSMutableDictionary dictionaryWithObjectsAndKeys:
     pkgObj.title , @"name",
     pkgObj.description , @"description",
     pkgObj.link, @"link",
     [NSString stringWithFormat:@"%@%@",tanningDelegate.hostString,pkgObj.imgpath], @"picture",
     nil];
    
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
                                                     message:[NSString stringWithFormat:@"You have successfully shared a post to Facebook. You currently have %@ points pending.Our team will review your post shortly, once approved your %@ points will be awarded to your Account. ",socialObj.pointvalue,socialObj.pointvalue ]
                                                    delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil]
                          show];
                         
                         NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@receivePost.php?userid=%@&username=%@&socialtype=F&sharedurl=%@&bonuspoint=%@&postid=%@",tanningDelegate.hostString,[tanningDelegate.dbClass getUserName],[tanningDelegate.dbClass getFirstName],url,pkgObj.pointvalue,postid]stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]   cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
                         NSURLConnection *shareDetailConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
                         
                         NSLog(@"theRequest %@  &&&& %@",theRequest,[NSURL URLWithString:[NSString stringWithFormat:@"%@receivePost.php?userid=%@&username=%@&socialtype=F&sharedurl=%@&bonuspoint=%@&postid=%@",tanningDelegate.hostString,[tanningDelegate.dbClass getUserName],[tanningDelegate.dbClass getFirstName],url,pkgObj.pointvalue,postid]]);
                         NSMutableData *shareDataArray;
                         if (shareDetailConnection) {
                             // Inform the user that the download failed.
                             shareDataArray=[[NSMutableData alloc ]init];
                             
                             NSLog(@"JSON download youtube");
                             
                             ActivityLogDBClass *activityClass=[[ActivityLogDBClass alloc]init];
                             activityClass.activityId=postid;
                             activityClass.activitytitle=@"Facebook share";
                             activityClass.username=[tanningDelegate.dbClass getUserName];
                             activityClass.socialtype=@"F";
                             activityClass.activitytype=@"S";
                             activityClass.activitydate=[NSString stringWithFormat:@"%@",[tanningDelegate.dbClass FormattedDateFromDate:[NSDate date]]];
                             activityClass.expiredate=[NSString stringWithFormat:@"%@",[tanningDelegate.dbClass FormattedDateFromDate:[NSDate date]]];
                             activityClass.amount=@"0";
                             activityClass.point=pkgObj.pointvalue;
                             activityClass.status=@"P";
                             [tanningDelegate.dbClass insertActivityData:activityClass];
                             
                             //Add activity to server
                             
                             NSURLRequest *activityRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@ActivityLog.php?activityId=%@&userid=%@&firstname=%@&lastname=%@&socialtype=F&activitytype=S&activitytitle=Facebook share&activitydate=%@&expiredate=%@&amount=0&redeempoint=%@&status=P",tanningDelegate.hostString,postid,[tanningDelegate.dbClass getUserName],[tanningDelegate.dbClass getFirstName],[tanningDelegate.dbClass getLastName],[tanningDelegate.dbClass FormattedDateFromDate:[NSDate date]],[tanningDelegate.dbClass FormattedDateFromDate:[NSDate date]],pkgObj.pointvalue] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
                             NSURLConnection *activityDetailConnection = [[NSURLConnection alloc] initWithRequest:activityRequest delegate:self];
                             
                             NSLog(@"%@",[[NSString stringWithFormat:@"%@ActivityLog.php?activityId=%@&userid=%@&firstname=%@&lastname=%@&socialtype=F&activitytype=S&activitytitle=Facebook share&activitydate=%@&expiredate=%@&amount=0&redeempoint=5&status=P",tanningDelegate.hostString,postid,[tanningDelegate.dbClass getUserName],[tanningDelegate.dbClass getFirstName],[tanningDelegate.dbClass getLastName],[tanningDelegate.dbClass FormattedDateFromDate:[NSDate date]],[tanningDelegate.dbClass FormattedDateFromDate:[NSDate date]]] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]);
                             NSMutableArray *socialShareDetails;
                             if (activityDetailConnection) {
                                 
                                 [tanningDelegate.dbClass updateSocialPostStatus:@"0":pkgObj.socialid];
                                 socialShareDetails=[[NSMutableArray alloc]init];
                                 socialShareDetails=[tanningDelegate.dbClass fetchSocialDetail];
                                 
                                 [self.navigationController popViewControllerAnimated:YES];
                                 
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

-(IBAction)TweetBtnCliked:(id)sender;
{
    UIButton *tempBtn=(UIButton *)sender;
    
    SocialPostObj *pkgObj=[[SocialPostObj alloc]init];
    pkgObj=[socialPostArray objectAtIndex:tempBtn.tag];
    
    
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
        [sheet setInitialText:pkgObj.title];
        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *filePath=[NSString stringWithFormat:@"%@/upload/%@",docDir,socialObj.imgname];
        UIImage *image=[UIImage imageWithContentsOfFile:filePath];
        [sheet addImage:image];
        [sheet addURL:[NSURL URLWithString:pkgObj.link]];
        [self presentViewController:sheet animated:YES completion:Nil];
    }
    
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
                SLRequest *twitterInfoRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:[NSURL URLWithString:@"https://api.twitter.com/1.1/users/show.json"] parameters:[NSDictionary dictionaryWithObject: twitterAccount.username forKey:@"screen_name"]];
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


-(void)sendTweetdetailToDashboard:(NSString *)tweeturl{
    
    float x = arc4random_uniform(10000000);
    
    SocialPostObj *pkgObj=[[SocialPostObj alloc]init];
    pkgObj=[socialPostArray objectAtIndex:currentIndex];
    
    
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@receivePost.php?userid=%@&username=%@&socialtype=T&sharedurl=%@&bonuspoint=%@&postid=%f",tanningDelegate.hostString,[tanningDelegate.dbClass getUserName],[tanningDelegate.dbClass getFirstName],tweeturl,pkgObj.pointvalue,x] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    NSURLConnection *shareDetailConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if (shareDetailConnection) {
        // Inform the user that the download failed.
        NSMutableData *shareDataArray=[[NSMutableData alloc ]init];
        
        //  [recievedData writeToFile:path atomically:YES];
        NSLog(@"JSON download youtube");
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Congratulations!" message:[NSString stringWithFormat:@"You have successfully shared a tweet to Twitter. You currently have %@ points pending.Our team will review your post shortly, once approved your %@ points will be awarded to your Account. ",pkgObj.pointvalue,pkgObj.pointvalue] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        
        ActivityLogDBClass *activityClass=[[ActivityLogDBClass alloc]init];
        activityClass.activityId=[NSString stringWithFormat:@"%f",x];
        activityClass.activitytitle=@"Twitter post";
        activityClass.username=[tanningDelegate.dbClass getUserName];
        activityClass.socialtype=@"T";
        activityClass.activitytype=@"S";
        activityClass.activitydate=[NSString stringWithFormat:@"%@",[tanningDelegate.dbClass FormattedDateFromDate:[NSDate date]]];
        activityClass.expiredate=[NSString stringWithFormat:@"%@",[tanningDelegate.dbClass FormattedDateFromDate:[NSDate date]]];
        activityClass.amount=@"0";
        activityClass.point=pkgObj.pointvalue;
        activityClass.status=@"P";
        [tanningDelegate.dbClass insertActivityData:activityClass];
        
        
        //Add activity to server
        
        NSURLRequest *activityRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@ActivityLog.php?activityId=%f&userid=%@&firstname=%@&lastname=%@&socialtype=T&activitytype=S&activitytitle=Twitter Post&activitydate=%@&expiredate=%@&amount=0&redeempoint=%@&status=P",tanningDelegate.hostString,x,[tanningDelegate.dbClass getUserName],[tanningDelegate.dbClass getFirstName],[tanningDelegate.dbClass getLastName],[tanningDelegate.dbClass FormattedDateFromDate:[NSDate date]],[tanningDelegate.dbClass FormattedDateFromDate:[NSDate date]],pkgObj.pointvalue] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        NSURLConnection *activityDetailConnection = [[NSURLConnection alloc] initWithRequest:activityRequest delegate:self];
        
        NSLog(@"%@",[[NSString stringWithFormat:@"%@ActivityLog.php?activityId=%f&userid=%@&firstname=%@&lastname=%@&socialtype=T&activitytype=S&activitytitle=Twitter Post&activitydate=%@&expiredate=%@&amount=0&redeempoint=3&status=P",tanningDelegate.hostString,x,[tanningDelegate.dbClass getUserName],[tanningDelegate.dbClass getFirstName],[tanningDelegate.dbClass getLastName],[NSDate date],[NSDate date]] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]);
        
        if (activityDetailConnection) {
            [tanningDelegate.dbClass updateSocialPostStatus:@"0":pkgObj.socialid];
            socialPostArray=[[NSMutableArray alloc]init];
            socialPostArray=[tanningDelegate.dbClass fetchSocialDetail];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }
    else {
        NSLog(@"JSON download fail");
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
        alertTitle = @"Congratulations !";
        alertMsg=[NSString stringWithFormat:@"You have successfully shared a post to Facebook. You currently have %@ points pending.Our team will review your post shortly, once approved your %@ points will be awarded to your Account.",[(SocialWeightDetailDBClass *)[[tanningDelegate.dbClass fetchSocialPointWeight] objectAtIndex:0]FacebookPoints],[(SocialWeightDetailDBClass *)[[tanningDelegate.dbClass fetchSocialPointWeight] objectAtIndex:0]FacebookPoints]];
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle
                                                        message:alertMsg
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
}


- (UIColor *)getUIColorObjectFromHexString:(NSString *)hexStr alpha:(CGFloat)alpha
{
    // Convert hex string to an integer
    unsigned int hexint = [self intFromHexString:hexStr];
    
    // Create color object, specifying alpha as well
    UIColor *color =
    [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16))/255
                    green:((CGFloat) ((hexint & 0xFF00) >> 8))/255
                     blue:((CGFloat) (hexint & 0xFF))/255
                    alpha:alpha];
    
    return color;
}

- (unsigned int)intFromHexString:(NSString *)hexStr
{
    unsigned int hexInt = 0;
    
    // Create scanner
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];
    
    // Tell scanner to skip the # character
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    
    // Scan hex value
    [scanner scanHexInt:&hexInt];
    
    return hexInt;
}

- (NSInteger)daysBetween:(NSDate *)dt1 and:(NSDate *)dt2 {
    NSUInteger unitFlags = NSDayCalendarUnit;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:unitFlags fromDate:dt1 toDate:dt2 options:0];
    NSInteger daysBetween = abs([components day]);
    
    return daysBetween;
}

- (NSInteger)hoursBetween:(NSDate *)dt1 and:(NSDate *)dt2 {
    
    NSTimeInterval interval = [dt2 timeIntervalSinceDate:dt1];
    int hours = (int)interval / 3600;             // integer division to get the hours part
    
    return hours;
}

-(IBAction)readMoreBtn:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:socialObj.link]];
}
@end
