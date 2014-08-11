//
//  AccountNavigationViewController.h
//  TanningLoft
//
//  Created by Lavi on 03/07/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageViewController.h"
#import "SettingViewController.h"

@interface AccountNavigationViewController : UIViewController
@property(nonatomic,retain)MessageViewController *msgVC;
@property(nonatomic,retain)IBOutlet UILabel *termsLbl;
@property(nonatomic,retain)SettingViewController *settingVC;
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
-(IBAction)messageBtnClicked:(id)sender;
@end
