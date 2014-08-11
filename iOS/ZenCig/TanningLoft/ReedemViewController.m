//
//  ReedemViewController.m
//  TanningLoft
//
//  Created by Lavi on 09/05/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "ReedemViewController.h"
#import "RedeemCell.h"
#import "AppDelegate.h"
#import "Constant.h"

#warning "Enter your credentials"
#define kPayPalClientId @"AUzlcBCPJc1ZdGhycnGFaYu9aoS7CdOdnU7BXz2miSvs6EkfRgFypaSQajVn"
#define kPayPalReceiverEmail @"meetlavi6@gmail.com"
#define kPayPalEnvironment PayPalEnvironmentNoNetwork
NSInteger indexCounter;
@interface ReedemViewController ()
{
    NSMutableArray *pkgTitleArray;
    DBConnectionClass *dbConn;
    PackageDetailDBClass *pkgClass;
}
@property(nonatomic, strong, readwrite) PayPalConfiguration *payPalConfig;
@property (nonatomic, assign) BOOL wrap;
@property (nonatomic, retain) NSMutableArray *items;
@property(assign,nonatomic)NSInteger cauroselCurrentIndex;

@end

@implementation ReedemViewController
@synthesize carousel,wrap,items,cauroselCurrentIndex;

@synthesize packageDescription,segemntControl;
@synthesize redeemTblVw;
@synthesize upBtn,downBtn;
@synthesize titleLbl,valueLbl,valueTitle,pointsLbl,descLbl,redeemBtn,tempvw;
@synthesize scrollView;

-(void)viewDidAppear:(BOOL)animated{
 
    //scrollView.contentSize=CGSizeMake(320, 510);
    
    // Customize the title text for *all* UINavigationBars
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor colorWithRed:16.0/255.0 green:16.0/255.0 blue:16.0/255.0 alpha:1.0],
      UITextAttributeTextColor,
      [UIColor colorWithRed:16.0/255.0 green:16.0/255.0 blue:16.0/255.0 alpha:0.2],
      UITextAttributeTextShadowColor,
      [NSValue valueWithUIOffset:UIOffsetMake(0, -1)],
      UITextAttributeTextShadowOffset,
      [UIFont fontWithName:@"Avenir" size:20.0],
      UITextAttributeFont,
      nil]];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:16.0/255.0 green:16.0/255.0 blue:16.0/255.0 alpha:1.0], NSForegroundColorAttributeName,nil]];
    
    if ([[UIScreen mainScreen] bounds].size.height<=480) {
        pointsLbl.frame=CGRectMake(50, pointsLbl.frame.origin.y, pointsLbl.frame.size.width, pointsLbl.frame.size.height);
        valueTitle.frame=CGRectMake(150, 283, valueTitle.frame.size.width, valueTitle.frame.size.height);
        valueLbl.frame=CGRectMake(140+valueTitle.frame.size.width, 283, valueLbl.frame.size.width, valueLbl.frame.size.height);
        descLbl.hidden=YES;
        redeemBtn.frame=CGRectMake(redeemBtn.frame.origin.x, pointsLbl.frame.origin.y+30, redeemBtn.frame.size.width, redeemBtn.frame.size.height);
    }
}

