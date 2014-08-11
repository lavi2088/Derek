//
//  IstagramViewController.h
//  TanningLoft
//
//  Created by Lavi on 01/06/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "DBConnectionClass.h"
#import "MGInstagram.h"
@interface IstagramViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate>
{
    IBOutlet FBProfilePictureView *userProfileImage;
    IBOutlet UIButton *sharePhotos;
    IBOutlet UITableView *FBTblVwOfArticles;
    NSMutableArray *articleTite;
    NSMutableArray *articleDesc;
    NSMutableArray *pictureNameArray;
    NSMutableArray *pictureServerArray;
    NSURLConnection  *shareDetailConnection;
    NSMutableData *shareDataArray;
    UIWebView *webview;
    UIActivityIndicatorView *spinner;
    UIImagePickerController *picker;
     DBConnectionClass *dbClass;
}
@property (strong,nonatomic)FBProfilePictureView *userProfileImage;
@property(nonatomic,retain)IBOutlet UILabel *userNameLbl;
@property(nonatomic,retain)IBOutlet UIButton *sharePhotos;
@property(nonatomic,retain)IBOutlet UITableView *FBTblVwOfArticles;
@property(nonatomic,retain) NSMutableArray *articleTite;
@property(nonatomic,retain) NSMutableArray *articleDesc;
@property(nonatomic,retain) NSMutableArray *pictureNameArray;
@property(nonatomic,retain)  NSMutableArray *pictureServerArray;
@property(nonatomic,retain)  UIWebView *webview;
@property(nonatomic,retain) IBOutlet UILabel *points;
@property(nonatomic,retain)IBOutlet UIView *containerView;
@property(nonatomic,retain)IBOutlet UIImageView *tooltipImg;
@property(nonatomic,retain)IBOutlet UIScrollView *scrollView;

-(IBAction)SharePhotosBtnClicked:(id)sender;
@end
