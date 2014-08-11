//
//  MessageDBClass.h
//  MyMobiPoints
//
//  Created by Macmini on 15/12/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageDBClass : NSObject
@property(nonatomic,retain)NSString *msgid;
@property(nonatomic,retain)NSString *title;
@property(nonatomic,retain)NSString *description;
@property(nonatomic,retain)NSString *type;
@property(nonatomic,retain)NSString *date;
@property(nonatomic,retain)NSString *voucher_id;
@property(nonatomic,retain)NSString *voucher_amount;
@property(nonatomic,retain)NSString *voucher_point;
@property(nonatomic,retain)NSString *voucher_expiry;
@property(nonatomic,retain)NSString *isActive;
@end
