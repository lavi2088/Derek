//
//  SignUpViewController.h
//  TanningLoft
//
//  Created by Lavi Gupta on 03/08/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegexKitLite.h"

@interface SignUpViewController : UIViewController
{
    NSMutableArray *signUpArray;
    NSURLConnection  *signUpConnection;
    NSMutableData *signUpDataArray;
}
@property(nonatomic,retain)IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain)IBOutlet UITextField *userNametxt;
@property(nonatomic,retain)IBOutlet UITextField *passwordTxt;
@property(nonatomic,retain)IBOutlet UITextField *firstNameTxt;
@property(nonatomic,retain)IBOutlet UITextField *lastNameTxt;
@property(nonatomic,retain)IBOutlet UITextField *emailTxt;
@property(nonatomic,retain)IBOutlet UITextField *signUpPwdTxt;
@property(nonatomic,retain)IBOutlet UITextField *signUpConfirmPwdTxt;

-(IBAction)loginBtnClicked:(id)sender;
-(IBAction)submitButtonClicked:(id)sender;
@end
