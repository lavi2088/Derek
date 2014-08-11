//
//  FacebookSocialPostViewController.h
//  MyMobiPoints
//
//  Created by Macmini on 29/12/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Constant.h"
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>

@interface FacebookSocialPostViewController : UIViewController
@property(nonatomic,retain)NSMutableArray *socialPostArray;
@property(nonatomic)NSInteger currentIndex;
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain)NSString *socialType;

//Coupon instances
@property(nonatomic,retain)IBOutlet UIView *couponVw;
@property(nonatomic,retain)IBOutlet UIView *couponOfferVw;
@property(nonatomic,retain)IBOutlet UIImageView *couponImgView;
@property(nonatomic,retain)IBOutlet UIImageView *couponImgView1;
@property(nonatomic,retain)IBOutlet UIImageView *couponLogoImgView;
@property(nonatomic,retain)IBOutlet UILabel *couponTitleLbl;
@property(nonatomic,retain)IBOutlet UILabel *couponDescLbl;
@property(nonatomic,retain)IBOutlet UILabel *couponSavingLbl;
@property(nonatomic,retain)IBOutlet UILabel *couponBrandLbl;
@property(nonatomic,retain)IBOutlet UILabel *couponAmountLbl;
@property(nonatomic,retain)IBOutlet UIButton *couponShareBtn;
@property(nonatomic,retain)IBOutlet UILabel *couponTagLbl;
@property(nonatomic,retain)IBOutlet UILabel *couponExpireLbl;

//Picture instances
@property(nonatomic,retain)IBOutlet UIView *pictureVw;
@property(nonatomic,retain)IBOutlet UIImageView *pictureImgView;
@property(nonatomic,retain)IBOutlet UILabel *pictureTitleLbl;
@property(nonatomic,retain)IBOutlet UILabel *pictureDescLbl;
@property(nonatomic,retain)IBOutlet UILabel *pictureLinkLbl;
@property(nonatomic,retain)IBOutlet UIButton *pictureShareBtn;

//Blog instances
@property(nonatomic,retain)IBOutlet UIView *blogVw;
@property(nonatomic,retain)IBOutlet UIImageView *blogTitleImgView;
@property(nonatomic,retain)IBOutlet UILabel *blogTitleLbl;
@property(nonatomic,retain)IBOutlet UILabel *blogDescLbl;
@property(nonatomic,retain)IBOutlet UILabel *blogLinkLbl;
@property(nonatomic,retain)IBOutlet UILabel *writerNameLbl;
@property(nonatomic,retain)IBOutlet UILabel *addedDateLbl;
@property(nonatomic,retain)IBOutlet UIWebView *blogWebview;
@property(nonatomic,retain)IBOutlet UIButton *blogShareBtn;

//Video instances
@property(nonatomic,retain)IBOutlet UIView *videoVw;
@property(nonatomic,retain)IBOutlet UIImageView *videoImgView;
@property(nonatomic,retain)IBOutlet UILabel *videoTitleLbl;
@property(nonatomic,retain)IBOutlet UILabel *videoDescLbl;
@property(nonatomic,retain)IBOutlet UIButton *videoShareBtn;

//podcast instances
@property(nonatomic,retain)IBOutlet UIView *podcastVw;
@property(nonatomic,retain)IBOutlet UIImageView *podcastImgView;
@property(nonatomic,retain)IBOutlet UILabel *podcastTitleLbl;
@property(nonatomic,retain)IBOutlet UILabel *podcastDescLbl;
@property(nonatomic,retain)IBOutlet UIButton *podcastShareBtn;

-(IBAction)playVideo:(id)sender;
-(IBAction)playPodcast:(id)sender;

- (NSString *)extractYoutubeID:(NSString *)youtubeURL;
- (NSString *)extractVimeoID:(NSString *)vimeoURL;
@end
