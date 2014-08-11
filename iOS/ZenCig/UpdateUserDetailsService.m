//
//  UpdateUserDetailsService.m
//  TanningLoft
//
//  Created by Macmini on 16/10/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "UpdateUserDetailsService.h"
#import "Constant.h"
#import "AppDelegate.h"

@implementation UpdateUserDetailsService

-(void)updateUserDetails{
    
    //************activityDetailConnection
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@UserDetailNameService.php?userid=%@&format=json&num=10&fname=%@&lname=%@",tanningDelegate.hostString,[tanningDelegate.dbClass getUserName],[tanningDelegate.dbClass getFirstName],[tanningDelegate.dbClass getLastName]] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    userDetailConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    NSLog(@"%@",theRequest);
    if (userDetailConnection) {
        // Inform the user that the download failed.
        userDataArray=[[NSMutableData alloc ]init];
        
        NSLog(@"UserDetailsService.php JSON download youtube");
    }
    else {
        NSLog(@"UserDetailsService.php JSON download fail");
    }
    //************End activityDetailConnection
    
    UserDetailDBClass *userObj=[[UserDetailDBClass alloc]init];
    userObj=[[tanningDelegate.dbClass fetchUserDetail] objectAtIndex:0];
    
    NSURLRequest *tokenRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@DeviceTokenUpdate.php?userid=%@&firstname=%@&lastname=%@&tokenid=%@&email=%@",tanningDelegate.hostString,[tanningDelegate.dbClass getUserName],[tanningDelegate.dbClass getFirstName],userObj.lastname,userObj.tokenNo,userObj.email] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    NSURLConnection *tokenDetailConnection = [[NSURLConnection alloc] initWithRequest:tokenRequest delegate:self];
   // NSLog(@"tokenDetailConnection%@",[[NSString stringWithFormat:@"%@DeviceTokenUpdate.php?userid=%@&firstname=%@&lastname=%@&tokenid=%@&email=%@",tanningDelegate.hostString,[self getUserName],[self getFirstName],userObj.lastname,userObj.tokenNo,userDBObj.email] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]);
    
    if (tokenDetailConnection) {
        NSLog(@"%@",tokenRequest);
    }
    
}

@end
