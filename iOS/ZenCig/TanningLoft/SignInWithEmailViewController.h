//
//  SignInWithEmailViewController.h
//  GregMayHair
//
//  Created by Lavi Gupta on 07/09/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignInWithEmailViewController : UIViewController{
    NSMutableArray *signUpArray;
    NSURLConnection  *signUpConnection;
    NSMutableData *signUpDataArray;
}
@property(nonatomic,retain)IBOutlet UITextField *userNametxt;
@property(nonatomic,retain)IBOutlet UITextField *passwordTxt;
@property(nonatomic,retain)IBOutlet UILabel *signup;
@property(nonatomic,retain)IBOutlet UILabel *forgotpwd;
@end
