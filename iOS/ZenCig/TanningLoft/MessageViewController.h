//
//  MessageViewController.h
//  MyMobiPoints
//
//  Created by Macmini on 14/12/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageViewController : UIViewController
@property(nonatomic,retain)NSMutableArray *messageArray;
@property(nonatomic,retain)IBOutlet UITableView *messageTbl;
-(void)reloadMessageTbl;
@end
