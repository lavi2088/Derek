//
//  ActivitySocialDetailViewController.h
//  TanningLoft
//
//  Created by Lavi Gupta on 08/08/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivitySocialDetailViewController : UIViewController<UIWebViewDelegate>
{
    NSURLConnection  *postDetailConnection;
    NSMutableData *postDataArray;
}
@property(nonatomic,retain)NSString *postID;
@property(nonatomic,retain)IBOutlet UIWebView *webview;
@end
