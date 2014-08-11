//
//  CustomCellOfShopViewControllerCell.h
//  TanningLoft
//
//  Created by Lavi on 14/05/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCellOfShopViewControllerCell : UITableViewCell
{
    IBOutlet UIImageView *imageVw;
    IBOutlet UILabel *lbl1;
    IBOutlet UITextView *txtView1;
    IBOutlet UITextView *txtView2;
//    NSMutableArray *images;
//    NSMutableArray *lbl1Values;
//    NSMutableArray *lbl2Values;
}
@property (nonatomic,retain)UIImageView *imageVw;
@property (nonatomic,retain)UILabel *lbl1;
@property (nonatomic,retain)UITextView *txtView1;
@property (nonatomic,retain)UITextView *txtView2;
//@property (nonatomic,retain) NSMutableArray *images;
//@property (nonatomic,retain) NSMutableArray *lbl1Values;
//@property (nonatomic,retain)NSMutableArray *lbl2Values;
@end
