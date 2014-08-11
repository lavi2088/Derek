//
//  PaypalPaymentViewController.h
//  TanningLoft
//
//  Created by Lavi Gupta on 01/09/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PackageDetailDBClass.h"

@interface PaypalPaymentWebViewViewController : UIViewController<UIWebViewDelegate>
@property(nonatomic,retain)IBOutlet UIWebView *webview;
@property(nonatomic,retain) NSString * webviewUrlString;
@property(nonatomic,retain) NSString * totalPoint;
@property(nonatomic,retain)PackageDetailDBClass *pkgObj;
@property(nonatomic,retain) NSString * pointsTotal;
@end
