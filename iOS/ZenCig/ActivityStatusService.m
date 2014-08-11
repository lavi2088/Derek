//
//  ActivityStatusService.m
//  TanningLoft
//
//  Created by Lavi on 06/08/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "ActivityStatusService.h"
#import "ActivityLogDBClass.h"
#import "ActivityLogViewController.h"

@implementation ActivityStatusService

-(void)triggerActivityStatusService{
    count=0;
    activityPendingArray=[[NSMutableArray alloc]init];
    tanningDelegate.activityStatusID=[[NSMutableArray alloc]init];
    
    activityPendingArray=[tanningDelegate.dbClass fetchSocialActivityPendingdata];
    if (activityPendingArray.count) {
        activityClass=[[ActivityLogDBClass alloc]init];
        activityClass=[activityPendingArray objectAtIndex:count];
        
        NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@ActivityStatus.php?userid=%@&format=json&num=10&activityId=%@",tanningDelegate.hostString,[tanningDelegate.dbClass getUserName],activityClass.activityId] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        activityDetailConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
        
        NSLog(@"%@",theRequest);
        if (activityDetailConnection) {
            // Inform the user that the download failed.
            activityDataArray=[[NSMutableData alloc ]init];
            
            //  [recievedData writeToFile:path atomically:YES];
            NSLog(@"JSON download youtube");
        }
        else {
            NSLog(@"JSON download fail");
        }
        

    }
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if(activityDetailConnection==connection){
        
        [activityDataArray setLength:0];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if(activityDetailConnection==connection){
        
        [activityDataArray appendData:data];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *responseString = [[NSString alloc] initWithData:activityDataArray encoding:NSUTF8StringEncoding];
    NSError *error;
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSMutableDictionary *jsonDictionary = [parser objectWithString:responseString error:nil];
    
    NSArray *nodes = (NSArray*)[jsonDictionary objectForKey:@"posts"];
    
    for (NSDictionary *node in nodes){
        
        NSLog(@"ActivityStatus.php %@", [(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"status"]);
        
        if (![[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"status"] isEqualToString:activityClass.status]) {
            
            [tanningDelegate.activityStatusID addObject:activityClass.activityId];
            [tanningDelegate.dbClass updatePkgStatus:[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"status"]:activityClass.activityId];
        }
    }
    ++count;
    
    if (count<activityPendingArray.count) {
        
        activityClass=[[ActivityLogDBClass alloc]init];
        activityClass=[activityPendingArray objectAtIndex:count];
        
        NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@ActivityStatus.php?userid=%@&format=json&num=10&activityId=%@",tanningDelegate.hostString,[tanningDelegate.dbClass getUserName],activityClass.activityId] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        activityDetailConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
        
        NSLog(@"%@",theRequest);
        if (activityDetailConnection) {
            // Inform the user that the download failed.
            activityDataArray=[[NSMutableData alloc ]init];
            
            //  [recievedData writeToFile:path atomically:YES];
            NSLog(@"ActivityStatus.php");
        }
        else {
            NSLog(@"ActivityStatus.php download fail");
        }
        
    }
    else{
        if ([tanningDelegate.reserveNavController.topViewController isKindOfClass:[ActivityLogViewController class]]) {
            
            ActivityLogViewController *activityLogClass=(ActivityLogViewController *)tanningDelegate.reserveNavController.topViewController;
            
            [activityLogClass reloadActivityLog];
        }
       
       // [UIApplication sharedApplication].applicationIconBadgeNumber=tanningDelegate.activityStatusID.count ;
    }
}

@end
