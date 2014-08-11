//
//  ShopCustomCell.h
//  TanningLoft
//
//  Created by Lavi on 15/05/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopCustomCell : UITableViewCell

{
    IBOutlet UIImageView *imageVw;
    IBOutlet UILabel *lbl1;
    IBOutlet UILabel *txtView1;
    IBOutlet UILabel *txtView2;
    //    NSMutableArray *images;
    //    NSMutableArray *lbl1Values;
}
@property (nonatomic,retain)UIImageView *imageVw;
@property (nonatomic,retain)UILabel *lbl1;
@property (nonatomic,retain)IBOutlet UILabel *txtView1;
@property (nonatomic,retain)IBOutlet UILabel *txtView2;
//@property (nonatomic,retain) NSMutableArray *images;
//@property (nonatomic,retain) NSMutableArray *lbl1Values;
//@property (nonatomic,retain)NSMutableArray *lbl2Values;
@end
