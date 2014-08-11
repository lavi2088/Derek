//
//  InitialActivityLogWebService.m
//  TanningLoft
//
//  Created by Lavi on 09/08/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "InitialActivityLogWebService.h"
#import "ActivityLogDBClass.h"
#import "SocialWeightDetailDBClass.h"
#import "CallUserDetails.h"
#import "UpdateUserDetailsService.h"
#import "SocialPostWebService.h"

int serviceCounter=0;
@implementation InitialActivityLogWebService

-(void)callInitailActivityLog{
    
    if([tanningDelegate.dbClass connected])
    {
    serviceCounter=0;
    
    [tanningDelegate.dbClass showIndicator];
    //************activityDetailConnection
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@initialActivityLog.php?userid=%@&format=json&num=10",tanningDelegate.hostString,[tanningDelegate.dbClass getUserName]] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    activityDetailConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    NSLog(@"%@",theRequest);
    if (activityDetailConnection) {
        // Inform the user that the download failed.
        activityDataArray=[[NSMutableData alloc ]init];
        
        NSLog(@"JSON download youtube");
    }
    else {
        NSLog(@"JSON download fail");
    }
    //************End activityDetailConnection
    
    //************ SocialPointsDetailsService
    theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@SocialPointsDetailsService.php?userid=%@&format=json&num=10",tanningDelegate.hostString,[tanningDelegate.dbClass getUserName]] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    SocialWeightDetailConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    NSLog(@"%@",theRequest);
    if (SocialWeightDetailConnection) {
        // Inform the user that the download failed.
        SocialWeightDataArray=[[NSMutableData alloc ]init];
        
        NSLog(@"JSON download youtube");
    }
    else {
        NSLog(@"JSON download fail");
    }
    //************End SocialPointsDetailsService
    
    //************ SocialContentDetailConnection
    theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@SocialShareDetailService.php?userid=%@&format=json&num=10",tanningDelegate.hostString,[tanningDelegate.dbClass getUserName]] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
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
    
    //************ SocialContentDetailConnection
    theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@PackageDetailService.php?userid=%@&format=json&num=10",tanningDelegate.hostString,[tanningDelegate.dbClass getUserName]] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    PackageDetailConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    NSLog(@"%@",theRequest);
    if (PackageDetailConnection) {
        // Inform the user that the download failed.
        PackageDataArray=[[NSMutableData alloc ]init];
        
        NSLog(@"JSON download youtube");
    }
    else {
        NSLog(@"JSON download fail");
    }
    //************End SocialContentDetailConnection
        
        //************ PurchaseDetailConnection
        theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@PurchaseDetailService.php?userid=%@&format=json&num=10",tanningDelegate.hostString,[tanningDelegate.dbClass getUserName]] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        PurchaseDetailConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
        
        NSLog(@"%@",theRequest);
        if (PurchaseDetailConnection) {
            // Inform the user that the download failed.
            PurchaseDataArray=[[NSMutableData alloc ]init];
            
            NSLog(@"JSON download PurchaseDataArray");
        }
        else {
            NSLog(@"PurchaseDataArray JSON download fail");
        }
        //************End PurchaseDetailConnection
        
        SocialPostWebService *socialService=[[SocialPostWebService alloc]init];
        
        [socialService callInitialSocialPost];
    }
    else{
        UIAlertView *alertVw=[[UIAlertView alloc]initWithTitle:@"Network Error" message:@"No network found. Please check your setting." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertVw show];
    }

}

