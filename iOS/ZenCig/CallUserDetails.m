//
//  CallUserDetails.m
//  TanningLoft
//
//  Created by Lavi Gupta on 25/08/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "CallUserDetails.h"
#import "AppDelegate.h"
#import "Constant.h"
#import "UserDetailDBClass.h"

@implementation CallUserDetails

-(void)callUserDetails{
    //************activityDetailConnection
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@UserDetailsService.php?userid=%@&format=json&num=10",tanningDelegate.hostString,[tanningDelegate.dbClass getUserName]] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
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
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if(userDetailConnection==connection){
        
        [userDataArray setLength:0];
    }
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if(userDetailConnection==connection){
        
        [userDataArray appendData:data];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (connection==userDetailConnection) {
        
        NSString *responseString = [[NSString alloc] initWithData:userDataArray encoding:NSUTF8StringEncoding];
        // [responseData release];
        
        NSLog(@"UserDetailsService.php responseString %@",responseString);
        
        NSError *error;
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSMutableDictionary *jsonDictionary = [parser objectWithString:responseString error:nil];
        
        NSArray *nodes = (NSArray*)[jsonDictionary objectForKey:@"posts"];
        
        //(activityId TEXT,username TEXT , socialtype TEXT, activitytype TEXT,activitytitle TEXT, activitydate TEXT, expiredate TEXT, amount TEXT,point TEXT, status TEXT)"
        
        for (NSDictionary *node in nodes){
            
            UserDetailDBClass *userObj=[[UserDetailDBClass alloc]init];
            
            userObj.userId=[[node objectForKey:@"post"] objectForKey:@"userid"];
            userObj.firstname=[[node objectForKey:@"post"] objectForKey:@"firstname"];
            userObj.lastname=[[node objectForKey:@"post"] objectForKey:@"lastname"];
            userObj.memberSince=[[node objectForKey:@"post"] objectForKey:@"membersince"];
            userObj.email=[[node objectForKey:@"post"] objectForKey:@"email"];
            userObj.isActive=[[node objectForKey:@"post"] objectForKey:@"isActiveUser"];
            userObj.tokenNo=[[node objectForKey:@"post"] objectForKey:@"tokenid"];
            
            [tanningDelegate.dbClass insertUserDetailForUsesAcces:userObj];
            
        }
    }
}
@end
