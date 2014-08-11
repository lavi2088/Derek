//
//  RedeemCell.m
//  TanningLoft
//
//  Created by Lavi on 25/06/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "RedeemCell.h"

@implementation RedeemCell
@synthesize pkgImg;
@synthesize pkgTitle;
@synthesize pkgAmount;
@synthesize pkgRedeemBtn;
@synthesize pkgPointBtn;

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
