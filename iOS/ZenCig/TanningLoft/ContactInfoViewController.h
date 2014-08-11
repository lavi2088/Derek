//
//  ContactInfoViewController.h
//  TanningLoft
//
//  Created by Lavi on 13/05/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactInfoViewController : UIViewController<UIAlertViewDelegate>
@property(nonatomic,retain)IBOutlet UILabel *emailLbl;
@property(nonatomic,retain)IBOutlet UILabel *websiteLbl;
@property(nonatomic,retain)IBOutlet UILabel *phoneLbl;

@property(nonatomic,retain)IBOutlet UILabel *lbl1;
@property(nonatomic,retain)IBOutlet UILabel *lbl2;
@property(nonatomic,retain)IBOutlet UILabel *lbl3;
@property(nonatomic,retain)IBOutlet UILabel *lbl4;
@property(nonatomic,retain)IBOutlet UITextView *tw1;
@end
