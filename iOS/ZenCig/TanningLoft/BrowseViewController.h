//
//  BrowseViewController.h
//  TanningLoft
//
//  Created by Lavi on 09/05/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrowseViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *categoryArray;
    UITableView *browseTable;
}
@property(nonatomic,retain) IBOutlet UILabel *termsLbl;
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
-(IBAction)shopBtnClicked:(id)sender;
-(IBAction)accountBtnClicked:(id)sender;
-(IBAction)ourBedBtnClicked:(id)sender;
-(IBAction)callUsBtnClicked:(id)sender;
-(IBAction)locationBtnClicked:(id)sender;
-(IBAction)abputUsBtnClicked:(id)sender;
-(IBAction)emailUsBtnClicked:(id)sender;
-(IBAction)newsBtnClicked:(id)sender;
-(IBAction)jobsBtnClicked:(id)sender;
@end
