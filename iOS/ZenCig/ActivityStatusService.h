//
//  ActivityStatusService.h
//  TanningLoft
//
//  Created by Lavi on 06/08/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constant.h"
#import "AppDelegate.h"

@interface ActivityStatusService : NSObject
{
    NSMutableArray *activityPendingArray;
    NSURLConnection  *activityDetailConnection;
    NSMutableData *activityDataArray;
    ActivityLogDBClass *activityClass;
    NSInteger count;
}
-(void)triggerActivityStatusService;
@end
