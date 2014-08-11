//
//  SettingViewController.m
//  TanningLoft
//
//  Created by Lavi on 23/06/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "SettingViewController.h"
#import "PurchaseTanDetailViewController.h"
#import "MyPurchaseCell.h"
#import "AppDelegate.h"
#import "Constant.h"
@interface SettingViewController ()

@end

@implementation SettingViewController

@synthesize myPurchaseTbl;
@synthesize myVoucherTbl;
@synthesize myPurchaseArray;
@synthesize myVoucherArray;
@synthesize purchaseTan;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.navigationItem.title=@"My Account";
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchDown];
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
    
    DBConnectionClass *dbConn=[[DBConnectionClass alloc]init];
    
     myVoucherArray=[dbConn fetchPurchaseDetail:@"V"];
     myPurchaseArray=[dbConn fetchExpiredPurchase];
    
    self.navigationItem.backBarButtonItem.title=@"Back";
    
    [self.myPurchaseTbl reloadData];
    [self.myVoucherTbl reloadData];
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
    
    return 46;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(tableView==myPurchaseTbl)
        return [myPurchaseArray count];    //count number of row from counting array hear cataGorry is An Array
    else
        return [myVoucherArray count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"Cell";
    
    MyPurchaseCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MyPurchaseCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
    }

    PurchaseDBClass *purchaseClass=[[PurchaseDBClass alloc]init];
    if(tableView==myPurchaseTbl){
        purchaseClass=[myPurchaseArray objectAtIndex:indexPath.row];
        cell.expireLbl.text=@"expired";
    }
    else{
        purchaseClass=[myVoucherArray objectAtIndex:indexPath.row];
        cell.expireLbl.text=@"expires";
    }
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss +SSSS"];

    
    NSDate *activityFormatDate=[formatter dateFromString:purchaseClass.AddedDate];
    NSDate *expireFormatDate=[formatter dateFromString:purchaseClass.ExpireDate];
    
    [formatter setDateFormat:@"MMM"];
    
    cell.monthLbl.text=[formatter stringFromDate:activityFormatDate];
    cell.titleLbl.text=[NSString stringWithFormat:@"%@",purchaseClass.pkgTitle ];
    
    [formatter setDateFormat:@"MMM dd"];
    cell.dateLbl.text=[formatter stringFromDate:expireFormatDate];
  
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PurchaseDBClass *purchaseClass=[[PurchaseDBClass alloc]init];
     if(tableView==myPurchaseTbl){
         purchaseClass=[myPurchaseArray objectAtIndex:indexPath.row];
     }
     else{
          purchaseClass=[myVoucherArray objectAtIndex:indexPath.row];
     }
    
    self.purchaseTan=[[PurchaseTanDetailViewController alloc]init];
    purchaseTan.purchaseClass=purchaseClass;
    [self.navigationController pushViewController:purchaseTan animated:YES];
}

-(IBAction)backButtonClicked:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
