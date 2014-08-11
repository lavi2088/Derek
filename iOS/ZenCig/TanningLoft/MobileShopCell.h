//
//  MobileShopCell.h
//  TanningLoft
//
//  Created by Lavi on 27/06/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MobileShopCell : UITableViewCell
@property(nonatomic,retain)IBOutlet UIImageView *pkgImg;
@property(nonatomic,retain)IBOutlet UILabel *pkgTitle;
@property(nonatomic,retain)IBOutlet UILabel *pkgAmount;
@property(nonatomic,retain)IBOutlet UIButton *pkgBuyBtn;
@property(nonatomic,retain)IBOutlet UIButton *pkgPointBtn;
@end
