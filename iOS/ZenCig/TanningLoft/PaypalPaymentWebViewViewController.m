//
//  PaypalPaymentViewController.m
//  TanningLoft
//
//  Created by Lavi Gupta on 01/09/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "PaypalPaymentWebViewViewController.h"
#import "PurchaseDBClass.h"
#import "AppDelegate.h"
#import "Constant.h"

@interface PaypalPaymentWebViewViewController ()

@end

@implementation PaypalPaymentWebViewViewController
@synthesize webview,webviewUrlString,totalPoint,pkgObj,pointsTotal;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.navigationItem.title=@"Payment";
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchDown];
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
    // Do any additional setup after loading the view from its nib.
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;   // iOS 7 specific
    self.navigationController.navigationBar.translucent = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    NSURL *nsurl=[NSURL URLWithString:webviewUrlString];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    
    //  NSURLRequest* request1 = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    NSLog(@"RRRRRR%@",nsrequest);
    [self.webview loadRequest:nsrequest];
    self.webview.scalesPageToFit=YES;

}

- (void)webViewDidStartLoad:(UIWebView*)sender
{

}

- (void)webViewDidFinishLoad:(UIWebView*)sender
{
    UIWebView *webView1=(UIWebView *)sender;
    if (webView1.isLoading)
        return;
    
    NSURLRequest* request = self.webview.request;
    
    NSLog(@"New Address is : %@", request.URL.absoluteString);
    
    if (!([request.URL.absoluteString rangeOfString:[NSString stringWithFormat:@"paypal/order_confirm.php"]].location==NSNotFound)) {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Payment Success" message:[NSString stringWithFormat:@"Payment Successfull. You redeem %@ points during this purchase.",pointsTotal ] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        
        NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@updateAfterReedem.php?userid=%@&format=json&num=10&point=%@",tanningDelegate.hostString,[tanningDelegate.dbClass getUserName],pointsTotal] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        NSURLConnection *updateReedemDetailConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
        
        //Insert Purchase details
        PurchaseDBClass *purchaseClass=[[PurchaseDBClass alloc]init];
        purchaseClass.pkgTitle=pkgObj.pkgDescription ;
        purchaseClass.pkgId=pkgObj.pkgID;
        purchaseClass.pkgDescription=@"ZENCIG";
        purchaseClass.type=@"P";
        purchaseClass.pkgAmount=pkgObj.pkgAmount;
        
        DBConnectionClass *dbCon=[[DBConnectionClass alloc]init];
        [dbCon insertPurchaseDetails:purchaseClass];
        
        //Log activity
        float x = arc4random_uniform(10000000);
        
        ActivityLogDBClass *activityClass=[[ActivityLogDBClass alloc]init];
        activityClass.activityId=pkgObj.pkgID;
        activityClass.activitytitle=@"Point Redeemption";
        activityClass.username=[tanningDelegate.dbClass getUserName];
        activityClass.socialtype=@"";
        activityClass.activitytype=@"R";
        activityClass.activitydate=[NSString stringWithFormat:@"%@",[tanningDelegate.dbClass FormattedDateFromDate:[tanningDelegate.dbClass dateFromString:tanningDelegate.currentServerTime]]];
        activityClass.expiredate=[NSString stringWithFormat:@"%@",[tanningDelegate.dbClass FormattedDateFromDate:[tanningDelegate.dbClass dateFromString:tanningDelegate.currentServerTime]]];
        activityClass.amount=@"0";
        activityClass.point=pointsTotal;
        activityClass.status=@"A";
        [tanningDelegate.dbClass insertActivityData:activityClass];
        NSLog(@"%@",theRequest);
        if (updateReedemDetailConnection) {
            
        }
        //Add activity to server
        
        
        NSURLRequest *activityRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@ActivityLog.php?activityId=%@&userid=%@&firstname=%@&lastname=%@&socialtype=AAA&activitytype=R&activitytitle=Point Redeemption&activitydate=%@&expiredate=%@&amount=0&redeempoint=%@&status=A",tanningDelegate.hostString,pkgObj.pkgID,[tanningDelegate.dbClass getUserName],[tanningDelegate.dbClass getFirstName],[tanningDelegate.dbClass getLastName],[tanningDelegate.dbClass FormattedDateFromDate:[tanningDelegate.dbClass dateFromString:tanningDelegate.currentServerTime]],[tanningDelegate.dbClass FormattedDateFromDate:[[tanningDelegate.dbClass dateFromString:tanningDelegate.currentServerTime] dateByAddingTimeInterval:24*60*60*30]],pointsTotal] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        NSURLConnection *activityDetailConnection = [[NSURLConnection alloc] initWithRequest:activityRequest delegate:self];
        
        NSLog(@"%@",[[NSString stringWithFormat:@"%@ActivityLog.php?activityId=%@&userid=%@&firstname=%@&lastname=%@&socialtype=AAA&activitytype=R&activitytitle=Point Redeemption&activitydate=%@&expiredate=%@&amount=0&redeempoint=%@&status=A",tanningDelegate.hostString,[NSString stringWithFormat:@"%f",x],[tanningDelegate.dbClass getUserName],[tanningDelegate.dbClass getFirstName],[tanningDelegate.dbClass getLastName],[NSDate date],[[NSDate date] dateByAddingTimeInterval:24*60*60*7],pointsTotal] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]);
        
        if (activityDetailConnection) {
            
        }
        else{
            
        }
        
        //Log Package details to server
        
        NSURLRequest *pkgRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@MonthlyPackageService.php?userid=%@&firstname=%@&lastname=%@&pkgtitle=%@&pkgdesc=%@&amount=%@&point=%@&pkgType=%@&pkgId=%@",tanningDelegate.hostString,[tanningDelegate.dbClass getUserName],[tanningDelegate.dbClass getFirstName],[tanningDelegate.dbClass getLastName],pkgObj.pkgTitle  ,@"ZENCIG",pkgObj.pkgAmount,pkgObj.pkgPoints,pkgObj.pkgDurationType,pkgObj.pkgID] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        NSURLConnection *pkgPurchaseDetailConnection = [[NSURLConnection alloc] initWithRequest:pkgRequest delegate:self];
        NSLog(@"MonthlyPackageService %@",pkgRequest);
        //End of log server
        if (pkgPurchaseDetailConnection) {
            
            NSLog(@"Package detials logged successfully");
        }
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
    
    if (!([request.URL.absoluteString rangeOfString:[NSString stringWithFormat:@"paypal/order_cancel.php"]].location==NSNotFound)) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
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
