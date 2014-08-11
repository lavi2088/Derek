//
//  UserDetailDBClass.h
//  TanningLoft
//
//  Created by Lavi on 08/06/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDetailDBClass : NSObject
@property(nonatomic,retain)NSString *userId;
@property(nonatomic,retain)NSString *firstname;
@property(nonatomic,retain)NSString *lastname;
@property(nonatomic,retain)NSString *tokenNo;
@property(nonatomic,retain)NSString *memberSince;
@property(nonatomic,retain)NSString *email;
@property(nonatomic,retain)NSString *isActive;
@end
