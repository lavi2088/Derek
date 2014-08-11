//
//  ShopViewController.m
//  TanningLoft
//
//  Created by Lavi on 14/05/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "ShopViewController.h"
#import "CustomCellOfShopViewControllerCell.h"
#import "ShopCustomCell.h"
#import "Constant.h"
#import "AppDelegate.h"

@interface ShopViewController ()

@end

@implementation ShopViewController
@synthesize shopTbl;
@synthesize upwardBtn,downwardBtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title=@"Our Beds";
        
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
    pictureNameArray=[[NSMutableArray alloc]init];
    [pictureNameArray addObject:@"bed1"];
    [pictureNameArray addObject:@"bed2"];
    [pictureNameArray addObject:@"bed3"];
    
    labelArray=[[NSMutableArray alloc]init];
    [labelArray addObject:@"Level 3"];
    [labelArray addObject:@"Level 4"];
    [labelArray addObject:@"Level 5"];
    
    propertiesArray=[[NSMutableArray alloc]init];
    [propertiesArray addObject:@"ERGOLIN ADVANTAGE 400 MAXIMUM EXPOSURE 15 MINUTES"];
    [propertiesArray addObject:@"SUNDASH 252 RADIUS EXPOSURE 12 MINUTES"];
    [propertiesArray addObject:@"ERGOLIN ADVANTAGE 400 MAXIMUM EXPOSURE 12 MINUTES"];
    
    packageDescription=[[NSMutableArray alloc]init];
    [packageDescription addObject:@"The advantage 400 ensures the highest tanning results with a perfect combination of 3 VIT Max high-pressure facials, 40 Turbo Power tanning lamps and a reflex neck tanner. In addition, its comfort Colling ventilation, with cool air coming from facial and body zone outlets, is infinitely variable and keeps clients feeling fresh durning the tanning session."];
    [packageDescription addObject:@"TheSundash 252 Radius is equipped with 52, 2-meter SHO-RUVA tanning lamps.It delivers a beautifully even, full-body tan in a 12- minute exposure schedule for those tanners who are on the go. With an open aair tanning environment the Sundash offers over 6.5 feet of vertical tanning power."];
    [packageDescription addObject:@"The advantage 400 ensures the highest tanning results with a perfect combination of 3 VIT Max high-pressure facials, 40 Turbo Power tanning lamps and a reflex neck tanner. In addition, its comfort Colling ventilation, with cool air coming from facial and body zone outlets, is infinitely variable and keeps clients feeling fresh durning the tanning session."];
    
    indexCounter=0;
    
    packageDescription=[[NSMutableArray alloc]init];
    packageDescription=[tanningDelegate.dbClass fetchPackageDetail:@"B"];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;   // iOS 7 specific
    self.navigationController.navigationBar.translucent = NO;
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
    
    return 270;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [packageDescription count];    //count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"Cell";
    
    ShopCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ShopCustomCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    // Here we use the provided setImageWithURL: method to load the web image
    // Ensure you use a placeholder image otherwise cells will be initialized with no image
    //   // [cell.imageView setImageWithURL:[NSURL URLWithString:@"http://example.com/image.jpg"]
    //                   placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    PackageDetailDBClass *pkgClass=[[PackageDetailDBClass alloc]init];
    pkgClass=[packageDescription objectAtIndex:indexPath.row];
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath=[NSString stringWithFormat:@"%@/upload/%@",docDir,pkgClass.imgName];
    cell.imageVw.image=[UIImage imageWithContentsOfFile:filePath];
    cell.lbl1.text=[[pkgClass.pkgTitle componentsSeparatedByString:@"$^^^$"] objectAtIndex:0];
    cell.txtView1.text=[[pkgClass.pkgTitle componentsSeparatedByString:@"$^^^$"] objectAtIndex:1];
    cell.txtView2.text=pkgClass.pkgDescription;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
//    if (indexPath.row==0) {
//        ShopViewController *sc=[[ShopViewController alloc]init];
//        
//        [self.navigationController pushViewController:sc animated:YES];
//        
//    }
//    
//    else if (indexPath.row==1) {
//        ContactInfoViewController *vc=[[ContactInfoViewController alloc]init];
//        
//        [self.navigationController pushViewController:vc animated:YES];
//        
//    }
}

-(IBAction)upwardButtonClicked:(id)sender{
    
    if (indexCounter>0) {
        --indexCounter;
    }
    else{
        indexCounter=0;
    }
    [shopTbl scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:indexCounter inSection:0]
                   atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

-(IBAction)downwardButtonClicked:(id)sender{
    
    if (pictureNameArray.count-1==indexCounter) {
        indexCounter=pictureNameArray.count-1;
    }
    else{
        ++indexCounter;
    }
    
    [shopTbl scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:indexCounter inSection:0]
                     atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    
}

-(IBAction)backBtnClicked:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
