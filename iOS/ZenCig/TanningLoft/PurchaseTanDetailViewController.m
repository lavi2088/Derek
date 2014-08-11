//
//  PurchaseTanDetailViewController.m
//  TanningLoft
//
//  Created by Lavi on 27/06/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "PurchaseTanDetailViewController.h"
#import "AppDelegate.h"
#import "Constant.h"
#import "DBConnectionClass.h"
#import "RedeemVoucherWithPinService.h"

@interface PurchaseTanDetailViewController ()
{
    UITapGestureRecognizer *tapOutside;
}
@property (strong,nonatomic) IBOutlet FBProfilePictureView *userProfileImage;
@property(nonatomic,retain)IBOutlet UILabel *username;
@end

@implementation PurchaseTanDetailViewController
@synthesize titleLbl;
@synthesize addDate;
@synthesize expireDate;
@synthesize amount;
@synthesize purchaseClass;
@synthesize userProfileImage,username,scrollView,pinTxt;

@synthesize titleLbl1,addDateH,amountH,expireDateH,qrCodeImg;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title=@"My Account";
        
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
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;   // iOS 7 specific
    self.navigationController.navigationBar.translucent = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.titleLbl.text=purchaseClass.pkgTitle ;
    
    NSString *dateString = purchaseClass.AddedDate;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // this is imporant - we set our input date format to match our input string
    // if format doesn't match you'll get nil from your string, so be careful
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss +SSSS"];
    NSDate *dateFromString = [[NSDate alloc] init];
    // voila!
    dateFromString = [dateFormatter dateFromString:dateString];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM-dd-yyyy"];
    NSString *adddateString = [dateFormat stringFromDate:dateFromString];
    
    self.addDate.text=[NSString stringWithFormat:@"%@",adddateString];
    
    dateString = purchaseClass.ExpireDate;
    dateFormatter = [[NSDateFormatter alloc] init];
    // this is imporant - we set our input date format to match our input string
    // if format doesn't match you'll get nil from your string, so be careful
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss +SSSS"];
    dateFromString = [[NSDate alloc] init];
    // voila!
    dateFromString = [dateFormatter dateFromString:dateString];
    
    dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM-dd-yyyy"];
    NSString *expiredateString = [dateFormat stringFromDate:dateFromString];
    
    self.expireDate.text=[NSString stringWithFormat:@"%@",expiredateString];
    
    self.amount.text=[NSString stringWithFormat:@"$%@",purchaseClass.pkgAmount];
    
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
    
    DBConnectionClass *dbCon=[[DBConnectionClass alloc]init];
    username.text=[NSString stringWithFormat:@"%@ ",[dbCon getFirstName]];
    
    //****************Purchase Details ********************//
    
    if (self.view.bounds.size.height<=380) {
        
        self.addDate.frame=CGRectMake(220, 108, self.addDate.frame.size.width, self.addDate.frame.size.height);
        self.addDateH.frame=CGRectMake(220, 133, self.addDateH.frame.size.width, self.addDateH.frame.size.height);
        
        self.expireDate.frame=CGRectMake(220, 158, self.expireDate.frame.size.width, self.expireDate.frame.size.height);
        self.expireDateH.frame=CGRectMake(220, 183, self.expireDateH.frame.size.width, self.expireDateH.frame.size.height);
        
        self.amount.frame=CGRectMake(220, 208, self.amount.frame.size.width, self.amount.frame.size.height);
        self.amountH.frame=CGRectMake(220, 233, self.amountH.frame.size.width, self.amountH.frame.size.height);
        
        self.pinTxt.frame=CGRectMake(220, 263, 90, self.pinTxt.frame.size.height);
        
        self.qrCodeImg.frame=CGRectMake(15, 108, self.qrCodeImg.frame.size.width, self.qrCodeImg.frame.size.height);
        titleLbl1.hidden=YES;
    }

    //****************End of Purchase Details *****************//
    
    if (tapOutside == nil)
        tapOutside = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textFieldTouchOutSide:)];
    
    [self.scrollView addGestureRecognizer:tapOutside];
    
    NSLog(@"%@",purchaseClass.isRedeemed);
    
    if ([purchaseClass.isRedeemed isEqualToString:@"1"]) {
        pinTxt.hidden=YES;
    }
    else{
        pinTxt.hidden=NO;
    }
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)backBtnClicked:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField { //Keyboard becomes visible
    
    if(textField==pinTxt)
    {
        UIScrollView* v = (UIScrollView*) self.scrollView ;
        
        CGRect rc = [textField bounds];
        rc = [textField convertRect:rc toView:v];
        CGPoint pt = rc.origin ;
        pt.x = 0 ;
        pt.y -= 250 ;
        [v setContentOffset:pt animated:YES];
        scrollView.contentSize=CGSizeMake(320, 800);
    }
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField { //keyboard will hide
    
    scrollView.contentSize=CGSizeMake(320, 440);
    [scrollView setContentOffset:CGPointMake(0, 0)];
    
    if (pinTxt.text.length>1) {
        
        [tanningDelegate.dbClass showIndicator];
        RedeemVoucherWithPinService *redeemService=[[RedeemVoucherWithPinService alloc]init];
        
        [redeemService callPinRedeemService : pinTxt.text :purchaseClass.pkgId ];
    }
    
}

//This hides keyboard BUT IS ALSO CALLED WHEN CLEAR BUTTON IS TAPPED
- (void)textFieldTouchOutSide:(id)sender
{
    [pinTxt resignFirstResponder];
    
}

//NEVER GETS CALLED
- (BOOL) textFieldShouldClear:(UITextField *)textField {
    return YES;
}

-(void)reloadPackageAfterRedem:(NSString *)status{
    
    if([status isEqualToString:@"1"])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Invalid PIN." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}
@end
