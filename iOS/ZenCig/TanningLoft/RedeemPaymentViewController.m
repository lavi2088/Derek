//
//  RedeemPaymentViewController.m
//  TanningLoft
//
//  Created by Lavi on 20/06/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "RedeemPaymentViewController.h"
#import "ActivityLogDBClass.h"

#warning "Enter your credentials"
#define kPayPalClientId @"AUzlcBCPJc1ZdGhycnGFaYu9aoS7CdOdnU7BXz2miSvs6EkfRgFypaSQajVn"
#define kPayPalReceiverEmail @"meetlavi6@gmail.com"
float pointUnit=0.05;
@interface RedeemPaymentViewController ()

@end

@implementation RedeemPaymentViewController
@synthesize userNameLbl,userProfileImage;
@synthesize pointsTotal;
@synthesize pkgTitle;
@synthesize pkgAmount;
@synthesize pkgPoints;
@synthesize pkgId;
@synthesize title1Lbl;
@synthesize title2Lbl;
@synthesize amountDiffPoints;
@synthesize pkgdurationType;
@synthesize pkgObj;
@synthesize scrollView;
@synthesize purchaseBtn;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         self.navigationItem.title=@"Redeem";
        
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
    
    if (FBSession.activeSession.isOpen) {
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection,
           NSDictionary<FBGraphUser> *user,
           NSError *error) {
             if (!error) {
                 // self.userNameLbl.text =  user.name;
                 self.userProfileImage.profileID = [user objectForKey:@"id"];
                 
                 //user.username
                 
             }
         }];
    }
    amountDiffPoints=[pkgAmount floatValue]-([pointsTotal integerValue]*0.05);
    
    DBConnectionClass *dbCon=[[DBConnectionClass alloc]init];
    self.userNameLbl.text=[NSString stringWithFormat:@"Hello %@ ",[dbCon getFirstName]];
    
    int pointdiff=[pointsTotal integerValue];
    float amountDiff=[pointsTotal integerValue];
    title1Lbl.text=[NSString stringWithFormat:@"You don't quite have enough points to redeem this package, you require %.0f points. Would you like to purchase the additional points needed to buy this package?",([pkgAmount floatValue])/0.05-[pointsTotal integerValue]];
    title2Lbl.text=[NSString stringWithFormat:@"To purchase the remaining %.0f points and redeem your '%@' package, a fee of $%.2f is outstanding, would you like to continue ?",([pkgAmount floatValue])/0.05-[pointsTotal integerValue],pkgTitle ,amountDiffPoints];
    
    // Optimization: Prepare for display of the payment UI by getting network work done early
    //[PayPalPaymentViewController setEnvironment:self.environment];
   // [PayPalPaymentViewController prepareForPaymentUsingClientId:kPayPalClientId];
    
    //self.scrollView.contentSize=CGSizeMake(320, 480);
    if ([[UIScreen mainScreen] bounds].size.height<=480) {
        purchaseBtn.frame=CGRectMake(purchaseBtn.frame.origin.x, title2Lbl.frame.origin.y+title2Lbl.frame.size.height+22, purchaseBtn.frame.size.width, purchaseBtn.frame.size.height);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Proof of payment validation

- (void)sendCompletedPaymentToServer:(PayPalPayment *)completedPayment {
    // TODO: Send completedPayment.confirmation to server
    NSLog(@"Here is your proof of payment:\n\n%@\n\nSend this to your server for confirmation and fulfillment.", completedPayment.confirmation);
}

#pragma mark - PayPalPaymentDelegate methods

- (void)payPalPaymentDidComplete:(PayPalPayment *)completedPayment {
    NSLog(@"PayPal Payment Success!");
    self.completedPayment = completedPayment;
    // self.successView.hidden = NO;
    
    [self sendCompletedPaymentToServer:completedPayment]; // Payment was processed successfully; send to server for verification and fulfillment
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Payment Success" message:[NSString stringWithFormat:@"Payment Successfull. You redeem %@ points during this purchase.",pointsTotal ] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alert show];
    
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@updateAfterReedem.php?userid=%@&format=json&num=10&point=%@",tanningDelegate.hostString,[tanningDelegate.dbClass getUserName],pointsTotal] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    NSURLConnection *updateReedemDetailConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    //Insert Purchase details
    PurchaseDBClass *purchaseClass=[[PurchaseDBClass alloc]init];
    purchaseClass.pkgTitle=pkgTitle ;
    purchaseClass.pkgId=pkgId;
    purchaseClass.pkgDescription=@"ZENCIG";
    purchaseClass.type=@"P";
    purchaseClass.pkgAmount=pkgAmount;
    
    DBConnectionClass *dbCon=[[DBConnectionClass alloc]init];
    [dbCon insertPurchaseDetails:purchaseClass];
    
    //Log activity
    float x = arc4random_uniform(10000000);
    
    ActivityLogDBClass *activityClass=[[ActivityLogDBClass alloc]init];
    activityClass.activityId=pkgId;
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

    
    NSURLRequest *activityRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@ActivityLog.php?activityId=%@&userid=%@&firstname=%@&lastname=%@&socialtype=AAA&activitytype=R&activitytitle=Point Redeemption&activitydate=%@&expiredate=%@&amount=0&redeempoint=%@&status=A",tanningDelegate.hostString,pkgId,[tanningDelegate.dbClass getUserName],[tanningDelegate.dbClass getFirstName],[tanningDelegate.dbClass getLastName],[tanningDelegate.dbClass FormattedDateFromDate:[tanningDelegate.dbClass dateFromString:tanningDelegate.currentServerTime]],[tanningDelegate.dbClass FormattedDateFromDate:[[tanningDelegate.dbClass dateFromString:tanningDelegate.currentServerTime] dateByAddingTimeInterval:24*60*60*30]],pointsTotal] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    NSURLConnection *activityDetailConnection = [[NSURLConnection alloc] initWithRequest:activityRequest delegate:self];
    
    NSLog(@"%@",[[NSString stringWithFormat:@"%@ActivityLog.php?activityId=%@&userid=%@&firstname=%@&lastname=%@&socialtype=AAA&activitytype=R&activitytitle=Point Redeemption&activitydate=%@&expiredate=%@&amount=0&redeempoint=%@&status=A",tanningDelegate.hostString,[NSString stringWithFormat:@"%f",x],[tanningDelegate.dbClass getUserName],[tanningDelegate.dbClass getFirstName],[tanningDelegate.dbClass getLastName],[NSDate date],[[NSDate date] dateByAddingTimeInterval:24*60*60*7],pointsTotal] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]);
    
    if (activityDetailConnection) {
        
    }
    else{
        
    }

    //Log Package details to server
    
    NSURLRequest *pkgRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@MonthlyPackageService.php?userid=%@&firstname=%@&lastname=%@&pkgtitle=%@&pkgdesc=%@&amount=%@&point=%@&pkgType=%@&pkgId=%@",tanningDelegate.hostString,[tanningDelegate.dbClass getUserName],[tanningDelegate.dbClass getFirstName],[tanningDelegate.dbClass getLastName],pkgTitle  ,@"ZENCIG",pkgAmount,pkgPoints,pkgdurationType,pkgObj.pkgID] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    NSURLConnection *pkgPurchaseDetailConnection = [[NSURLConnection alloc] initWithRequest:pkgRequest delegate:self];
    NSLog(@"MonthlyPackageService %@",pkgRequest);
    //End of log server
    if (pkgPurchaseDetailConnection) {
        
        NSLog(@"Package detials logged successfully");
    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)payPalPaymentDidCancel {
    NSLog(@"PayPal Payment Canceled");
    self.completedPayment = nil;
    // self.successView.hidden = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)buyBtnClicked:(id)sender{
    //**************Paypal SDK commented code****************************
    
    //**************Paypal SDK commented code****************************
    
    PaypalPaymentWebViewViewController *paypalVC=[[PaypalPaymentWebViewViewController alloc] init];
    paypalVC.pkgObj=self.pkgObj;
    paypalVC.pointsTotal=self.pointsTotal;
    paypalVC.totalPoint=self.pointsTotal;
    
    if ([pkgObj.pkgDurationType isEqualToString:@"M"]) {
        paypalVC.webviewUrlString=[NSString stringWithFormat:@"%@paypal/subscription.php?id=%@&userid=%@&point=%@",tanningDelegate.hostString,pkgId,[tanningDelegate.dbClass getUserName],pointsTotal];
    }
    else{
        paypalVC.webviewUrlString=[NSString stringWithFormat:@"%@paypal/buy.php?id=%@&userid=%@&point=%@",tanningDelegate.hostString,pkgId,[tanningDelegate.dbClass getUserName],pointsTotal];
    }
    
    [self.navigationController pushViewController:paypalVC animated:YES];
    
}

-(IBAction)backBtnClicked:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
