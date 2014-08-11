//
//  FaceBookTblVwCellViewController.m
//  TanningLoft
//
//  Created by Lavi on 25/05/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "FaceBookTblVwCellViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "FacebookArticleViewController.h"

@implementation FaceBookTblVwCellViewController
@synthesize imgVw,title,desc,shareBtn,shareView;
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