-(void)viewWillAppear:(BOOL)animated{

    indexCounter=0;
    dbConn=[[DBConnectionClass alloc]init];
    packageDescription=[[NSMutableArray alloc]init];
    packageDescription=[dbConn fetchPackageDetail:@""];
    
    
    if (packageDescription.count) {
        upBtn.enabled=TRUE;
        downBtn.enabled=TRUE;
    }
    else{
        upBtn.enabled=FALSE;
        downBtn.enabled=FALSE;
    }
    
    // Optimization: Prepare for display of the payment UI by getting network work done early
   // [PayPalPaymentViewController setEnvironment:self.environment];
   // [PayPalPaymentViewController prepareForPaymentUsingClientId:kPayPalClientId];
    
    segemntControl.frame=CGRectMake(10, 0, 300, 44);
    [[UISegmentedControl appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Arial-BoldMT" size:14.0], UITextAttributeFont, nil] forState:UIControlStateNormal];
    
    for (int i=0; i<[segemntControl.subviews count]; i++)
    {
        if ([[segemntControl.subviews objectAtIndex:i] respondsToSelector:@selector(isSelected)] && [[segemntControl.subviews objectAtIndex:i]isSelected])
        {
            [[segemntControl.subviews objectAtIndex:i] setTintColor:[UIColor colorWithRed:161/255.0 green:99/255.0 blue:216/255.0 alpha:1.0]];
        }
        if ([[segemntControl.subviews objectAtIndex:i] respondsToSelector:@selector(isSelected)] && ![[segemntControl.subviews objectAtIndex:i] isSelected])
        {
            [[segemntControl.subviews objectAtIndex:i] setTintColor:[UIColor blackColor]];
        }
    }
   // [self.redeemTblVw reloadData];
    
    [carousel reloadData];
    
    pkgClass=[packageDescription objectAtIndex:carousel.currentItemIndex];
    titleLbl.text=pkgClass.pkgTitle;
    pointsLbl.text=[NSString stringWithFormat:@"%@ points",pkgClass.pkgPoints];
    valueLbl.text=[NSString stringWithFormat:@"$%@ CAD",pkgClass.pkgAmount];
    descLbl.text=pkgClass.pkgDescription;
    redeemBtn.tag=index;
    
    [descLbl sizeToFit];
    descLbl.frame=CGRectMake((self.view.bounds.size.width-280)/2, descLbl.frame.origin.y, 280, descLbl.frame.size.height);
    
   
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUp
{
    //set up data
    wrap = YES;
    self.items = [NSMutableArray array];
    for (int i = 0; i < 3; i++)
    {
        [items addObject:[NSNumber numberWithInt:i]];
    }
   
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
    {
        self.title = NSLocalizedString(@"Redeem", @"Redeem");
        //self.tabBarItem.image = [UIImage imageNamed:@"reedem"];
        self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:230.0/255.0 green:226.0/255.0 blue:225.0/255.0 alpha:1.0];
         self.navigationItem.title=@"Redeem";
        
        [self setUp];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder]))
    {
        [self setUp];
    }
    return self;
}

