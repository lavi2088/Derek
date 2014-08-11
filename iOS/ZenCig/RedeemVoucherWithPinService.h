//
//  RedeemVoucherWithPinService.h
//  MyMobiPoints
//
//  Created by Macmini on 24/12/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "Constant.h"

@interface RedeemVoucherWithPinService : NSObject
{
    NSURLConnection  *UploadTimeDetailConnection;
    NSMutableData *UploadTimeDataArray;
}
-(void)callPinRedeemService:(NSString *)pin : (NSString *)pkgId;
@end