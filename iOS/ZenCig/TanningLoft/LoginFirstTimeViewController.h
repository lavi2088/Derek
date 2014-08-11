//
//  LoginFirstTimeViewController.h
//  MexicanAmigos
//
//  Created by Lavi Gupta on 14/08/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "RegexKitLite.h"

@interface LoginFirstTimeViewController : UIViewController{
    NSMutableArray *signUpArray;
    NSURLConnection  *signUpConnection;
    NSMutableData *signUpDataArray;
}
@property(nonatomic,retain)IBOutlet UITextField *userNametxt;
@property(nonatomic,retain)IBOutlet UITextField *passwordTxt;
@property(nonatomic,retain)IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain)IBOutlet UILabel *signup;
@property(nonatomic,retain)IBOutlet UILabel *forgotpwd;
@property(nonatomic,retain)IBOutlet UIButton *termsandConditionBtn;
@property(nonatomic,retain)IBOutlet UILabel *termsAndConditionLbl;
-(IBAction)loginBtnClicked:(id)sender;
@end
