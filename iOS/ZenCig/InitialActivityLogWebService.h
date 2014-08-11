//
//  InitialActivityLogWebService.h
//  TanningLoft
//
//  Created by Lavi on 09/08/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "Constant.h"
#import "PurchaseDBClass.h"

@interface InitialActivityLogWebService : NSObject
{
    NSURLConnection  *activityDetailConnection;
    NSMutableData *activityDataArray;
    
    NSURLConnection  *SocialWeightDetailConnection;
    NSMutableData *SocialWeightDataArray;
    
    NSURLConnection  *PackageDetailConnection;
    NSMutableData *PackageDataArray;
    
    NSURLConnection  *SocialContentDetailConnection;
    NSMutableData *SocialContentDataArray;
    
    NSURLConnection  *UploadTimeDetailConnection;
    NSMutableData *UploadTimeDataArray;
    
    NSURLConnection  *PurchaseDetailConnection;
    NSMutableData *PurchaseDataArray;
    
    
}
-(void)callInitailActivityLog;
-(void)callManualSync;
@end
