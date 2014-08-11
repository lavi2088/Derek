//
//  UpdateUserDetailsService.h
//  TanningLoft
//
//  Created by Macmini on 16/10/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UpdateUserDetailsService : NSObject
{
    NSURLConnection  *userDetailConnection;
    NSMutableData *userDataArray;
}
-(void)updateUserDetails;
@end
