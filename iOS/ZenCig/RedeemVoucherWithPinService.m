//
//  RedeemVoucherWithPinService.m
//  MyMobiPoints
//
//  Created by Macmini on 24/12/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "RedeemVoucherWithPinService.h"
#import "GetServerCurrentTimeWebService.h"
#import "PurchaseTanDetailViewController.h"

@implementation RedeemVoucherWithPinService

-(void)callPinRedeemService:(NSString *)pin : (NSString *)pkgId{
    
    //************UploadTimeDataArray
    
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@redeemVoucherPinService.php?userid=%@&pkgId=%@&pin=%@",tanningDelegate.hostString,[tanningDelegate.dbClass getUserName],pkgId,pin] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    UploadTimeDetailConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    NSLog(@"%@",theRequest);
    if (UploadTimeDetailConnection) {
        // Inform the user that the download failed.
        UploadTimeDataArray=[[NSMutableData alloc ]init];
        NSLog(@"callPinRedeemService JSON download");
    }
    else {
        NSLog(@"callPinRedeemService JSON download fail");
    }
    
    //************End UploadTimeDataArray
    
    GetServerCurrentTimeWebService *serverTimeSer=[[GetServerCurrentTimeWebService alloc]init];
    
    [serverTimeSer callCurrentServerTimeService];
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
        
        [tanningDelegate.dbClass hideIndicator];
        
        NSString *responseString = [[NSString alloc] initWithData:UploadTimeDataArray encoding:NSUTF8StringEncoding];
        NSLog(@"%@",responseString);
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSMutableDictionary *jsonDictionary = [parser objectWithString:responseString];
        NSString *responseStatus = [jsonDictionary objectForKey:@"success"];
        
        NSLog(@"responseStatus %@ %@",responseStatus,jsonDictionary);
        
        if ([responseStatus isEqualToString:@"200"]) {
            
            [tanningDelegate.dbClass updatePurchaseAfterRedeemed:[jsonDictionary objectForKey:@"pkgId"]];
            
            if([[tanningDelegate.reserveNavController topViewController] isKindOfClass:[PurchaseTanDetailViewController class]])
            {
                GetServerCurrentTimeWebService *serverTimeSer=[[GetServerCurrentTimeWebService alloc]init];
                
                [serverTimeSer callCurrentServerTimeService];
           
                PurchaseTanDetailViewController *puchaseTanVC=(PurchaseTanDetailViewController *)[tanningDelegate.reserveNavController topViewController];
                [puchaseTanVC reloadPackageAfterRedem:@"1"];
            }
        }
        else{
            PurchaseTanDetailViewController *puchaseTanVC=(PurchaseTanDetailViewController *)[tanningDelegate.reserveNavController topViewController];
            [puchaseTanVC reloadPackageAfterRedem:@"0"];
        }
        
        
    }
}
@end
