//
//  ShopViewController.h
//  TanningLoft
//
//  Created by Lavi on 14/05/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *pictureNameArray;
    NSMutableArray *labelArray;
    NSMutableArray *propertiesArray;
    NSMutableArray *packageDescription;
    NSInteger indexCounter;
}
@property(nonatomic,retain)IBOutlet UITableView *shopTbl;
@property(nonatomic,retain)IBOutlet UIButton *upwardBtn;
@property(nonatomic,retain)IBOutlet UIButton *downwardBtn;
@end
