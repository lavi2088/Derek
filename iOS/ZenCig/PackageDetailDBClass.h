//
//  PackageDetailDBClass.h
//  TanningLoft
//
//  Created by Lavi on 16/06/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PackageDetailDBClass : NSObject
@property(nonatomic,retain)NSString *pkgID;
@property(nonatomic,retain)NSString *pkgTitle;
@property(nonatomic,retain)NSString *pkgDescription;
@property(nonatomic,retain)NSString *pkgImagePath;
@property(nonatomic,retain)NSString *pkgPoints;
@property(nonatomic,retain)NSString *pkgAmount;
@property(nonatomic,retain)NSString *AddedDate;
@property(nonatomic,retain)NSString *isActive;
@property(nonatomic,retain)NSString *pkgType;
@property(nonatomic,retain)NSString *pkgLink;
@property(nonatomic,retain)NSString *imgName;
@property(nonatomic,retain)NSString *pkgDurationType;
@end
