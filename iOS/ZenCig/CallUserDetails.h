//
//  CallUserDetails.h
//  TanningLoft
//
//  Created by Lavi Gupta on 25/08/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CallUserDetails : NSObject
{
    NSURLConnection  *userDetailConnection;
    NSMutableData *userDataArray;
}
-(void)callUserDetails;
@end
