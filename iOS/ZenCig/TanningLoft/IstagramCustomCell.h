//
//  IstagramCustomCell.h
//  TanningLoft
//
//  Created by Lavi on 01/06/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IstagramCustomCell : UITableViewCell
{
    IBOutlet UIImageView *imgVw;
    IBOutlet UILabel *title;
    IBOutlet UILabel *desc;
    IBOutlet UIButton *tweetBtn;
    IBOutlet UIButton *shareBtn;
    
}
@property (nonatomic,retain)UIImageView *imgVw;
@property (nonatomic,retain)UILabel *title;
@property (nonatomic,retain)UILabel *desc;
@property (nonatomic,retain)UIButton *tweetBtn;
@property (nonatomic,retain)UIButton *shareBtn;
@end
