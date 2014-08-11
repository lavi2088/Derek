//
//  MobileShopViewController.m
//  TanningLoft
//
//  Created by Lavi on 27/06/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "MobileShopViewController.h"
#import "PaypalPaymentWebViewViewController.h"

#warning "Enter your credentials"
#define kPayPalClientId @"AUzlcBCPJc1ZdGhycnGFaYu9aoS7CdOdnU7BXz2miSvs6EkfRgFypaSQajVn"
#define kPayPalReceiverEmail @"meetlavi6@gmail.com"
NSInteger indexCounter;
DBConnectionClass *dbConn;
@interface MobileShopViewController ()
{
    PackageDetailDBClass *pkgClass;
}
@property(assign,nonatomic)NSInteger cauroselCurrentIndex;
@end

@implementation MobileShopViewController
@synthesize packageDescription,segementControl;
@synthesize myShopTbl;
@synthesize carousel,pointsLbl,titleLbl,valueLbl,valueTitleLbl,descLbl,redeemBtn;
@synthesize cauroselCurrentIndex,tempvw,scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title=@"Mobile Shop";
        
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
    packageDescription=[[NSMutableArray alloc]init];
    
    dbConn=[[DBConnectionClass alloc]init];
    packageDescription=[[NSMutableArray alloc]init];
    packageDescription=[dbConn fetchPackageDetail:@""];
    
    indexCounter=0;
    
    cauroselCurrentIndex=0;
    
    //configure carousel
    carousel.type = iCarouselTypeCoverFlow2;
    carousel.scrollSpeed = 0.05f;
    //navItem.title = @"CoverFlow2";
    
    self.carousel.clipsToBounds = YES; //This is main point
    
    //[self toggleOrientation];
    
    self.carousel.vertical=NO;
    
    self.navigationController.navigationBar.clipsToBounds = YES;
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;   // iOS 7 specific
    self.navigationController.navigationBar.translucent = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    
    segementControl.frame=CGRectMake(10, 10, 300, 44);
    [[UISegmentedControl appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Arial-BoldMT" size:14.0], UITextAttributeFont, nil] forState:UIControlStateNormal];
    
    for (int i=0; i<[segementControl.subviews count]; i++)
    {
        if ([[segementControl.subviews objectAtIndex:i] respondsToSelector:@selector(isSelected)] && [[segementControl.subviews objectAtIndex:i]isSelected])
        {
            [[segementControl.subviews objectAtIndex:i] setTintColor:[UIColor colorWithRed:161/255.0 green:99/255.0 blue:216/255.0 alpha:1.0]];
        }
        if ([[segementControl.subviews objectAtIndex:i] respondsToSelector:@selector(isSelected)] && ![[segementControl.subviews objectAtIndex:i] isSelected])
        {
            [[segementControl.subviews objectAtIndex:i] setTintColor:[UIColor blackColor]];
        }
    }
    
    // Optimization: Prepare for display of the payment UI by getting network work done early
   // [PayPalPaymentViewController setEnvironment:self.environment];
    //[PayPalPaymentViewController prepareForPaymentUsingClientId:kPayPalClientId];
    
    [carousel reloadData];
    
    pkgClass=[packageDescription objectAtIndex:carousel.currentItemIndex];
    
    titleLbl.text=pkgClass.pkgTitle;
    pointsLbl.text=[NSString stringWithFormat:@"%@ points",pkgClass.pkgPoints];
    valueLbl.text=[NSString stringWithFormat:@"$%@ CAD",pkgClass.pkgAmount];
    descLbl.text=pkgClass.pkgDescription;
    redeemBtn.tag=index;
    [descLbl sizeToFit];
    descLbl.frame=CGRectMake((self.view.bounds.size.width-280)/2, descLbl.frame.origin.y, 280, descLbl.frame.size.height);
    
    if ([[UIScreen mainScreen] bounds].size.height<=480) {
        pointsLbl.frame=CGRectMake(50, pointsLbl.frame.origin.y, pointsLbl.frame.size.width, pointsLbl.frame.size.height);
        valueTitleLbl.frame=CGRectMake(150, pointsLbl.frame.origin.y, valueTitleLbl.frame.size.width, valueTitleLbl.frame.size.height);
        valueLbl.frame=CGRectMake(140+valueTitleLbl.frame.size.width-10, pointsLbl.frame.origin.y, valueLbl.frame.size.width, valueLbl.frame.size.height);
        descLbl.hidden=YES;
        redeemBtn.frame=CGRectMake(redeemBtn.frame.origin.x, pointsLbl.frame.origin.y+40, redeemBtn.frame.size.width, redeemBtn.frame.size.height);
    }
}

-(void)viewDidAppear:(BOOL)animated{
    
    segementControl.frame=CGRectMake(10, 10, 300, 44);
    [[UISegmentedControl appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Arial-BoldMT" size:14.0], UITextAttributeFont, nil] forState:UIControlStateNormal];
    
    for (int i=0; i<[segementControl.subviews count]; i++)
    {
        if ([[segementControl.subviews objectAtIndex:i] respondsToSelector:@selector(isSelected)] && [[segementControl.subviews objectAtIndex:i]isSelected])
        {
            [[segementControl.subviews objectAtIndex:i] setTintColor:[UIColor colorWithRed:161/255.0 green:99/255.0 blue:216/255.0 alpha:1.0]];
        }
        if ([[segementControl.subviews objectAtIndex:i] respondsToSelector:@selector(isSelected)] && ![[segementControl.subviews objectAtIndex:i] isSelected])
        {
            [[segementControl.subviews objectAtIndex:i] setTintColor:[UIColor blackColor]];
        }
    }
    
     //[PayPalPaymentViewController prepareForPaymentUsingClientId:kPayPalClientId];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UItableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 165;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [packageDescription count];    //count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"Cell";
    
    MobileShopCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MobileShopCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
        cell.pkgBuyBtn.tag=indexPath.row;
        [ cell.pkgBuyBtn addTarget:self action:@selector(buyBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    // Here we use the provided setImageWithURL: method to load the web image
    // Ensure you use a placeholder image otherwise cells will be initialized with no image
    //   // [cell.imageView setImageWithURL:[NSURL URLWithString:@"http://example.com/image.jpg"]
    //                   placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    pkgClass=[[PackageDetailDBClass alloc]init];
    pkgClass=[packageDescription objectAtIndex:indexPath.row];
    cell.pkgTitle.text=pkgClass.pkgTitle ;
    //NSLog(@"[packageDescription objectAtIndex:0] %@",[packageDescription objectAtIndex:0]);
    // descriptionTxtView.text=[packageDescription objectAtIndex:index];
    cell.pkgAmount.text=[NSString stringWithFormat:@"$%@ value",pkgClass.pkgAmount];
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString: cell.pkgAmount.attributedText];
    [text addAttribute: NSForegroundColorAttributeName value: [UIColor colorWithRed:161/255.0 green:99/255.0 blue:216/255.0 alpha:1.0] range: NSMakeRange(0, cell.pkgAmount.text.length-1-5)];
    [cell.pkgAmount setAttributedText: text];
    
    [cell.pkgPointBtn setTitle:[NSString stringWithFormat:@"%@ pts",pkgClass.pkgPoints] forState:UIControlStateNormal];
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath=[NSString stringWithFormat:@"%@/upload/%@",docDir,pkgClass.imgName];
    cell.pkgImg.image=[UIImage imageWithContentsOfFile:filePath];
    
    return cell;
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
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Payment Success" message:@"Payment Successfull" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alert show];
    
    //Insert Purchase details
    PurchaseDBClass *purchaseClass=[[PurchaseDBClass alloc]init];
    purchaseClass.pkgTitle=pkgClass.pkgDescription ;
    purchaseClass.pkgId=@"101";
    purchaseClass.pkgDescription=pkgClass.pkgDescription ;
    purchaseClass.type=@"P";
    purchaseClass.pkgAmount=pkgClass.pkgAmount;
    
    DBConnectionClass *dbCon=[[DBConnectionClass alloc]init];
    [dbCon insertPurchaseDetails:purchaseClass];
    float x = arc4random_uniform(10000000);
    ActivityLogDBClass *activityClass=[[ActivityLogDBClass alloc]init];
    activityClass.activityId=pkgClass.pkgID;
    activityClass.activitytitle=pkgClass.pkgDescription ;
    activityClass.username=[tanningDelegate.dbClass getUserName];
    activityClass.socialtype=@"FR";
    activityClass.activitytype=@"R";
    activityClass.activitydate=[NSString stringWithFormat:@"%@",[tanningDelegate.dbClass FormattedDateFromDate:[tanningDelegate.dbClass dateFromString:tanningDelegate.currentServerTime]]];
    activityClass.expiredate=[NSString stringWithFormat:@"%@",[tanningDelegate.dbClass FormattedDateFromDate:[tanningDelegate.dbClass dateFromString:tanningDelegate.currentServerTime]]];
    activityClass.amount=pkgClass.pkgAmount;
    activityClass.point=pkgClass.pkgPoints;
    activityClass.status=@"A";
    [tanningDelegate.dbClass insertActivityData:activityClass];
    
    //Add activity to server
    
    NSURLRequest *activityRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@ActivityLog.php?activityId=%@&userid=%@&firstname=%@&lastname=%@&socialtype=FR&activitytype=R&activitytitle=Point Redeemption&activitydate=%@&expiredate=%@&amount=0&redeempoint=%@&status=A",tanningDelegate.hostString,[NSString stringWithFormat:@"%@",pkgClass.pkgID],[tanningDelegate.dbClass getUserName],[tanningDelegate.dbClass getFirstName],[tanningDelegate.dbClass getLastName],[tanningDelegate.dbClass FormattedDateFromDate:[tanningDelegate.dbClass dateFromString:tanningDelegate.currentServerTime]],[tanningDelegate.dbClass FormattedDateFromDate:[[tanningDelegate.dbClass dateFromString:tanningDelegate.currentServerTime] dateByAddingTimeInterval:30*24*60*60]],@"0"] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    NSURLConnection *activityDetailConnection = [[NSURLConnection alloc] initWithRequest:activityRequest delegate:self];
    
    NSLog(@"%@",[[NSString stringWithFormat:@"%@ActivityLog.php?activityId=%@&userid=%@&firstname=%@&lastname=%@&socialtype=FR&activitytype=R&activitytitle=Point Redeemption&activitydate=%@&expiredate=%@&amount=%@&redeempoint=%@&status=A",tanningDelegate.hostString,[NSString stringWithFormat:@"%f",x],[tanningDelegate.dbClass getUserName],[tanningDelegate.dbClass getFirstName],[tanningDelegate.dbClass getLastName],[NSDate date],[[NSDate date] dateByAddingTimeInterval:7*24*60*60],pkgClass.pkgAmount,pkgClass.pkgPoints] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]);
    
    if (activityDetailConnection) {
        
    }
    else{
        
    }
    
    
}

- (void)payPalPaymentDidCancel {
    NSLog(@"PayPal Payment Canceled");
    self.completedPayment = nil;
    // self.successView.hidden = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)buyBtnClicked:(id)sender{
    
    UIButton *btn=(UIButton *)sender;
    
    pkgClass=[[PackageDetailDBClass alloc]init];
    pkgClass=[packageDescription objectAtIndex:carousel.currentItemIndex];
    
    PaypalPaymentWebViewViewController *paypalVC=[[PaypalPaymentWebViewViewController alloc] init];
    paypalVC.pkgObj=pkgClass;
    paypalVC.pointsTotal=@"0";
    paypalVC.totalPoint=@"0";
    
    if ([pkgClass.pkgDurationType isEqualToString:@"M"]) {
        paypalVC.webviewUrlString=[NSString stringWithFormat:@"%@paypal/subscription.php?id=%@&userid=%@&point=%@",tanningDelegate.hostString,pkgClass.pkgID,[tanningDelegate.dbClass getUserName],@"0"];
    }
    else{
        paypalVC.webviewUrlString=[NSString stringWithFormat:@"%@paypal/buy.php?id=%@&userid=%@&point=%@",tanningDelegate.hostString,pkgClass.pkgID,[tanningDelegate.dbClass getUserName],@""];
    }
    
    [self.navigationController pushViewController:paypalVC animated:YES];
    
}

-(IBAction)changeSection:(id)sender{
    
    //- (void)scrollToItemAtIndex:(NSInteger)index animated:(BOOL)animated;
    
    // [carousel scrollToItemAtIndex:cauroselCurrentIndex+1 animated:YES];
    
    if (packageDescription.count-1==indexCounter) {
        indexCounter=packageDescription.count-1;
    }
    else{
        ++indexCounter;
    }
    
    [myShopTbl scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:indexCounter inSection:0]
                       atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

-(IBAction)chnageSectionToUp:(id)sender{
    
    //[carousel scrollToItemAtIndex:cauroselCurrentIndex-1 animated:YES];
    if (indexCounter>0) {
        --indexCounter;
    }
    else{
        indexCounter=0;
    }
    [myShopTbl scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:indexCounter inSection:0]
                       atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

-(IBAction)backBtnClicked:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)segmentControlValueChnaged:(id)sender{
    
    for (int i=0; i<[segementControl.subviews count]; i++)
    {
        if ([[segementControl.subviews objectAtIndex:i] respondsToSelector:@selector(isSelected)] && [[segementControl.subviews objectAtIndex:i]isSelected])
        {
            [[segementControl.subviews objectAtIndex:i] setTintColor:[UIColor colorWithRed:161/255.0 green:99/255.0 blue:216/255.0 alpha:1.0]];
        }
        if ([[segementControl.subviews objectAtIndex:i] respondsToSelector:@selector(isSelected)] && ![[segementControl.subviews objectAtIndex:i] isSelected])
        {
            [[segementControl.subviews objectAtIndex:i] setTintColor:[UIColor blackColor]];
        }
    }
    
    if (segementControl.selectedSegmentIndex==0) {
        [packageDescription removeAllObjects];
        packageDescription=[dbConn fetchPackageDetail:@"P"];
    }
    else{
        [packageDescription removeAllObjects];
        packageDescription=[dbConn fetchPackageDetail:@"V"];
    }
    
    [myShopTbl reloadData];

}

#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [packageDescription count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    UIImageView *topBgImg;
    //create new view if no view is available for recycling
    topBgImg=(UIImageView *)view;
    
    pkgClass=[[PackageDetailDBClass alloc]init];
    pkgClass=[packageDescription objectAtIndex:(index % [self numberOfItemsInCarousel:carousel])];
    cauroselCurrentIndex=index % [self numberOfItemsInCarousel:carousel];
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath=[NSString stringWithFormat:@"%@/upload/%@",docDir,pkgClass.imgName];
    
    UIImageView *sliderImg;
    //create new view if no view is available for recycling
    if (view == nil)
    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320.0f, 245.0)];
        ((UIImageView *)view).image = [UIImage imageWithContentsOfFile:filePath];
        view.contentMode = UIViewContentModeScaleToFill;
        
        sliderImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320.0f, 245.0)];
        sliderImg.backgroundColor = [UIColor clearColor];
        sliderImg.tag = 1;
        [view addSubview:sliderImg];
    }
    else
    {
        //get a reference to the label in the recycled view
        sliderImg = (UIImageView *)[view viewWithTag:1];
    }
    
    
    
    titleLbl.text=pkgClass.pkgTitle;
    pointsLbl.text=[NSString stringWithFormat:@"%@ points",pkgClass.pkgPoints];
    valueLbl.text=[NSString stringWithFormat:@"$%@ CAD",pkgClass.pkgAmount];
    descLbl.text=pkgClass.pkgDescription;
    redeemBtn.tag=index;
    
    
    //sliderImg.image=[UIImage imageWithContentsOfFile:filePath];
    return view;
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel{
    
    pkgClass=[packageDescription objectAtIndex:carousel.currentItemIndex];
    
    titleLbl.text=pkgClass.pkgTitle;
    pointsLbl.text=[NSString stringWithFormat:@"%@ points",pkgClass.pkgPoints];
    valueLbl.text=[NSString stringWithFormat:@"$%@ CAD",pkgClass.pkgAmount];
    descLbl.text=pkgClass.pkgDescription;
    redeemBtn.tag=index;
    
    [descLbl sizeToFit];
    descLbl.frame=CGRectMake((self.view.bounds.size.width-280)/2, descLbl.frame.origin.y, 280, descLbl.frame.size.height);
   
}

- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
    //note: placeholder views are only displayed on some carousels if wrapping is disabled
    return 5;
}

- (UIView *)carousel:(iCarousel *)carousel placeholderViewAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200.0f, 200.0f)] ;
        ((UIImageView *)view).image = [UIImage imageNamed:@"page.png"];
        view.contentMode = UIViewContentModeCenter;
        
        label = [[UILabel alloc] initWithFrame:view.bounds] ;
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentCenter;
        label.font = [label.font fontWithSize:50.0f];
        label.tag = 1;
        [view addSubview:label];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    label.text = (index == 0)? @"[": @"]";
    
    return view;
}

- (CATransform3D)carousel:(iCarousel *)_carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    //implement 'flip3D' style carousel
    transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * carousel.itemWidth);
}

- (CGFloat)carousel:(iCarousel *)_carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            //normally you would hard-code this to YES or NO
            return YES;
        }
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
            return value * 1.05f;
        }
        case iCarouselOptionFadeMax:
        {
            if (carousel.type == iCarouselTypeCustom)
            {
                //set opacity based on distance from camera
                return 0.0f;
            }
            return value;
        }
        default:
        {
            return value;
        }
    }
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel{
    
    cauroselCurrentIndex= carousel.currentItemIndex;
    
    pkgClass=[[PackageDetailDBClass alloc]init];
    pkgClass=[packageDescription objectAtIndex:carousel.currentItemIndex];
    
   // redeemBtn.tag=cauroselCurrentIndex;
}

@end
