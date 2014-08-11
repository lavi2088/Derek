//
//  ReedemViewController.h
//  TanningLoft
//
//  Created by Lavi on 09/05/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "PayPalMobile.h"
#import "PointDetailDBClass.h"
#import "DBConnectionClass.h"
#import "RedeemDetailViewController.h"

@interface ReedemViewController : UIViewController<iCarouselDataSource, iCarouselDelegate,PayPalPaymentDelegate,UITableViewDataSource,UITableViewDelegate>
{
    iCarousel *carousel;
}
@property (nonatomic, retain) IBOutlet iCarousel *carousel;
@property(nonatomic,retain)NSMutableArray *packageDescription;
@property(nonatomic, strong, readwrite) NSString *environment;
@property(nonatomic, assign, readwrite) BOOL acceptCreditCards;
@property(nonatomic, strong, readwrite) PayPalPayment *completedPayment;
@property(nonatomic,retain)IBOutlet UISegmentedControl *segemntControl;
@property(nonatomic,retain)IBOutlet UITableView *redeemTblVw;
@property(nonatomic,retain)IBOutlet UIButton *upBtn;
@property(nonatomic,retain)IBOutlet UIButton *downBtn;

@property(nonatomic,retain)IBOutlet UILabel *titleLbl;
@property(nonatomic,retain)IBOutlet UILabel *pointsLbl;
@property(nonatomic,retain)IBOutlet UILabel *valueTitle;
@property(nonatomic,retain)IBOutlet UILabel *valueLbl;
@property(nonatomic,retain)IBOutlet UILabel *descLbl;
@property(nonatomic,retain)IBOutlet UIButton *redeemBtn;

@property(nonatomic,retain)IBOutlet UIImageView *tempvw;
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;

-(IBAction)chnageSectionToUp:(id)sender;
@end
