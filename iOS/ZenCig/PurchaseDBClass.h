//
//  PurchaseDBClass.h
//  TanningLoft
//
//  Created by Lavi on 27/06/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PurchaseDBClass : NSObject
{
    
}
@property(nonatomic,retain) NSString *pkgId;
@property(nonatomic,retain) NSString *pkgTitle;
@property(nonatomic,retain) NSString *pkgAmount;
@property(nonatomic,retain) NSString *pkgDescription;
@property(nonatomic,retain) NSString *AddedDate;
@property(nonatomic,retain) NSString *ExpireDate;
@property(nonatomic,retain) NSString *type;
@property(nonatomic,retain) NSString *redeemedDate;
@property(nonatomic,retain) NSString *isRedeemed;
@end
