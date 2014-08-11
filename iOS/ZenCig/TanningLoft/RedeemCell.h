//
//  RedeemCell.h
//  TanningLoft
//
//  Created by Lavi on 25/06/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RedeemCell : UITableViewCell
@property(nonatomic,retain)IBOutlet UIImageView *pkgImg;
@property(nonatomic,retain)IBOutlet UILabel *pkgTitle;
@property(nonatomic,retain)IBOutlet UILabel *pkgAmount;
@property(nonatomic,retain)IBOutlet UIButton *pkgRedeemBtn;
@property(nonatomic,retain)IBOutlet UIButton *pkgPointBtn;
@end
