//
//  MyPointsViewController.h
//  TanningLoft
//
//  Created by Lavi on 04/08/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPointsViewController : UIViewController
{
NSMutableArray *pointsArray;
NSURLConnection  *pointDetailConnection;
NSMutableData *pointDataArray;
}
@property(nonatomic,retain)IBOutlet UITableView *tblView;
@property(nonatomic,retain)NSMutableArray *logArray;
@property(nonatomic,retain)IBOutlet UILabel *totalPoints;


@end
