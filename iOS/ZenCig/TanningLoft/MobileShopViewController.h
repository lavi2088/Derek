//
//  MobileShopViewController.h
//  TanningLoft
//
//  Created by Lavi on 27/06/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PackageDetailDBClass.h"
#import "AppDelegate.h"
#import "Constant.h"
#import "MobileShopCell.h"
#import "DBConnectionClass.h"
#import "PayPalMobile.h"
#import "iCarousel.h"

@interface MobileShopViewController : UIViewController<PayPalPaymentDelegate>
@property(nonatomic,retain)NSMutableArray *packageDescription;
@property(nonatomic,retain)IBOutlet UISegmentedControl *segementControl;
@property(nonatomic, strong, readwrite) NSString *environment;
@property(nonatomic, assign, readwrite) BOOL acceptCreditCards;
@property(nonatomic, strong, readwrite) PayPalPayment *completedPayment;
@property(nonatomic,retain)IBOutlet UITableView *myShopTbl;

@property (nonatomic, retain) IBOutlet iCarousel *carousel;
@property(nonatomic,retain)IBOutlet UILabel *titleLbl;
@property(nonatomic,retain)IBOutlet UILabel *pointsLbl;
@property(nonatomic,retain)IBOutlet UILabel *valueLbl;
@property(nonatomic,retain)IBOutlet UILabel *valueTitleLbl;
@property(nonatomic,retain)IBOutlet UILabel *descLbl;
@property(nonatomic,retain)IBOutlet UIButton *redeemBtn;

@property(nonatomic,retain)IBOutlet UIImageView *tempvw;
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;

@end