- (void)dealloc
{
    //it's a good idea to set these to nil here to avoid
    //sending messages to a deallocated viewcontroller
    carousel.delegate = nil;
    carousel.dataSource = nil;
    //
    //    [carousel release];
    //    [navItem release];
    //    [orientationBarItem release];
    //    [wrapBarItem release];
    //    [items release];
    // [super dealloc];
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:230.0/255.0 green:226.0/255.0 blue:225.0/255.0 alpha:1.0];
    
    // Customize the title text for *all* UINavigationBars
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor whiteColor],
      UITextAttributeTextColor,
      [UIColor colorWithRed:79.0/255.0 green:143.0/255.0 blue:201.0/255.0 alpha:0.2],
      UITextAttributeTextShadowColor,
      [NSValue valueWithUIOffset:UIOffsetMake(0, -1)],
      UITextAttributeTextShadowOffset,[UIFont fontWithName:@"Avenir" size:20],UITextAttributeFont,
      nil]];
    
    
    cauroselCurrentIndex=0;
    
    //configure carousel
    carousel.type = iCarouselTypeCoverFlow2;
    carousel.scrollSpeed = 0.05f;
    //navItem.title = @"CoverFlow2";
    
    self.carousel.clipsToBounds = YES; //This is main point
    
    //[self toggleOrientation];
    
    self.carousel.vertical=NO;
    
    self.acceptCreditCards = YES;
    self.environment = PayPalEnvironmentNoNetwork;
    // Do any additional setup after loading the view, typically from a nib.
    
    //self.successView.hidden = YES;
    
    _payPalConfig = [[PayPalConfiguration alloc] init];
    _payPalConfig.acceptCreditCards = YES;
    _payPalConfig.languageOrLocale = @"en";
    _payPalConfig.merchantName = @"WeedBeacon, Inc.";
    _payPalConfig.merchantPrivacyPolicyURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/privacy-full"];
    _payPalConfig.merchantUserAgreementURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/useragreement-full"];
    _payPalConfig.languageOrLocale = [NSLocale preferredLanguages][0];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    //self.successView.hidden = YES;
    
    // use default environment, should be Production in real life
    self.environment = kPayPalEnvironment;

    
    NSLog(@"PayPal iOS SDK version: %@", [PayPalMobile libraryVersion]);
    
    self.navigationController.navigationBar.clipsToBounds = YES;
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;   // iOS 7 specific
    self.navigationController.navigationBar.translucent = NO;
 
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    self.carousel = nil;
    //    self.navItem = nil;
    //    self.orientationBarItem = nil;
    //    self.wrapBarItem = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
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
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320.0f, 240.0)];
        ((UIImageView *)view).image = [UIImage imageWithContentsOfFile:filePath];
        view.contentMode = UIViewContentModeScaleToFill;
        
        sliderImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320.0f, 240.0)];
        sliderImg.backgroundColor = [UIColor clearColor];
        sliderImg.tag = 1;
        [view addSubview:sliderImg];
    }
    else
    {
        //get a reference to the label in the recycled view
        sliderImg = (UIImageView *)[view viewWithTag:1];
    }
    
    
    NSLog(@"%@ &&& %@ currentIndex %d filepath %@",pkgClass.pkgTitle,pkgClass.pkgImagePath,index,filePath);
    
    tempvw.image=[UIImage imageWithContentsOfFile:filePath];
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
    
   // cauroselCurrentIndex= carousel.currentItemIndex;
    
}

- (void)toggleOrientation
{
    //carousel orientation can be animated
    [UIView beginAnimations:nil context:nil];
    carousel.vertical = !carousel.vertical;
    [UIView commitAnimations];
    
    //update button
    // orientationBarItem.title = carousel.vertical? @"Vertical": @"Horizontal";
}

-(IBAction)changeSection:(id)sender{
    
    if (packageDescription.count-1==indexCounter) {
        indexCounter=packageDescription.count-1;
    }
    else{
        ++indexCounter;
    }
    
    [redeemTblVw scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:indexCounter inSection:0]
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
    [redeemTblVw scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:indexCounter inSection:0]
                   atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

-(IBAction)buyButtonClicked:(id)sender{
    
    UIButton *btn=(UIButton *)sender;
    
    NSLog(@"btn %d",btn.tag);
    
    // Remove our last completed payment, just for demo purposes.
    self.completedPayment = nil;
    
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    payment.amount = [[NSDecimalNumber alloc] initWithString:@"1.00"];
    payment.currencyCode = @"USD";
    payment.shortDescription = @"ZENCIG";
    
    if (!payment.processable) {
        // This particular payment will always be processable. If, for
        // example, the amount was negative or the shortDescription was
        // empty, this payment wouldn't be processable, and you'd want
        // to handle that here.
    }
    
    // Any customer identifier that you have will work here. Do NOT use a device- or
    // hardware-based identifier.
    NSString *customerId = @"user-11723";
    
    // Set the environment:
    // - For live charges, use PayPalEnvironmentProduction (default).
    // - To use the PayPal sandbox, use PayPalEnvironmentSandbox.
    // - For testing, use PayPalEnvironmentNoNetwork.
    PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment
                                                                                                configuration:self.payPalConfig
                                                                                                     delegate:self];
    [self presentViewController:paymentViewController animated:YES completion:nil];

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
}

