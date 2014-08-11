//
//  ForgotPasswordViewController.h
//  MexicanAmigos
//
//  Created by Lavi Gupta on 15/08/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgotPasswordViewController : UIViewController
{
    NSMutableArray *signUpArray;
    NSURLConnection  *signUpConnection;
    NSMutableData *signUpDataArray;
}
@property(nonatomic,retain)IBOutlet UITextField *emailTxt;
-(IBAction)submitButtonClicked:(id)sender;
-(IBAction)cancelButtonClicked:(id)sender;
@end
