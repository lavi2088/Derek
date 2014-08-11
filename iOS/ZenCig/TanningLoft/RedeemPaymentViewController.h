//
//  RedeemPaymentViewController.h
//  TanningLoft
//
//  Created by Lavi on 20/06/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Constant.h"
#import "FacebookSDK/FacebookSDK.h"
#import "PayPalMobile.h"
#import "PaypalPaymentWebViewViewController.h"
@interface RedeemPaymentViewController : UIViewController<PayPalPaymentDelegate>
{
    
}
@property (strong,nonatomic) IBOutlet FBProfilePictureView *userProfileImage;
@property(nonatomic,retain)IBOutlet UILabel *userNameLbl;
@property(nonatomic,retain)IBOutlet UILabel *title1Lbl;
@property(nonatomic,retain)IBOutlet UILabel *title2Lbl;
@property(nonatomic,retain)IBOutlet UIButton *purchaseBtn;
@property(nonatomic,retain)NSString *pointsTotal;
@property(nonatomic,retain)NSString *pkgTitle;
@property(nonatomic,retain)NSString *pkgAmount;
@property(nonatomic,retain)NSString *pkgPoints;
@property(nonatomic,retain)NSString *pkgId;
@property(nonatomic, strong, readwrite) NSString *environment;
@property(nonatomic, assign, readwrite) BOOL acceptCreditCards;
@property(nonatomic, strong, readwrite) PayPalPayment *completedPayment;
@property(nonatomic,assign)float amountDiffPoints;
@property(nonatomic,retain)IBOutlet NSString *pkgdurationType;
@property(nonatomic,retain)PackageDetailDBClass *pkgObj;
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@end
