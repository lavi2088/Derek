//
//  MessageWebService.m
//  MyMobiPoints
//
//  Created by Macmini on 14/12/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "MessageWebService.h"
#import "MessageDBClass.h"
#import "MessageViewController.h"

@implementation MessageWebService

-(void)callCurrentServerTimeService{
    
    //************UploadTimeDataArray
    
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@messageservice.php?user=a&format=json&num=10&userid=%@&uploadtime=%@",tanningDelegate.hostString,[tanningDelegate.dbClass getUserName],[[NSUserDefaults standardUserDefaults] objectForKey:@"messagesynctime"]] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    UploadTimeDetailConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    NSLog(@"%@",theRequest);
    if (UploadTimeDetailConnection) {
        // Inform the user that the download failed.
        UploadTimeDataArray=[[NSMutableData alloc ]init];
        
        NSLog(@"messageservice.php JSON download youtube");
    }
    else {
        NSLog(@"messageservice.php JSON download fail");
    }
    
    //************End UploadTimeDataArray
}


-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
    if(UploadTimeDetailConnection==connection){
        
        [UploadTimeDataArray setLength:0];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
    if(UploadTimeDetailConnection==connection){
        
        [UploadTimeDataArray appendData:data];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    
    if (connection==UploadTimeDetailConnection) {
        
        NSString *responseString = [[NSString alloc] initWithData:UploadTimeDataArray encoding:NSUTF8StringEncoding];
        NSLog(@"message responseString %@",responseString);
        
        NSError *error;
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSMutableDictionary *jsonDictionary = [parser objectWithString:responseString error:nil];
        
        NSArray *nodes = (NSArray*)[jsonDictionary objectForKey:@"posts"];
        
        //(activityId TEXT,username TEXT , socialtype TEXT, activitytype TEXT,activitytitle TEXT, activitydate TEXT, expiredate TEXT, amount TEXT,point TEXT, status TEXT)"
        
        for (NSDictionary *node in nodes){
            
            MessageDBClass *msgObj=[[MessageDBClass alloc]init];
            
            msgObj.msgid=[[node objectForKey:@"post"] objectForKey:@"id"];
            msgObj.title=[[node objectForKey:@"post"] objectForKey:@"title"];
            msgObj.description=[[node objectForKey:@"post"] objectForKey:@"description"];
            msgObj.date=[[node objectForKey:@"post"] objectForKey:@"date"];
            msgObj.voucher_id=[[node objectForKey:@"post"] objectForKey:@"voucher_id"];
            msgObj.voucher_amount=[[node objectForKey:@"post"] objectForKey:@"voucher_amount"];
            msgObj.voucher_point=[[node objectForKey:@"post"] objectForKey:@"voucher_point"];
            msgObj.voucher_expiry=[[node objectForKey:@"post"] objectForKey:@"voucher_expiry"];
            msgObj.isActive=[[node objectForKey:@"post"] objectForKey:@"isActive"];
            
            [tanningDelegate.dbClass insertMessageDetails:msgObj];
            
        }
        
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        
        if (standardUserDefaults) {
            [standardUserDefaults setObject:tanningDelegate.currentServerTime forKey:@"messagesynctime"];
            [standardUserDefaults synchronize];
        }
        
        if ([[tanningDelegate.reserveNavController topViewController] isKindOfClass:[MessageViewController class]]) {
            
            MessageViewController *msgVC=(MessageViewController *)[tanningDelegate.reserveNavController topViewController];
            
            [msgVC reloadMessageTbl];
            
        }
        
    }
}
@end

