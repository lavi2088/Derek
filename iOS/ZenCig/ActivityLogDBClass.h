//
//  ActivityLogDBClass.h
//  TanningLoft
//
//  Created by Lavi on 04/08/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityLogDBClass : NSObject
@property(nonatomic,retain)NSString *activityId;
@property(nonatomic,retain)NSString *username;
@property(nonatomic,retain)NSString *socialtype;
@property(nonatomic,retain)NSString *activitytype;
@property(nonatomic,retain)NSString *activitytitle;
@property(nonatomic,retain)NSString *activitydate;
@property(nonatomic,retain)NSString *expiredate;
@property(nonatomic,retain)NSString *amount;
@property(nonatomic,retain)NSString *point;
@property(nonatomic,retain)NSString *status;
@end
