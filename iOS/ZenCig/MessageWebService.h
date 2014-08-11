//
//  MessageWebService.h
//  MyMobiPoints
//
//  Created by Macmini on 14/12/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "Constant.h"

@interface MessageWebService : NSObject
{
    NSURLConnection  *UploadTimeDetailConnection;
    NSMutableData *UploadTimeDataArray;
}
-(void)callCurrentServerTimeService;
@end
