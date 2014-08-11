//
//  MessageCell.h
//  MyMobiPoints
//
//  Created by Macmini on 14/12/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCell : UITableViewCell
@property(nonatomic,retain)IBOutlet UILabel *dateLbl;
@property(nonatomic,retain)IBOutlet UILabel *titleTbl;
@property(nonatomic,retain)IBOutlet UIButton *viewOfferBtn;
@property(nonatomic,retain)IBOutlet UIButton *crossBtn;
@end
