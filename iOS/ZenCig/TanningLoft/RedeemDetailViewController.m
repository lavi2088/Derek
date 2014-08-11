//
//  RedeemDetailViewController.m
//  TanningLoft
//
//  Created by Lavi on 19/06/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "RedeemDetailViewController.h"
#import "RedeemPaymentViewController.h"
#import "DBConnectionClass.h"
#import "AppDelegate.h"
#import "Constant.h"
#import "Reachability.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "PurchaseDBClass.h"
#import "ActivityLogDBClass.h"

@interface RedeemDetailViewController ()

@end

@implementation RedeemDetailViewController

@synthesize userProfileImage;
@synthesize buyBtn;
@synthesize pointsTotal;
@synthesize pkgTitle;
@synthesize pkgAmount;
@synthesize pkgPoints;
@synthesize pkgId;

@synthesize userNameLbl;
@synthesize totalPointsLbl;
@synthesize totalPointStarLbl;
@synthesize pkgTitleLbl;
@synthesize pkgAmountLbl;
@synthesize pkgPointsLbl;
@synthesize pkgImgView;
@synthesize pkgImg;
@synthesize pkgdurationType;
@synthesize pkgObj;
@synthesize scrollView;
@synthesize containerView;
@synthesize redeemBtn;

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
    
    DBConnectionClass *dbCon=[[DBConnectionClass alloc]init];
    self.userNameLbl.text=[NSString stringWithFormat:@"Hello %@ ",[dbCon getFirstName]];
    
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@pointdetailjson.php?userid=%@&format=json&num=10",tanningDelegate.hostString,[dbCon getUserName]] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    pointDetailConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    NSLog(@"%@",theRequest);
    if (pointDetailConnection) {
        // Inform the user that the download failed.
        pointDataArray=[[NSMutableData alloc ]init];
        
        //  [recievedData writeToFile:path atomically:YES];
        NSLog(@"JSON download youtube");
    }
    else {
        NSLog(@"JSON download fail");
    }
    
    //***********************************************************************//
    
    pkgAmountLbl.text=[NSString stringWithFormat:@"$%@ value",pkgAmount];
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString: pkgAmountLbl.attributedText];
    [text addAttribute: NSForegroundColorAttributeName value: [UIColor whiteColor] range: NSMakeRange(0, pkgAmountLbl.text.length-1-5)];
    [pkgAmountLbl setAttributedText: text];
    
    pkgPointsLbl.text=[NSString stringWithFormat:@"%@ pts",pkgPoints];
    
    pkgTitleLbl.text=pkgTitle ;
    [buyBtn setTitle:[NSString stringWithFormat:@"%@ pts",pkgPoints] forState:UIControlStateNormal];
    //************************************************************************//
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath=[NSString stringWithFormat:@"%@/upload/%@",docDir,pkgObj.imgName];
    pkgImgView.image=[UIImage imageWithContentsOfFile:filePath];
    
    //scrollView.contentSize=CGSizeMake(320, 480);
    
    if ([[UIScreen mainScreen] bounds].size.height<=480) {
        containerView.frame=CGRectMake(containerView.frame.origin.x, totalPointStarLbl.frame.origin.y+110, containerView.frame.size.width, containerView.frame.size.height);
        redeemBtn.frame=CGRectMake(redeemBtn.frame.origin.x, containerView.frame.origin.y+containerView.frame.size.height+5, redeemBtn.frame.size.width, redeemBtn.frame.size.height);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        
        DBConnectionClass *dbCon=[[DBConnectionClass alloc]init];
        
        NSString *responseString = [[NSString alloc] initWithData:pointDataArray encoding:NSUTF8StringEncoding];
        // [responseData release];
        
        NSLog(@"responseString %@",responseString);
        
        NSError *error;
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSMutableDictionary *jsonDictionary = [parser objectWithString:responseString error:nil];
        
        NSArray *nodes = (NSArray*)[jsonDictionary objectForKey:@"posts"];
        
        for (NSDictionary *node in nodes){
            
            NSLog(@"NSDictionary %@", [(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"fbpoint"]);
            NSLog(@"NSDictionary %@", [(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"twpoint"]);
            NSLog(@"NSDictionary %@", [(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"istpoint"]);
            NSLog(@"NSDictionary %@", [(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"fourpoint"]);
            NSLog(@"NSDictionary %@", [(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"swpoint"]);
            
            pointsArray=[[NSMutableArray alloc]init];
            //[pointsArray removeAllObjects];
            
            [pointsArray addObject:[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"fbpoint"]];
            [pointsArray addObject:[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"twpoint"]];
            [pointsArray addObject:[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"istpoint"]];
            [pointsArray addObject:[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"fourpoint"]];
            [pointsArray addObject:[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"spinpoint"]];
            [pointsArray addObject:[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"totalpoint"]];
            
            [dbCon updatePoints:[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"fbpoint"] :[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"twpoint"] :[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"istpoint"] :[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"fourpoint"] :[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"spinpoint"] ];
        }
        [self totalPoints];
    }
}

-(void)totalPoints{
    int point=0;
    for (int i=0; i<[pointsArray count]; i++) {
        point=point+[[pointsArray objectAtIndex:i] integerValue];
    }
    
    totalPointsLbl.text=[NSString stringWithFormat:@"%d points",point];
    totalPointStarLbl.text=[NSString stringWithFormat:@"%d",point];
}

-(IBAction)redeemBtnClicked:(id)sender{
    
    if([tanningDelegate.dbClass connected])
    {
        if ([pkgPoints integerValue]>[totalPointStarLbl.text integerValue]) {
            
            RedeemPaymentViewController *reedemVC=[[RedeemPaymentViewController alloc]init];
            reedemVC.pkgObj=self.pkgObj;
            reedemVC.pkgTitle=pkgTitle ;
            reedemVC.pkgPoints=pkgPoints;
            reedemVC.pkgAmount=pkgAmount;
            reedemVC.pointsTotal=totalPointStarLbl.text;
            reedemVC.pkgdurationType=pkgdurationType;
            reedemVC.pkgId=pkgId;
            [self.navigationController pushViewController:reedemVC animated:YES];
        }
        else{
            
            //TODO
            
            if (![self connected]) {
                // not connected
                
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Network" message:@"No Network Found" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
            } else {
                // connected, do some internet stuff
                
                NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@updateAfterReedem.php?userid=%@&format=json&num=10&point=%d",tanningDelegate.hostString,[tanningDelegate.dbClass getUserName],[pkgPoints integerValue]] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
                NSURLConnection *updateReedemDetailConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
                
                NSLog(@"%@",theRequest);
                if (updateReedemDetailConnection) {
                    // Inform the user that the download failed.
                    pointDataArray=[[NSMutableData alloc ]init];
                    
                    //  [recievedData writeToFile:path atomically:YES];
                    NSLog(@"JSON download youtube");
                    
                    //Insert Purchase details
                    PurchaseDBClass *purchaseClass=[[PurchaseDBClass alloc]init];
                    purchaseClass.pkgTitle=pkgTitle;
                    purchaseClass.pkgId=pkgId;
                    purchaseClass.pkgDescription=@"ZENCIG";
                    purchaseClass.type=@"P";
                    purchaseClass.pkgAmount=pkgAmount;
                    
                    DBConnectionClass *dbCon=[[DBConnectionClass alloc]init];
                    [dbCon insertPurchaseDetails:purchaseClass];
                    float x = arc4random_uniform(10000000);
                    ActivityLogDBClass *activityClass=[[ActivityLogDBClass alloc]init];
                    activityClass.activityId=pkgId;
                    activityClass.activitytitle=@"Point Redeemption";
                    activityClass.username=[tanningDelegate.dbClass getUserName];
                    activityClass.socialtype=@"FR";
                    activityClass.activitytype=@"R";
                    activityClass.activitydate=[NSString stringWithFormat:@"%@",[tanningDelegate.dbClass FormattedDateFromDate:[tanningDelegate.dbClass dateFromString:tanningDelegate.currentServerTime]]];
                    activityClass.expiredate=[NSString stringWithFormat:@"%@",[tanningDelegate.dbClass FormattedDateFromDate:[tanningDelegate.dbClass dateFromString:tanningDelegate.currentServerTime]]];
                    activityClass.amount=@"0";
                    activityClass.point=pkgPoints;
                    activityClass.status=@"A";
                    [tanningDelegate.dbClass insertActivityData:activityClass];
                    
                    //Add activity to server
                    
                    NSURLRequest *activityRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@ActivityLog.php?activityId=%@&userid=%@&firstname=%@&lastname=%@&socialtype=FR&activitytype=R&activitytitle='Point Redeemption'&activitydate=%@&expiredate=%@&amount=0&redeempoint=%@&status=A",tanningDelegate.hostString,pkgId,[tanningDelegate.dbClass getUserName],[tanningDelegate.dbClass getFirstName],[tanningDelegate.dbClass getLastName],[tanningDelegate.dbClass FormattedDateFromDate:[NSDate date]],[tanningDelegate.dbClass FormattedDateFromDate:[[NSDate date] dateByAddingTimeInterval:7*24*60*60]],pkgPoints] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
                    NSURLConnection *activityDetailConnection = [[NSURLConnection alloc] initWithRequest:activityRequest delegate:self];
                    
                    NSLog(@"%@",[[NSString stringWithFormat:@"%@ActivityLog.php?activityId=%@&userid=%@&firstname=%@&lastname=%@&socialtype=FR&activitytype=R&activitytitle=Point Redeemption&activitydate=%@&expiredate=%@&amount=0&redeempoint=%@&status=A",tanningDelegate.hostString,[NSString stringWithFormat:@"%f",x],[tanningDelegate.dbClass getUserName],[tanningDelegate.dbClass getFirstName],[tanningDelegate.dbClass getLastName],[NSDate date],[[NSDate date] dateByAddingTimeInterval:7*24*60*60],totalPointStarLbl.text] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]);
                    
                    if (activityDetailConnection) {
                        
                    }
                    else{
                        
                    }
                    
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Congratulation!" message:[NSString stringWithFormat:@" You redeem %@ for this package.",pkgPoints ] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
                    [alert show];
                    
                    //Log Package details to server
                    
                    NSURLRequest *pkgRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@MonthlyPackageService.php?userid=%@&firstname=%@&lastname=%@&pkgtitle=%@&pkgdesc=%@&amount=%@&point=%@&pkgType=%@&pkgId=%@",tanningDelegate.hostString,[tanningDelegate.dbClass getUserName],[tanningDelegate.dbClass getFirstName],[tanningDelegate.dbClass getLastName],pkgTitle,@"ZENCIG",pkgAmount,pkgPoints,pkgdurationType,pkgObj.pkgID] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
                    NSURLConnection *pkgPurchaseDetailConnection = [[NSURLConnection alloc] initWithRequest:pkgRequest delegate:self];
                    
                    NSLog(@"MonthlyPackageService %@",pkgRequest);
                    //End of log server
                    if (pkgPurchaseDetailConnection) {
                        
                        NSLog(@"Package detials logged successfully");
                    }
                }
                else {
                    NSLog(@"JSON download fail");
                }
                
            }
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else{
        
        [tanningDelegate.dbClass showNetworkALert];
    }
}

- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}

-(IBAction)backBtnClicked:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
