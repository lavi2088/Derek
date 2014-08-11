//
//  CaptureImageViewController.m
//  TanningLoft
//
//  Created by Lavi on 01/06/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "CaptureImageViewController.h"
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>
#import "AppDelegate.h"
#import "Constant.h"
@interface CaptureImageViewController ()

@end

@implementation CaptureImageViewController
@synthesize titleTxt;
@synthesize descTxt;
@synthesize captureImage;
@synthesize tweetBtn;
@synthesize shareBtn;
@synthesize orgImg;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.navigationItem.title=@"Instagram";
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
    
    pictureServerArray=[[NSMutableArray alloc]init];
    [pictureServerArray addObject:[NSString stringWithFormat:@"%@image/bed1@1x.png",tanningDelegate.hostString]];
    [pictureServerArray addObject:[NSString stringWithFormat:@"%@image/bed1@2x.png",tanningDelegate.hostString]];
    [pictureServerArray addObject:[NSString stringWithFormat:@"%@image/bed1@3x.png",tanningDelegate.hostString]];
    [pictureServerArray addObject:@"bed2"];
    [pictureServerArray addObject:@"bed3"];
    
     tanningDelegate.instagramShareStatus=NO;
    
    NSUserDefaults *standardUserDefaults=[NSUserDefaults standardUserDefaults];
    [standardUserDefaults setBool:NO forKey:@"intaStatus"];
    [standardUserDefaults synchronize];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;   // iOS 7 specific
    self.navigationController.navigationBar.translucent = NO;

}

-(void)viewDidAppear:(BOOL)animated{
    
    captureImage.image=orgImg;
    
    titleTxt.delegate=self;
    descTxt.delegate=self;
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
                                   //self.sharePhotos.enabled = YES;
                               }];
        
        //self.sharePhotos.enabled = NO;
    }];
    
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

-(IBAction)shareBtnClicked:(id)sender{
    UIButton *btn=(UIButton *)sender;
    NSMutableDictionary *params =
    [NSMutableDictionary dictionaryWithObjectsAndKeys:
     titleTxt.text, @"name",
     @"Build great social apps and get more installs.", @"caption",
     descTxt.text, @"description",
     @"https://developers.facebook.com/ios", @"link",
     [pictureServerArray objectAtIndex:btn.tag], @"picture",
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
                     
                     NSString *url=[NSString stringWithFormat:@"https//www.facebook.com/%@/posts/%@",userid,postid];
                     NSLog(@"%@", url);
                     // Show the result in an alert
                     [[[UIAlertView alloc] initWithTitle:@"Result"
                                                 message:@"Posted Successfully"
                                                delegate:nil
                                       cancelButtonTitle:@"OK!"
                                       otherButtonTitles:nil]
                      show];
                     
                     NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@receivePost.php?userid=%@&username=%@&socialtype=ist&sharedurl=%@&bonuspoint=%@&postid=%@",tanningDelegate.hostString,[tanningDelegate.dbClass getUserName],@"name",url,[(SocialWeightDetailDBClass *)[[tanningDelegate.dbClass fetchSocialPointWeight] objectAtIndex:0]InstagramPoints],postid]stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]   cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
                     shareDetailConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
                     
                     NSLog(@"theRequest %@  &&&& %@",theRequest,[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@receivePost.php?userid=%@&username=%@&socialtype=ist&sharedurl=%@&bonuspoint=%@&postid=%@",tanningDelegate.hostString,[tanningDelegate.dbClass getUserName],@"name",url,[(SocialWeightDetailDBClass *)[[tanningDelegate.dbClass fetchSocialPointWeight] objectAtIndex:0]InstagramPoints],postid]stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]   cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0]);
                     if (shareDetailConnection) {
                         // Inform the user that the download failed.
                         shareDataArray=[[NSMutableData alloc ]init];
                         
                         //  [recievedData writeToFile:path atomically:YES];
                         NSLog(@"JSON download youtube");
                     }
                     else {
                         NSLog(@"JSON download fail");
                     }
                     
                     [self.navigationController popViewControllerAnimated:YES];
                     
                 }
             }
         }
     }];
}

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


-(IBAction)tweetBtnClicked:(id)sender{
    UIButton *tempBtn=(UIButton *)sender;
    
    if ([TWTweetComposeViewController canSendTweet]) {
        // Initialize Tweet Compose View Controller
        TWTweetComposeViewController *vc = [[TWTweetComposeViewController alloc] init];
        // Settin The Initial Text
        [vc setInitialText:titleTxt.text];
        // Adding an Image
        UIImage *image = orgImg;
        [vc addImage:image];
        // Adding a URL
        NSURL *url = [NSURL URLWithString:@"http://twitter.com"];
        [vc addURL:url];
        // Setting a Completing Handler
        [vc setCompletionHandler:^(TWTweetComposeViewControllerResult result) {
            
            float x = arc4random_uniform(10000000);
            NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@receivePost.php?userid=%@&username=%@&socialtype=I&sharedurl=%@&bonuspoint=%@&postid=%f",tanningDelegate.hostString,[tanningDelegate.dbClass getUserName],[tanningDelegate.dbClass getFirstName],url,[(SocialWeightDetailDBClass *)[[tanningDelegate.dbClass fetchSocialPointWeight] objectAtIndex:0]InstagramPoints],x] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
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
            
            [self.navigationController popViewControllerAnimated:YES];
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

-(void)setImage:(UIImage *)image{
    
    captureImage.image=[UIImage imageNamed:@"applynow_bg"];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [titleTxt resignFirstResponder];
    return YES;
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    
    [descTxt resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [titleTxt resignFirstResponder];
    [descTxt resignFirstResponder];
}

-(IBAction)shareIstagram:(id)sender{
    
    UIImage *image = captureImage.image;
    
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

-(IBAction)backBtnClicked:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
