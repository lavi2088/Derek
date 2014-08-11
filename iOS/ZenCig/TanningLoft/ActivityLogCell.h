//
//  ActivityLogCell.h
//  TanningLoft
//
//  Created by Lavi on 04/08/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityLogCell : UITableViewCell
@property(nonatomic,retain)IBOutlet UIImageView *socialImg;
@property(nonatomic,retain)IBOutlet UILabel *title;
@property(nonatomic,retain)IBOutlet UILabel *date;
@property(nonatomic,retain)IBOutlet UILabel *points;
@property(nonatomic,retain)IBOutlet UILabel *status;
@end
