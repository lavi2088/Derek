//
//  ActivitySocialDetailViewController.m
//  TanningLoft
//
//  Created by Lavi Gupta on 08/08/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "ActivitySocialDetailViewController.h"
#import "Constant.h"
#import "AppDelegate.h"

@interface ActivitySocialDetailViewController (){
    NSString *postURL;
}

@end

@implementation ActivitySocialDetailViewController
@synthesize postID;
@synthesize webview;

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
    
    self.webview.delegate = self;
    self.webview.scalesPageToFit = TRUE;
    self.webview.backgroundColor = [UIColor grayColor];
    
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@SocialShareURLService.php?userid=%@&format=json&num=10&postid=%@",tanningDelegate.hostString,[tanningDelegate.dbClass getUserName],postID] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    postDetailConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    NSLog(@"%@",theRequest);
    if (postDetailConnection) {
        // Inform the user that the download failed.
        postDataArray=[[NSMutableData alloc ]init];
        
        NSLog(@"JSON download youtube");
    }
    else {
        NSLog(@"JSON download fail");
    }

}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
    if(postDetailConnection==connection){
        
        [postDataArray setLength:0];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
    if(postDetailConnection==connection){
        
        [postDataArray appendData:data];
    }
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (connection==postDetailConnection) {
        
        NSString *responseString = [[NSString alloc] initWithData:postDataArray encoding:NSUTF8StringEncoding];
        
        NSLog(@"responseString %@",responseString);
        
        NSError *error;
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSMutableDictionary *jsonDictionary = [parser objectWithString:responseString error:nil];
        
        NSArray *nodes = (NSArray*)[jsonDictionary objectForKey:@"posts"];
        
        if (nodes.count==0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        for (NSDictionary *node in nodes){
            
            NSLog(@"NSDictionary %@", [(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"sharedurl"]);
            
            postURL=[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"sharedurl"];
            
        }
        
        NSString *url=postURL;
        NSURL *nsurl=[NSURL URLWithString:url];
        NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
        
        //  NSURLRequest* request1 = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        
        NSLog(@"RRRRRR%@",nsrequest);
        [self.webview loadRequest:nsrequest];
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
