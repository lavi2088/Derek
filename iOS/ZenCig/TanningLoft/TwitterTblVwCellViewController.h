//
//  TwitterTblVwCellViewController.h
//  TanningLoft
//
//  Created by Lavi on 25/05/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwitterTblVwCellViewController : UITableViewCell
{
IBOutlet UIImageView *imgVw;
IBOutlet UILabel *title;
IBOutlet UILabel *desc;
IBOutlet UIButton *tweetBtn;

}
@property (nonatomic,retain)UIImageView *imgVw;
@property (nonatomic,retain)UILabel *title;
@property (nonatomic,retain)UILabel *desc;
@property (nonatomic,retain)UIButton *tweetBtn;
@property (nonatomic,retain) IBOutlet UIView *shareView;
-(IBAction)tweetBtnClicked:(id)sender;
@end
