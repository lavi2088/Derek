//
//  InstagramLoginViewController.m
//  TanningLoft
//
//  Created by Lavi on 01/06/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "InstagramLoginViewController.h"
#import "IstagramViewController.h"
#import "AppDelegate.h"
#import "Constant.h"

int counter=0;
@interface InstagramLoginViewController ()

@end

@implementation InstagramLoginViewController
@synthesize webview;
@synthesize accessToken,userId;

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
    self.webview.delegate = self;
    self.webview.scalesPageToFit = TRUE;
    self.webview.backgroundColor = [UIColor grayColor];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;   // iOS 7 specific
    self.navigationController.navigationBar.translucent = NO;
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.center = CGPointMake(160, 100);
    spinner.hidesWhenStopped = NO;
    
    [webview addSubview:spinner];
    // Do any additional setup after loading the view from its nib.
     
//    NSString *url=[[NSString stringWithFormat:@"https://api.instagram.com/oauth/authorize/?client_id=dc5f7bdb48fc4356922bdca6d5429960&amp;redirect_uri=%@instagram/redirect.php&amp;response_type=access_token",tanningDelegate.hostString] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
   // NSString *url=@"https://api.instagram.com/oauth/authorize/?client_id=dc5f7bdb48fc4356922bdca6d5429960&redirect_uri=http://myriadim.com/mobile-app-services/instagram/redirect.php&response_type=token";
    
    NSString *url=@"https://api.instagram.com/oauth/authorize/?client_id=e426e7d12753488a9a1f74b3e8099812&amp;redirect_uri=http://myriadim.com/mobile-app-services/instagram/redirect.php&amp;response_type=code";

    // https://instagram.com/oauth/authorize/?client_id=CLIENT-ID&redirect_uri=REDIRECT-URI&response_type=token
    
//    @"https://api.instagram.com/oauth/authorize/?client_id=dc5f7bdb48fc4356922bdca6d5429960&amp;redirect_uri=http://lavi2088.site11.com/mobile/instagram/redirect.php&amp;response_type=code";
    NSURL *nsurl=[NSURL URLWithString:url];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    
    //  NSURLRequest* request1 = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    NSLog(@"RRRRRR%@",nsrequest);
    [self.webview loadRequest:nsrequest];
    
    
    
}

- (void)webViewDidStartLoad:(UIWebView*)sender
{
    UIActivityIndicatorView *actView;
    for ( id object in webview.subviews ) {
        if ([object isMemberOfClass:[UIActivityIndicatorView class]]) {
            actView = (UIActivityIndicatorView*)object;
        }
    }
    NSLog(@"Web view did start loading");
    [actView startAnimating];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView*)sender
{
    UIWebView *webView1=(UIWebView *)sender;
    if (webView1.isLoading)
        return;
    
    NSURLRequest* request = self.webview.request;
    
    NSLog(@"New Address is : %@", request.URL.absoluteString);
      // self.loadingLabel.text=@"";
    
    [spinner stopAnimating];
    
        
    if (!([request.URL.absoluteString rangeOfString:[NSString stringWithFormat:@"instagram/redirect.php?code"]].location==NSNotFound)) {
        
        IstagramViewController *istaVC=[[IstagramViewController alloc]initWithNibName:@"IstagramInfoViewController" bundle:nil];
        
        [self.navigationController pushViewController:istaVC animated:YES];
        
        NSArray *chunks = [request.URL.absoluteString componentsSeparatedByString: @"code="];
        
        NSLog(@"[chunks objectAtIndex:1] %@",[chunks objectAtIndex:1]);
        tanningDelegate.accessToken=[chunks objectAtIndex:1];
        
        NSArray *accessTokenArray = [tanningDelegate.accessToken componentsSeparatedByString: @"."];
        
        tanningDelegate.instagramId=[accessTokenArray objectAtIndex:0];
        
        [[NSUserDefaults standardUserDefaults] setObject:[accessTokenArray objectAtIndex:0] forKey:@"instagramid"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        NSLog(@"userId %@",tanningDelegate.instagramId);

        
//        NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"https://api.instagram.com/v1/users/%@/media/recent/?access_token=%@",userId,accessToken] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
//        pointDetailConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
//        
//        NSLog(@"%@",theRequest);
//        if (pointDetailConnection) {
//            // Inform the user that the download failed.
//            pointDataArray=[[NSMutableData alloc ]init];
//            
//            //  [recievedData writeToFile:path atomically:YES];
//            NSLog(@"JSON download youtube");
//        }
//        else {
//            NSLog(@"JSON download fail");
//        }

        
        
    }
    else  if (!([request.URL.absoluteString rangeOfString:[NSString stringWithFormat:@"instagram/redirect.php"]].location==NSNotFound)) {
        
//        NSLog(@"Not found");
//        IstagramViewController *istaVC=[[IstagramViewController alloc]initWithNibName:@"IstagramInfoViewController" bundle:nil];
//        [self.navigationController pushViewController:istaVC animated:YES];
    }
    
    
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
        
        NSLog(@"responseString %@",responseString);
        
        NSError *error;
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSMutableDictionary *jsonDictionary = [parser objectWithString:responseString error:nil];
        
        NSArray *nodes = (NSArray*)[jsonDictionary objectForKey:@"data"];
        
        for (NSDictionary *node in nodes){
            
            NSLog(@"NSDictionary link %@", [node objectForKey:@"link"]);

        }
   
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)backBtnClicked:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
