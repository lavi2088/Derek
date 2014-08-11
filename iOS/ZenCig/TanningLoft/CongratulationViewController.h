//
//  CongratulationViewController.h
//  MyMobiPoints
//
//  Created by Macmini on 21/12/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageDBClass.h"
#import "AppDelegate.h"
#import "Constant.h"

@interface CongratulationViewController : UIViewController{
    NSMutableArray *pointsArray;
    NSURLConnection  *pointDetailConnection;
    NSMutableData *pointDataArray;
}
@property(nonatomic,retain)MessageDBClass *msgObj;
@property(nonatomic,retain)UIBarButtonItem *barButtonItem;
@property(nonatomic,retain)IBOutlet UILabel *title;
@property(nonatomic,retain)IBOutlet UILabel *points;
@end
