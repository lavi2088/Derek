//
//  AccountViewController.h
//  TanningLoft
//
//  Created by Lavi on 26/05/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBConnectionClass.h"

@interface AccountViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *titleArray;
    NSMutableArray *pointsArray;
    NSURLConnection  *pointDetailConnection;
    NSMutableData *pointDataArray;
    DBConnectionClass *dbClass;

}
@property(nonatomic,retain)IBOutlet UILabel *pointTotal;
@property(nonatomic,retain)IBOutlet UITableView *pointTable;
@property(nonatomic,retain)IBOutlet UIView *pointTableView;
@property(nonatomic,retain)IBOutlet UILabel *fbPoint;
@property(nonatomic,retain)IBOutlet UILabel *twPoint;
@property(nonatomic,retain)IBOutlet UILabel *instaPoint;
@property(nonatomic,retain)IBOutlet UILabel *fourSquarePoint;
@property(nonatomic,retain)IBOutlet UILabel *spinPoint;
@property(nonatomic,retain)IBOutlet UILabel *bonusPoint;

@property(nonatomic,retain)IBOutlet UILabel *username;
@property(nonatomic,retain)IBOutlet UILabel *memeberSince;
@property(nonatomic,retain)IBOutlet UIImageView *pointStar;

@end
