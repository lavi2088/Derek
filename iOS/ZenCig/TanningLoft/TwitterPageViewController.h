//
//  TwitterPageViewController.h
//  TanningLoft
//
//  Created by Lavi on 25/05/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBConnectionClass.h"
#import "iCarousel.h"

@interface TwitterPageViewController : UIViewController<UITableViewDelegate>
{
    IBOutlet UIImageView *userProfileImage;
    IBOutlet UIButton *tweetBtn;
    IBOutlet UITableView *TwitterTblVwOfArticles;
    NSMutableArray *articleTite;
    NSMutableArray *articleDesc;
    NSMutableArray *pictureNameArray;
    NSURLConnection  *shareDetailConnection;
    NSMutableData *shareDataArray;
     NSMutableArray *socialShareDetails;
    DBConnectionClass *dbClass;
}
@property (strong,nonatomic)UIImageView *userProfileImage;
@property(nonatomic,retain)IBOutlet UILabel *userNameLbl;
@property(nonatomic,retain)IBOutlet UIButton *tweetBtn;
@property(nonatomic,retain)IBOutlet UITableView *TwitterTblVwOfArticles;
@property(nonatomic,retain) NSMutableArray *articleTite;
@property(nonatomic,retain) NSMutableArray *articleDesc;
@property(nonatomic,retain) NSMutableArray *pictureNameArray;
@property (strong, nonatomic) NSArray *dataSource;

@property (nonatomic, retain) IBOutlet iCarousel *carousel;
@property(nonatomic,retain)IBOutlet UILabel *titleLbl;
@property(nonatomic,retain)IBOutlet UILabel *descLbl;
@property(nonatomic,retain)IBOutlet UIButton *shareBtn;

-(IBAction)TweetBtnCliked:(id)sender;
@end
