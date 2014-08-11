//
//  InstagramLoginViewController.h
//  TanningLoft
//
//  Created by Lavi on 01/06/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
@interface InstagramLoginViewController : UIViewController<UIWebViewDelegate>
{
     UIActivityIndicatorView *spinner;
    NSURLConnection  *pointDetailConnection;
    NSMutableData *pointDataArray;
}
@property(nonatomic,retain)IBOutlet UIWebView *webview;
@property(nonatomic,retain) NSString *accessToken;
@property(nonatomic,retain) NSString *userId;

@end
