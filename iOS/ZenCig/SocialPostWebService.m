//
//  SocialPostWebService.m
//  MyMobiPoints
//
//  Created by Macmini on 29/12/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "SocialPostWebService.h"
#import "Constant.h"
#import "AppDelegate.h"
#import "SocialPostObj.h"

@implementation SocialPostWebService

-(void)callInitialSocialPost{
    
    //************ SocialContentDetailConnection
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@webservice/social/socialpostservcie.php?userid=%@&format=json&num=10",tanningDelegate.hostString,[tanningDelegate.dbClass getUserName]] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    SocialContentDetailConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    NSLog(@"%@",theRequest);
    if (SocialContentDetailConnection) {
        // Inform the user that the download failed.
        SocialContentDataArray=[[NSMutableData alloc ]init];
        
        NSLog(@"JSON download youtube");
    }
    else {
        NSLog(@"JSON download fail");
    }
    //************End SocialContentDetailConnection
}

-(void)callManualSocialPost{
    
    //************ SocialContentDetailConnection
    
    NSString *lastSyncDate=[[[[tanningDelegate.dbClass fetchLastUpdateTime] objectAtIndex:0] componentsSeparatedByString:@" "] objectAtIndex:0];
    NSString *lastSyncTime=[[[[tanningDelegate.dbClass fetchLastUpdateTime] objectAtIndex:0] componentsSeparatedByString:@" "] objectAtIndex:1];
    
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@webservice/social/socialpostservcie.php?userid=%@&format=json&num=10&uploadtime=%@",tanningDelegate.hostString,[tanningDelegate.dbClass getUserName],[[tanningDelegate.dbClass fetchLastUpdateTime] objectAtIndex:0]] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding] ]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    NSURL *url = [[NSURL alloc] initWithString:
           [[NSString stringWithFormat:@"%@webservice/social/socialpostservcie.php?userid=%@&format=json&num=10&date=%@&time=%@",tanningDelegate.hostString,[tanningDelegate.dbClass getUserName],lastSyncDate,lastSyncTime] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
    theRequest=[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    SocialContentDetailConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    NSLog(@"%@",theRequest);
    if (SocialContentDetailConnection) {
        // Inform the user that the download failed.
        SocialContentDataArray=[[NSMutableData alloc ]init];
        
        NSLog(@"JSON download youtube");
    }
    else {
        NSLog(@"JSON download fail");
    }
    //************End SocialContentDetailConnection
}


-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
    if(SocialContentDetailConnection==connection){
        
        [SocialContentDataArray setLength:0];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
    if(SocialContentDetailConnection==connection){
        
        [SocialContentDataArray appendData:data];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    
    if (connection==SocialContentDetailConnection) {
        
        NSString *responseString = [[NSString alloc] initWithData:SocialContentDataArray encoding:NSUTF8StringEncoding];
        // [responseData release];
        
        NSLog(@"SocialPostDetailConnection responseString %@",responseString);
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSMutableDictionary *jsonDictionary = [parser objectWithString:responseString error:nil];
        
        NSArray *nodes = (NSArray*)[jsonDictionary objectForKey:@"posts"];
        
        //(activityId TEXT,username TEXT , socialtype TEXT, activitytype TEXT,activitytitle TEXT, activitydate TEXT, expiredate TEXT, amount TEXT,point TEXT, status TEXT)"
        
        for (NSDictionary *node in nodes){
            
            SocialPostObj *socialObj=[[SocialPostObj alloc]init];
            
            socialObj.socialid=[[node objectForKey:@"post"] objectForKey:@"id"];
            socialObj.title=[[node objectForKey:@"post"] objectForKey:@"title"];
            socialObj.description=[[node objectForKey:@"post"] objectForKey:@"description"];
            socialObj.imgpath=[[node objectForKey:@"post"] objectForKey:@"imgpath"];
            socialObj.addeddate=[[node objectForKey:@"post"] objectForKey:@"addeddate"];
            socialObj.link=[[node objectForKey:@"post"] objectForKey:@"link"];
            socialObj.imgname=[[node objectForKey:@"post"] objectForKey:@"imgname"];
            socialObj.isactive=[[node objectForKey:@"post"] objectForKey:@"isactive"];
            socialObj.pointvalue=[[node objectForKey:@"post"] objectForKey:@"pointvalue"];
            socialObj.isvalidforcoupon=[[node objectForKey:@"post"] objectForKey:@"isvalidforcoupon"];
            socialObj.couponcode=[[node objectForKey:@"post"] objectForKey:@"couponcode"];
            socialObj.savingper=[[node objectForKey:@"post"] objectForKey:@"savingper"];
            socialObj.tags=[[node objectForKey:@"post"] objectForKey:@"tags"];
            socialObj.amount=[[node objectForKey:@"post"] objectForKey:@"amount"];
            socialObj.type=[[node objectForKey:@"post"] objectForKey:@"type"];
            socialObj.subtype=[[node objectForKey:@"post"] objectForKey:@"subtype"];
            socialObj.extra=[[node objectForKey:@"post"] objectForKey:@"extra"];
            
            socialObj.colorcode=[[node objectForKey:@"post"] objectForKey:@"colorcode"];
            socialObj.isfeatured=[[node objectForKey:@"post"] objectForKey:@"isfeatured"];
            socialObj.writername=[[node objectForKey:@"post"] objectForKey:@"writername"];
            socialObj.expiredate=[[node objectForKey:@"post"] objectForKey:@"expiredate"];
            socialObj.logoimagename=[[node objectForKey:@"post"] objectForKey:@"logoimagename"];
            socialObj.logoimagepath=[[node objectForKey:@"post"] objectForKey:@"logoimagepath"];
            
            [tanningDelegate.dbClass insertSocialPostData:socialObj];
            
            
        }

    }

}
@end

