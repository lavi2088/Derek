//
//  MessageViewController.m
//  MyMobiPoints
//
//  Created by Macmini on 14/12/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageCell.h"
#import "MessageWebService.h"
#import "GetServerCurrentTimeWebService.h"
#import "CongratulationViewController.h"

@interface MessageViewController ()

@end

@implementation MessageViewController
@synthesize messageArray,messageTbl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.navigationItem.title=@"Messages";
        
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
    
    GetServerCurrentTimeWebService *getSer=[[GetServerCurrentTimeWebService alloc]init];
    
    [getSer callCurrentServerTimeService];
    messageArray=[[NSMutableArray alloc]init];
    messageArray=[tanningDelegate.dbClass fetchMessageDetails];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;   // iOS 7 specific
    self.navigationController.navigationBar.translucent = NO;
}

-(void)viewWillAppear:(BOOL)animated{

    MessageWebService *msgService=[[MessageWebService alloc]init];
    
    [msgService callCurrentServerTimeService];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UItableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 115;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return messageArray.count;    //count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"Cell";
    
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MessageCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
        //[ cell.pkgRedeemBtn addTarget:self action:@selector(redeemButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    MessageDBClass *msgObj=[[MessageDBClass alloc]init];
    msgObj=[messageArray objectAtIndex:indexPath.row];
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *tempdate=[formatter dateFromString:msgObj.date];
    
    [formatter setDateFormat:@"hh:mm a, MMM dd yyyy"];
    
    cell.dateLbl.text=[formatter stringFromDate:tempdate];
    cell.titleTbl.text=msgObj.title;
    cell.viewOfferBtn.tag=indexPath.row;
    [cell.viewOfferBtn addTarget:self action:@selector(viewOfferClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.crossBtn.tag=indexPath.row;
    [cell.crossBtn addTarget:self action:@selector(deleteMessageClicked:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

-(IBAction)backBtnClicked:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)reloadMessageTbl{
    messageArray=[[NSMutableArray alloc]init];
    messageArray=[tanningDelegate.dbClass fetchMessageDetails];
    [self.messageTbl reloadData];
}

-(IBAction)viewOfferClicked:(id)sender{
    
    UIButton *tempbtn=(UIButton *)sender;
    
    CongratulationViewController *congVC=[[CongratulationViewController alloc]init];
    congVC.msgObj=[messageArray objectAtIndex:tempbtn.tag];
    [self.navigationController pushViewController:congVC animated:YES];
}

-(IBAction)deleteMessageClicked:(id)sender{
    
    UIButton *tempbtn=(UIButton *)sender;
    MessageDBClass *msgObj=[[MessageDBClass alloc]init];
    msgObj=[messageArray objectAtIndex:tempbtn.tag];
    
    [tanningDelegate.dbClass updateMessageStatus:@"0" :msgObj.msgid];
    
    messageArray=[[NSMutableArray alloc]init];
    messageArray=[tanningDelegate.dbClass fetchMessageDetails];
    [messageTbl reloadData];
}
@end
