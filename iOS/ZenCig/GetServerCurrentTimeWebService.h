//
//  GetServerCurrentTimeWebService.h
//  TanningLoft
//
//  Created by Lavi Gupta on 19/09/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetServerCurrentTimeWebService : NSObject
{
    NSURLConnection  *UploadTimeDetailConnection;
    NSMutableData *UploadTimeDataArray;
}
-(void)callCurrentServerTimeService;
@end
