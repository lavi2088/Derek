//
//  PurchaseTanDetailViewController.h
//  TanningLoft
//
//  Created by Lavi on 27/06/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PurchaseDBClass.h"

@interface PurchaseTanDetailViewController : UIViewController
@property(nonatomic,retain)IBOutlet UILabel *titleLbl;
@property(nonatomic,retain)IBOutlet UILabel *addDate;
@property(nonatomic,retain)IBOutlet UILabel *expireDate;
@property(nonatomic,retain)IBOutlet UILabel *amount;

@property(nonatomic,retain)IBOutlet UILabel *titleLbl1;
@property(nonatomic,retain)IBOutlet UILabel *addDateH;
@property(nonatomic,retain)IBOutlet UILabel *expireDateH;
@property(nonatomic,retain)IBOutlet UILabel *amountH;
@property(nonatomic,retain)IBOutlet UIImageView *qrCodeImg;
@property(nonatomic,retain)IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain)IBOutlet UITextField *pinTxt;

@property(nonatomic,retain)PurchaseDBClass *purchaseClass;
-(void)reloadPackageAfterRedem:(NSString *)status;
@end
