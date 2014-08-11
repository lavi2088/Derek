//
//  PlayVideoViewController.h
//  MyMobiPoints
//
//  Created by Macmini on 31/12/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayVideoViewController : UIViewController
@property(nonatomic,retain)IBOutlet UIWebView *webView;
@property(nonatomic,retain)NSString *videoURL;
@end
