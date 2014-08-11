//
//  SettingViewController.h
//  TanningLoft
//
//  Created by Lavi on 23/06/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PurchaseDBClass.h"
#import "DBConnectionClass.h"
#import "PurchaseTanDetailViewController.h"

@interface SettingViewController : UIViewController
@property(nonatomic,retain)IBOutlet UITableView *myPurchaseTbl;
@property(nonatomic,retain)IBOutlet UITableView *myVoucherTbl;
@property(nonatomic,retain)NSMutableArray *myPurchaseArray;
@property(nonatomic,retain)NSMutableArray *myVoucherArray;
@property(nonatomic,retain)PurchaseTanDetailViewController *purchaseTan;
@end