//
//  ActivityLogCell.m
//  TanningLoft
//
//  Created by Lavi on 04/08/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "ActivityLogCell.h"

@implementation ActivityLogCell
@synthesize socialImg,title,date,points,status;

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
