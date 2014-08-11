//
//  ActivityLogViewController.m
//  TanningLoft
//
//  Created by Lavi on 04/08/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "ActivityLogViewController.h"
#import "ActivityLogCell.h"
#import "AppDelegate.h"
#import "Constant.h"
#import "DBConnectionClass.h"
#import "ActivityLogDBClass.h"
#import "PurchaseTanDetailViewController.h"
#import "ActivitySocialDetailViewController.h"

@interface ActivityLogViewController ()
@property (strong,nonatomic) IBOutlet FBProfilePictureView *userProfileImage;
@property(nonatomic,retain)IBOutlet UILabel *username;
@property(nonatomic,retain)IBOutlet UILabel *memeberSince;
@end

@implementation ActivityLogViewController
@synthesize tblView,logArray;
@synthesize totalPoints;
@synthesize userProfileImage,username,memeberSince;

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
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    logArray=[[NSMutableArray alloc]init];
    logArray=[tanningDelegate.dbClass fetchAllActivitydata];
    
    pointsArray=[[NSMutableArray alloc]init];
    [pointsArray addObject:@"0"];
    [pointsArray addObject:@"0"];
    [pointsArray addObject:@"0"];
    [pointsArray addObject:@"0"];
    [pointsArray addObject:@"0"];
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@pointdetailjson.php?userid=%@&format=json&num=10",tanningDelegate.hostString,[tanningDelegate.dbClass getUserName]] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
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
    memeberSince.text=[NSString stringWithFormat:@"ZENCIG fan since %@ ",[dbCon getMemberSinceDate]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return logArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"Cell";
    
    ActivityLogCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ActivityLogCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
    }
    ActivityLogDBClass *activityDBClass=[[ActivityLogDBClass alloc]init];
    
    activityDBClass=[logArray objectAtIndex:indexPath.row];
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *activityFormatDate=[formatter dateFromString:activityDBClass.activitydate];
    NSDate *expireFormatDate=[formatter dateFromString:activityDBClass.expiredate];
    
    if ([activityDBClass.activitytype isEqualToString:@"S"]) {
        
        if ([activityDBClass.socialtype isEqualToString:@"F"]) {
            
            cell.socialImg.image=[UIImage imageNamed:@"facebookicon"];
        }
        else if([activityDBClass.socialtype isEqualToString:@"T"]){
            cell.socialImg.image=[UIImage imageNamed:@"twittericon"];
        }
        else if([activityDBClass.socialtype isEqualToString:@"I"]){
            cell.socialImg.image=[UIImage imageNamed:@"istagramicon"];
        }
        else if([activityDBClass.socialtype isEqualToString:@"FR"]){
            cell.socialImg.image=[UIImage imageNamed:@"foursquareicon"];
        }
        else if([activityDBClass.socialtype isEqualToString:@"SP"]){
            cell.socialImg.image=[UIImage imageNamed:@"spinTabIcon"];
        }
        else if([activityDBClass.socialtype isEqualToString:@"FREE"]){
            cell.socialImg.image=[UIImage imageNamed:@"spinTabIcon"];
        }
        
        cell.status.hidden=NO;
        
        if ([activityDBClass.status isEqualToString:@"A"]) {
            cell.status.text=@"Approved";
        }
        else if([activityDBClass.status isEqualToString:@"D"]){
            cell.status.text=@"Denied";
        }
        else if([activityDBClass.status isEqualToString:@"P"]){
            cell.status.text=@"Pending";
        }
        else{
            cell.status.hidden=YES;
        }
        cell.points.text=[NSString stringWithFormat:@"%@ pts",activityDBClass.point];
    }
    else{
        cell.status.hidden=YES;
        cell.socialImg.image=[UIImage imageNamed:@"redeemIcon"];
        cell.points.textColor=[UIColor redColor];
        cell.points.text=[NSString stringWithFormat:@"-%@ pts",activityDBClass.point];
    }
    [formatter setDateFormat:@"MMM dd yyyy"];
    cell.title.text=[activityDBClass.activitytitle stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
    cell.date.text=[formatter stringFromDate:activityFormatDate];
    
    
    if ([activityDBClass.activitytype isEqualToString:@"FREE"]) {
        cell.points.text=@"FREE";
    }
    //    CGSize textsize=[cell.title.text sizeWithFont:cell.title.font constrainedToSize:CGSizeMake(cell.title.frame.size.width, MAXFLOAT) lineBreakMode:cell.title.lineBreakMode];
    //    cell.title.frame=CGRectMake(50, 7, textsize.width, textsize.height);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ActivityLogDBClass *activityDBClass=[[ActivityLogDBClass alloc]init];
    
    activityDBClass=[logArray objectAtIndex:indexPath.row];
    
    if([activityDBClass.activitytype isEqualToString:@"R"])
    {
        PurchaseDBClass *purchaseClass=[[PurchaseDBClass alloc]init];
        
        if([tanningDelegate.dbClass fetchPurchaseDetailAccordingToID:activityDBClass.activityId].count)
        {
            purchaseClass=[[tanningDelegate.dbClass fetchPurchaseDetailAccordingToID:activityDBClass.activityId] objectAtIndex:0];
            
            PurchaseTanDetailViewController *purchaseTan=[[PurchaseTanDetailViewController alloc]init];
            purchaseTan.purchaseClass=purchaseClass;
            [self.navigationController pushViewController:purchaseTan animated:YES];
        }
    }
    else{
        if([activityDBClass.activitytype isEqualToString:@"S"] && ![activityDBClass.socialtype isEqualToString:@"SP"] && ![activityDBClass.socialtype isEqualToString:@"FREE"])
        {
        ActivitySocialDetailViewController *activitySocial=[[ActivitySocialDetailViewController alloc]init];
        activitySocial.postID=activityDBClass.activityId;
        [self.navigationController pushViewController:activitySocial animated:YES];
        }
        else if([activityDBClass.activitytype isEqualToString:@"S"] && [activityDBClass.socialtype isEqualToString:@"FREE"]){
            PurchaseDBClass *purchaseClass=[[PurchaseDBClass alloc]init];
            if([tanningDelegate.dbClass fetchPurchaseDetailAccordingToID:activityDBClass.activityId].count)
            {
            purchaseClass=[[tanningDelegate.dbClass fetchPurchaseDetailAccordingToID:activityDBClass.activityId] objectAtIndex:0];
            
            PurchaseTanDetailViewController *purchaseTan=[[PurchaseTanDetailViewController alloc]init];
            purchaseTan.purchaseClass=purchaseClass;
            [self.navigationController pushViewController:purchaseTan animated:YES];
            }
        }
        else{
            NSString *msg=[NSString stringWithFormat:@"%@ - Spin Wheel Win: %@ points",[tanningDelegate.dbClass dateFromStringWithMonthText:activityDBClass.activitydate],activityDBClass.point];
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Spin Wheel" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
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
            NSLog(@"NSDictionary %@", [(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"spinpoint"]);
            
            [pointsArray removeAllObjects];
            
            [pointsArray addObject:[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"fbpoint"]];
            [pointsArray addObject:[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"twpoint"]];
            [pointsArray addObject:[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"istpoint"]];
            [pointsArray addObject:[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"fourpoint"]];
            [pointsArray addObject:[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"spinpoint"]];
            [pointsArray addObject:[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"totalpoint"]];
            
            [tanningDelegate.dbClass updatePoints:[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"fbpoint"] :[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"twpoint"] :[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"istpoint"] :[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"fourpoint"] :[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"spinpoint"] ];
        }
        
        [self totalPointsofUser];
        
    }
    
}

-(void)totalPointsofUser{
    int point=0;
    for (int i=0; i<[pointsArray count]; i++) {
        point=point+[[pointsArray objectAtIndex:i] integerValue];
    }
    
    totalPoints.text=[NSString stringWithFormat:@"%d",point];
}

-(IBAction)backBtnClicked:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)reloadActivityLog{
    [logArray removeAllObjects];
    logArray=[tanningDelegate.dbClass fetchAllActivitydata];
    [tblView reloadData];
}
@end
