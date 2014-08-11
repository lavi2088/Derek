//
//  CaptureImageViewController.h
//  TanningLoft
//
//  Created by Lavi on 01/06/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "MGInstagram.h"

@interface CaptureImageViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate>
{
    UITextField *titleTxt;
    UITextView *descTxt;
    UIImageView *captureImage;
    UIButton *tweetBtn;
    UIButton *shareBtn;
    NSURLConnection  *shareDetailConnection;
    NSMutableData *shareDataArray;
    NSMutableArray *pictureServerArray;

}
@property(nonatomic,retain)IBOutlet UITextField *titleTxt;
@property(nonatomic,retain)IBOutlet UITextView *descTxt;
@property(nonatomic,retain)IBOutlet UIImageView *captureImage;
@property(nonatomic,retain)IBOutlet UIButton *tweetBtn;
@property(nonatomic,retain)IBOutlet UIButton *shareBtn;
@property(nonatomic,retain) UIImage *orgImg;
-(void)setImage:(UIImage *)image;

-(IBAction)shareIstagram:(id)sender;
@end