- (void)payPalPaymentDidCancel {
    NSLog(@"PayPal Payment Canceled");
    self.completedPayment = nil;
   // self.successView.hidden = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma SegmentControl on value change

- (IBAction)segmentedControlValueChanged:(UISegmentedControl*)sender
{
    for (int i=0; i<[sender.subviews count]; i++)
    {
        if ([[sender.subviews objectAtIndex:i] respondsToSelector:@selector(isSelected)] && [[sender.subviews objectAtIndex:i]isSelected])
        {
            [[sender.subviews objectAtIndex:i] setTintColor:[UIColor colorWithRed:161/255.0 green:99/255.0 blue:216/255.0 alpha:1.0]];
        }
        if ([[sender.subviews objectAtIndex:i] respondsToSelector:@selector(isSelected)] && ![[sender.subviews objectAtIndex:i] isSelected])
        {
            [[sender.subviews objectAtIndex:i] setTintColor:[UIColor blackColor]];
        }
    }
}

-(IBAction)redeemButtonClicked:(id)sender{
    
    UIButton *btn=(UIButton *)sender;
    
    pkgClass=[[PackageDetailDBClass alloc]init];
    pkgClass=[packageDescription objectAtIndex:carousel.currentItemIndex];
    
    RedeemDetailViewController *reedemVC=[[RedeemDetailViewController alloc]init];
    reedemVC.pkgObj=pkgClass;
    reedemVC.pkgId=pkgClass.pkgID;
    reedemVC.pkgTitle=pkgClass.pkgTitle ;
    reedemVC.pkgPoints=pkgClass.pkgPoints;
    reedemVC.pkgAmount=pkgClass.pkgAmount;
    reedemVC.pkgdurationType=pkgClass.pkgDurationType;
    [self.navigationController pushViewController:reedemVC animated:YES];
    reedemVC.pkgImgView.image=[UIImage imageNamed:pkgClass.pkgImagePath];
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath=[NSString stringWithFormat:@"%@/upload/%@",docDir,pkgClass.imgName];
    reedemVC.pkgImgView.image=[UIImage imageWithContentsOfFile:filePath];
   
}

#pragma mark UItableView delegate

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
    
    RedeemCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"RedeemCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
        [ cell.pkgRedeemBtn addTarget:self action:@selector(redeemButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    // Here we use the provided setImageWithURL: method to load the web image
    // Ensure you use a placeholder image otherwise cells will be initialized with no image
    //   // [cell.imageView setImageWithURL:[NSURL URLWithString:@"http://example.com/image.jpg"]
    //                   placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    PackageDetailDBClass *pkgClass=[[PackageDetailDBClass alloc]init];
    pkgClass=[packageDescription objectAtIndex:indexPath.row];
    cell.pkgTitle.text=pkgClass.pkgTitle;
    //NSLog(@"[packageDescription objectAtIndex:0] %@",[packageDescription objectAtIndex:0]);
    // descriptionTxtView.text=[packageDescription objectAtIndex:index];
    cell.pkgAmount.text=[NSString stringWithFormat:@"$%@ value",pkgClass.pkgAmount];
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString: cell.pkgAmount.attributedText];
    [text addAttribute: NSForegroundColorAttributeName value: [UIColor colorWithRed:161/255.0 green:99/255.0 blue:216/255.0 alpha:1.0] range: NSMakeRange(0, cell.pkgAmount.text.length-1-5)];
    [cell.pkgAmount setAttributedText: text];
    
    [cell.pkgPointBtn setTitle:[NSString stringWithFormat:@"%@ pts",pkgClass.pkgPoints] forState:UIControlStateNormal];
    //cell.pkgImg.image=[UIImage imageNamed:[NSString stringWithFormat:@"bed%d",indexPath.row+1]];
    
     NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath=[NSString stringWithFormat:@"%@/upload/%@",docDir,pkgClass.imgName];
    cell.pkgImg.image=[UIImage imageWithContentsOfFile:filePath];
    cell.pkgRedeemBtn.tag=indexPath.row;
    return cell;
}


@end
