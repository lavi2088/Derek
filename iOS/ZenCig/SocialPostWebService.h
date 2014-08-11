//
//  SocialPostWebService.h
//  MyMobiPoints
//
//  Created by Macmini on 29/12/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SocialPostWebService : NSObject
{
    NSURLConnection  *SocialContentDetailConnection;
    NSMutableData *SocialContentDataArray;
}
-(void)callInitialSocialPost;
-(void)callManualSocialPost;
@end
