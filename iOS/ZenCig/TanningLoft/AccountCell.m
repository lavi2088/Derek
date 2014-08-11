//
//  AccountCell.m
//  TanningLoft
//
//  Created by Lavi on 26/05/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "AccountCell.h"

@implementation AccountCell
@synthesize title,point;

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
