//
//  CustomCellOfShopViewControllerCell.m
//  TanningLoft
//
//  Created by Lavi on 14/05/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "CustomCellOfShopViewControllerCell.h"

@implementation CustomCellOfShopViewControllerCell
@synthesize imageVw,lbl1,txtView1,txtView2;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