-(void)callManualSync{
    
    if([tanningDelegate.dbClass connected])
    {
    serviceCounter=1;
    [tanningDelegate.dbClass showIndicator];
    NSString *lastSyncDate=[[[[tanningDelegate.dbClass fetchLastUpdateTime] objectAtIndex:0] componentsSeparatedByString:@" "] objectAtIndex:0];
    NSString *lastSyncTime=[[[[tanningDelegate.dbClass fetchLastUpdateTime] objectAtIndex:0] componentsSeparatedByString:@" "] objectAtIndex:1];
    //uploadtime=2013-07-22%2011:53:11
    //************ SocialPointsDetailsService
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@SocialPointsDetailsService.php?userid=%@&format=json&num=10&uploadtime=%@",tanningDelegate.hostString,[tanningDelegate.dbClass getUserName],[[tanningDelegate.dbClass fetchLastUpdateTime] objectAtIndex:0]] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    NSURL *url = [[NSURL alloc] initWithString:
                  [[NSString stringWithFormat:@"%@SocialPointsDetailsService.php?userid=%@&format=json&num=10&date=%@&time=%@",tanningDelegate.hostString,[tanningDelegate.dbClass getUserName],lastSyncDate,lastSyncTime] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
   theRequest=[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    SocialWeightDetailConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    NSLog(@"%@",theRequest);
    if (SocialWeightDetailConnection) {
        // Inform the user that the download failed.
        SocialWeightDataArray=[[NSMutableData alloc ]init];
        
        NSLog(@"JSON download youtube");
    }
    else {
        NSLog(@"JSON download fail");
    }
    //************End SocialPointsDetailsService
    
    //************ SocialContentDetailConnection
    
    theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@SocialShareDetailService.php?userid=%@&format=json&num=10&uploadtime=%@",tanningDelegate.hostString,[tanningDelegate.dbClass getUserName],[[tanningDelegate.dbClass fetchLastUpdateTime] objectAtIndex:0]] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding] ]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    url = [[NSURL alloc] initWithString:
           [[NSString stringWithFormat:@"%@SocialShareDetailService.php?userid=%@&format=json&num=10&date=%@&time=%@",tanningDelegate.hostString,[tanningDelegate.dbClass getUserName],lastSyncDate,lastSyncTime] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
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
    
    //************ SocialContentDetailConnection
    theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@PackageDetailService.php?userid=%@&format=json&num=10&uploadtime=%@",tanningDelegate.hostString,[tanningDelegate.dbClass getUserName],[[tanningDelegate.dbClass fetchLastUpdateTime] objectAtIndex:0]] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    url = [[NSURL alloc] initWithString:
           [[NSString stringWithFormat:@"%@PackageDetailService.php?userid=%@&format=json&num=10&date=%@&time=%@",tanningDelegate.hostString,[tanningDelegate.dbClass getUserName],lastSyncDate,lastSyncTime] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
    theRequest=[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    PackageDetailConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    NSLog(@"%@",theRequest);
    if (PackageDetailConnection) {
        // Inform the user that the download failed.
        PackageDataArray=[[NSMutableData alloc ]init];
        
        NSLog(@"JSON download youtube");
    }
    else {
        NSLog(@"JSON download fail");
    }
    //************End SocialContentDetailConnection
        
        //************ PurchaseDetailConnection
        url = [[NSURL alloc] initWithString:
               [[NSString stringWithFormat:@"%@PurchaseDetailService.php?userid=%@&format=json&num=10&date=%@&time=%@",tanningDelegate.hostString,[tanningDelegate.dbClass getUserName],lastSyncDate,lastSyncTime] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
        theRequest=[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        PurchaseDetailConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
        
        NSLog(@"%@",theRequest);
        if (PurchaseDetailConnection) {
            // Inform the user that the download failed.
            PurchaseDataArray=[[NSMutableData alloc ]init];
            
            NSLog(@"JSON download PurchaseDataArray");
        }
        else {
            NSLog(@"PurchaseDataArray JSON download fail");
        }
        //************End PurchaseDetailConnection
        
        SocialPostWebService *socialService=[[SocialPostWebService alloc]init];
        
        [socialService callManualSocialPost];
    }
    else{
        
        UIAlertView *alertVw=[[UIAlertView alloc]initWithTitle:@"Network Error" message:@"No network found. Please check your setting." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertVw show];
    }
    
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if(activityDetailConnection==connection){
        
        [activityDataArray setLength:0];
    }
    if(SocialWeightDetailConnection==connection){
        
        [SocialWeightDataArray setLength:0];
    }
    if(SocialContentDetailConnection==connection){
        
        [SocialContentDataArray setLength:0];
    }
    if(PackageDetailConnection==connection){
        
        [PackageDataArray setLength:0];
    }
    if(UploadTimeDetailConnection==connection){
        
        [UploadTimeDataArray setLength:0];
    }
    if(PurchaseDetailConnection==connection){
        
        [PurchaseDataArray setLength:0];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if(activityDetailConnection==connection){
        
        [activityDataArray appendData:data];
    }
    if(SocialWeightDetailConnection==connection){
        
        [SocialWeightDataArray appendData:data];
    }
    if(SocialContentDetailConnection==connection){
        
        [SocialContentDataArray appendData:data];
    }
    if(PackageDetailConnection==connection){
        
        [PackageDataArray appendData:data];
    }
    if(UploadTimeDetailConnection==connection){
        
        [UploadTimeDataArray appendData:data];
    }
    if(PurchaseDetailConnection==connection){
        
        [PurchaseDataArray appendData:data];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (connection==activityDetailConnection) {
        
        NSString *responseString = [[NSString alloc] initWithData:activityDataArray encoding:NSUTF8StringEncoding];
        // [responseData release];
        
        NSLog(@"responseString %@",responseString);
        
        NSError *error;
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSMutableDictionary *jsonDictionary = [parser objectWithString:responseString error:nil];
        
        NSArray *nodes = (NSArray*)[jsonDictionary objectForKey:@"posts"];
        
        //(activityId TEXT,username TEXT , socialtype TEXT, activitytype TEXT,activitytitle TEXT, activitydate TEXT, expiredate TEXT, amount TEXT,point TEXT, status TEXT)"
        
        for (NSDictionary *node in nodes){
            
            ActivityLogDBClass *activityLog=[[ActivityLogDBClass alloc]init];
            
            activityLog.activityId=[[node objectForKey:@"post"] objectForKey:@"activityId"];
            activityLog.username=[[node objectForKey:@"post"] objectForKey:@"user_name"];
            activityLog.socialtype=[[node objectForKey:@"post"] objectForKey:@"social_type"];
            activityLog.activitytype=[[node objectForKey:@"post"] objectForKey:@"activity_type"];
            activityLog.activitytitle=[[node objectForKey:@"post"] objectForKey:@"activity_title"];
            activityLog.activitydate=[[node objectForKey:@"post"] objectForKey:@"activity_date"];
            activityLog.expiredate=[[node objectForKey:@"post"] objectForKey:@"expire_date"];
            activityLog.amount=[[node objectForKey:@"post"] objectForKey:@"amount"];
            activityLog.point=[[node objectForKey:@"post"] objectForKey:@"point"];
            activityLog.status=[[node objectForKey:@"post"] objectForKey:@"status"];
            
            [tanningDelegate.dbClass insertActivityData:activityLog];
            
        }
        
        [tanningDelegate callActivityStatusService];
        ++serviceCounter;
    }
    
    if (connection==SocialWeightDetailConnection) {
        
        NSString *responseString = [[NSString alloc] initWithData:SocialWeightDataArray encoding:NSUTF8StringEncoding];
        // [responseData release];
        
        NSLog(@"responseString %@",responseString);
        
        NSError *error;
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSMutableDictionary *jsonDictionary = [parser objectWithString:responseString error:nil];
        
        NSArray *nodes = (NSArray*)[jsonDictionary objectForKey:@"posts"];
        
        //(activityId TEXT,username TEXT , socialtype TEXT, activitytype TEXT,activitytitle TEXT, activitydate TEXT, expiredate TEXT, amount TEXT,point TEXT, status TEXT)"
        
        for (NSDictionary *node in nodes){
            
            SocialWeightDetailDBClass *socialDBClass=[[SocialWeightDetailDBClass alloc]init];
            
            socialDBClass.FacebookPoints=[[node objectForKey:@"post"] objectForKey:@"FacebookPoints"];
            socialDBClass.TwitterPoints=[[node objectForKey:@"post"] objectForKey:@"TwitterPoints"];
            socialDBClass.InstagramPoints=[[node objectForKey:@"post"] objectForKey:@"InstagramPoints"];
            socialDBClass.FourSquarePoints=[[node objectForKey:@"post"] objectForKey:@"FourSquarePoints"];
            socialDBClass.UpdatedDate=[[node objectForKey:@"post"] objectForKey:@"UpdatedDate"];
            [tanningDelegate.dbClass insertSocialPointWeight:socialDBClass];
            
        }
        ++serviceCounter;
    }
    
    if (connection==SocialContentDetailConnection) {
        
        NSString *responseString = [[NSString alloc] initWithData:SocialContentDataArray encoding:NSUTF8StringEncoding];
        // [responseData release];
        
        NSLog(@"SocialContentDetailConnection responseString %@",responseString);
        
        NSError *error;
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSMutableDictionary *jsonDictionary = [parser objectWithString:responseString error:nil];
        
        NSArray *nodes = (NSArray*)[jsonDictionary objectForKey:@"posts"];
        
        //(activityId TEXT,username TEXT , socialtype TEXT, activitytype TEXT,activitytitle TEXT, activitydate TEXT, expiredate TEXT, amount TEXT,point TEXT, status TEXT)"
        
        for (NSDictionary *node in nodes){
            
            PackageDetailDBClass *pkgDBClass=[[PackageDetailDBClass alloc]init];
            
            pkgDBClass.pkgID=[[node objectForKey:@"post"] objectForKey:@"Id"];
            pkgDBClass.pkgTitle=[[node objectForKey:@"post"] objectForKey:@"Title"];
            pkgDBClass.pkgDescription=[[node objectForKey:@"post"] objectForKey:@"Description"];
            pkgDBClass.pkgImagePath=[[node objectForKey:@"post"] objectForKey:@"ImgPath"];
            pkgDBClass.AddedDate=[[node objectForKey:@"post"] objectForKey:@"AddedDate"];
            pkgDBClass.pkgLink=[[node objectForKey:@"post"] objectForKey:@"Hyperlink"];
            pkgDBClass.imgName=[[node objectForKey:@"post"] objectForKey:@"imgname"];
            pkgDBClass.isActive=[[node objectForKey:@"post"] objectForKey:@"isActive"];
            [tanningDelegate.dbClass insertSocialShareData:pkgDBClass];
            
        }
        ++serviceCounter;
    }
    
    if (connection==PackageDetailConnection) {
        
        NSString *responseString = [[NSString alloc] initWithData:PackageDataArray encoding:NSUTF8StringEncoding];
        // [responseData release];
        
        NSLog(@" PackageDetailConnection responseString %@",responseString);
        
        NSError *error;
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSMutableDictionary *jsonDictionary = [parser objectWithString:responseString error:nil];
        
        NSArray *nodes = (NSArray*)[jsonDictionary objectForKey:@"posts"];
        
        //(activityId TEXT,username TEXT , socialtype TEXT, activitytype TEXT,activitytitle TEXT, activitydate TEXT, expiredate TEXT, amount TEXT,point TEXT, status TEXT)"
        
        for (NSDictionary *node in nodes){
            
            PackageDetailDBClass *pkgDBClass=[[PackageDetailDBClass alloc]init];
            
            pkgDBClass.pkgID=[[node objectForKey:@"post"] objectForKey:@"pkgId"];
            pkgDBClass.pkgTitle=[[node objectForKey:@"post"] objectForKey:@"pkgTitle"];
            pkgDBClass.pkgDescription=[[node objectForKey:@"post"] objectForKey:@"pkgDescription"];
            pkgDBClass.pkgImagePath=[[node objectForKey:@"post"] objectForKey:@"pkgImagePath"];
            pkgDBClass.AddedDate=[[node objectForKey:@"post"] objectForKey:@"AddedDate"];
            pkgDBClass.pkgPoints=[[node objectForKey:@"post"] objectForKey:@"pkgPoints"];
            pkgDBClass.pkgAmount=[[node objectForKey:@"post"] objectForKey:@"pkgAmount"];
            pkgDBClass.isActive=[[node objectForKey:@"post"] objectForKey:@"isActive"];
            pkgDBClass.pkgType=[[node objectForKey:@"post"] objectForKey:@"pkgType"];
            pkgDBClass.imgName=[[node objectForKey:@"post"] objectForKey:@"imgname"];
            pkgDBClass.pkgDurationType=[[node objectForKey:@"post"] objectForKey:@"pkgduration"];
            [tanningDelegate.dbClass insertPackageDetail:pkgDBClass];
            
        }
        ++serviceCounter;
    }
    
    if (connection==PurchaseDetailConnection) {
        
        NSString *responseString = [[NSString alloc] initWithData:PurchaseDataArray encoding:NSUTF8StringEncoding];
        
        NSLog(@" PurchaseDetailConnection responseString %@",responseString);
        
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSMutableDictionary *jsonDictionary = [parser objectWithString:responseString error:nil];
        
        NSArray *nodes = (NSArray*)[jsonDictionary objectForKey:@"posts"];
        
        //CREATE TABLE IF NOT EXISTS purchasedetail (ArticleId TEXT , ArticleTitle TEXT, Amount TEXT, AddedDate TEXT,ExpireDate TEXT, ArticleDesc TEXT, type TEXT, redeemedDate TEXT, isRedeemed TEXT)
        
        for (NSDictionary *node in nodes){
            
            PurchaseDBClass *pkgDBClass=[[PurchaseDBClass alloc]init];
            
            pkgDBClass.pkgId=[[node objectForKey:@"post"] objectForKey:@"pkgId"];
            pkgDBClass.pkgTitle=[[node objectForKey:@"post"] objectForKey:@"pkgtitle"];
            pkgDBClass.pkgDescription=[[node objectForKey:@"post"] objectForKey:@"pkgdesc"];
            pkgDBClass.AddedDate=[[node objectForKey:@"post"] objectForKey:@"startdate"];
            pkgDBClass.ExpireDate=[[node objectForKey:@"post"] objectForKey:@"expirydate"];
            pkgDBClass.pkgAmount=[[node objectForKey:@"post"] objectForKey:@"amount"];
            pkgDBClass.type=[[node objectForKey:@"post"] objectForKey:@"pkgType"];
            pkgDBClass.redeemedDate=[[node objectForKey:@"post"] objectForKey:@"redeemdate"];
            pkgDBClass.isRedeemed=[[node objectForKey:@"post"] objectForKey:@"isRedeemed"];
            
            [tanningDelegate.dbClass insertPurchaseDetailsFromServer:pkgDBClass];
            
        }
        ++serviceCounter;
    }
    
    if (connection==UploadTimeDetailConnection) {
        
         NSString *responseString = [[NSString alloc] initWithData:UploadTimeDataArray encoding:NSUTF8StringEncoding];
        [tanningDelegate.dbClass UpdateLastSyncTime:responseString];
        ++serviceCounter;
    }
    
    if (serviceCounter==5) {
        
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
        
        UpdateUserDetailsService *updateService=[[UpdateUserDetailsService alloc]init];
        
        [updateService updateUserDetails];
       
    }
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    NSLog(@"Error %@",error);
    [tanningDelegate.dbClass hideIndicator];
}

@end
