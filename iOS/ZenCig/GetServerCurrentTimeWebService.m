//
//  GetServerCurrentTimeWebService.m
//  TanningLoft
//
//  Created by Lavi Gupta on 19/09/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "GetServerCurrentTimeWebService.h"
#import "AppDelegate.h"
#import "Constant.h"

@implementation GetServerCurrentTimeWebService

-(void)callCurrentServerTimeService{
    
    //************UploadTimeDataArray
    
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@CurrentDate.php",tanningDelegate.hostString] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    UploadTimeDetailConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    NSLog(@"%@",theRequest);
    if (UploadTimeDetailConnection) {
        // Inform the user that the download failed.
        UploadTimeDataArray=[[NSMutableData alloc ]init];
        
        NSLog(@"UploadTimeDataArray JSON download youtube");
    }
    else {
        NSLog(@"UploadTimeDataArray JSON download fail");
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
        tanningDelegate.currentServerTime =responseString;
        
    }
}
@end
