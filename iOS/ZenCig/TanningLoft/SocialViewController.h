//
//  SocialViewController.h
//  TanningLoft
//
//  Created by Lavi on 30/06/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SocialViewController : UIViewController<UIWebViewDelegate>{
    UIActivityIndicatorView *actView;
}
@property(nonatomic,retain)IBOutlet UIWebView *webview;
@end
