//
//  FacebookArticleViewController.h
//  TanningLoft
//
//  Created by Lavi on 22/05/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "DBConnectionClass.h"
#import "iCarousel.h"

@interface FacebookArticleViewController : UIViewController<UITableViewDelegate>
{
    IBOutlet FBProfilePictureView *userProfileImage;
    IBOutlet UIButton *sharePhotos;
    IBOutlet UITableView *FBTblVwOfArticles;
    NSMutableArray *articleTite;
    NSMutableArray *articleDesc;
    NSMutableArray *pictureNameArray;
     NSMutableArray *pictureServerArray;
    NSURLConnection  *shareDetailConnection;
    NSMutableData *shareDataArray;
    DBConnectionClass *dbClass;
     NSMutableArray *socialShareDetails;

}
@property (strong,nonatomic)FBProfilePictureView *userProfileImage;
@property(nonatomic,retain)IBOutlet UILabel *userNameLbl;
@property(nonatomic,retain)IBOutlet UIButton *sharePhotos;
@property(nonatomic,retain)IBOutlet UITableView *FBTblVwOfArticles;
@property(nonatomic,retain) NSMutableArray *articleTite;
@property(nonatomic,retain) NSMutableArray *articleDesc;
@property(nonatomic,retain) NSMutableArray *pictureNameArray;
@property(nonatomic,retain)  NSMutableArray *pictureServerArray;
@property (nonatomic, retain) IBOutlet iCarousel *carousel;
@property(nonatomic,retain)IBOutlet UILabel *titleLbl;
@property(nonatomic,retain)IBOutlet UILabel *descLbl;
@property(nonatomic,retain)IBOutlet UIButton *shareBtn;

@property(nonatomic,retain)IBOutlet UIImageView *tempvw;

-(IBAction)SharePhotosBtnClicked:(id)sender;
@end
