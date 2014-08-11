//
//  RedeemDetailViewController.h
//  TanningLoft
//
//  Created by Lavi on 19/06/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FacebookSDK/FacebookSDK.h"
#import "PackageDetailDBClass.h"

@interface RedeemDetailViewController : UIViewController
{
    NSString *pointsTotal;
    NSString *pkgTitle;
    NSString *pkgAmount;
    NSString *pkgPoints;
    
    NSMutableArray *pointsArray;
    NSURLConnection  *pointDetailConnection;
    NSMutableData *pointDataArray;
}
@property(nonatomic,retain)NSString *pointsTotal;
@property(nonatomic,retain)NSString *pkgTitle;
@property(nonatomic,retain)NSString *pkgAmount;
@property(nonatomic,retain)NSString *pkgPoints;
@property(nonatomic,retain)NSString *pkgId;
@property(nonatomic,retain)PackageDetailDBClass *pkgObj;

@property (strong,nonatomic) IBOutlet FBProfilePictureView *userProfileImage;
@property(nonatomic,retain)IBOutlet UILabel *userNameLbl;
@property(nonatomic,retain)IBOutlet UILabel *totalPointsLbl;
@property(nonatomic,retain)IBOutlet UILabel *totalPointStarLbl;
@property(nonatomic,retain)IBOutlet UILabel *pkgTitleLbl;
@property(nonatomic,retain)IBOutlet UILabel *pkgAmountLbl;
@property(nonatomic,retain)IBOutlet UILabel *pkgPointsLbl;
@property(nonatomic,retain)IBOutlet UIImageView *pkgImgView;
@property(nonatomic,retain)IBOutlet UIButton *buyBtn;
@property(nonatomic,retain)IBOutlet UIImage *pkgImg;
@property(nonatomic,retain)IBOutlet NSString *pkgdurationType;
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain) IBOutlet UIView *containerView;
@property(nonatomic,retain) IBOutlet UIButton *redeemBtn;

-(IBAction)redeemBtnClicked:(id)sender;
@end
