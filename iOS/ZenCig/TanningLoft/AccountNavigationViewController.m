//
//  AccountNavigationViewController.m
//  TanningLoft
//
//  Created by Lavi on 03/07/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "AccountNavigationViewController.h"
#import "SettingViewController.h"
#import "MyPointsViewController.h"
#import "ActivityLogViewController.h"
#import "AccountViewController.h"
#import "MessageViewController.h"
#import "TermsAndConditionViewController.h"
#import "AppDelegate.h"
#import "Constant.h"

@interface AccountNavigationViewController (){
    IBOutlet UILabel *messageTitleLbl;
    IBOutlet UIButton *messageBtn;
}

@property (strong,nonatomic) IBOutlet FBProfilePictureView *userProfileImage;
@property(nonatomic,retain)IBOutlet UILabel *username;
@property(nonatomic,retain)IBOutlet UILabel *memeberSince;
@end

@implementation AccountNavigationViewController
@synthesize userProfileImage,username,memeberSince,msgVC,termsLbl,settingVC,scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Account", @"Account");
        //self.tabBarItem.image = [UIImage imageNamed:@"reserve"];
        self.navigationItem.title=@"My Account";

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;   // iOS 7 specific
    self.navigationController.navigationBar.translucent = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:230.0/255.0 green:226.0/255.0 blue:225.0/255.0 alpha:1.0];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:16.0/255.0 green:16.0/255.0 blue:16.0/255.0 alpha:1.0], NSForegroundColorAttributeName,nil]];
    
    if (FBSession.activeSession.isOpen) {
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection,
           NSDictionary<FBGraphUser> *user,
           NSError *error) {
             if (!error) {
                 // self.userNameLbl.text =  user.name;
                 self.userProfileImage.profileID = [user objectForKey:@"id"];
                 
                 //user.username
                 
             }
         }];
    }
    
    DBConnectionClass *dbCon=[[DBConnectionClass alloc]init];
    username.text=[NSString stringWithFormat:@"%@ ",[dbCon getFirstName]];
    memeberSince.text=[NSString stringWithFormat:@"ZENCIG fan since %@ ",[dbCon getMemberSinceDate]];
    
    self.navigationController.navigationBar.clipsToBounds = YES;
    
    termsLbl.userInteractionEnabled = YES;
    UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(termsAction:)];
    [termsLbl addGestureRecognizer:gr];
    gr.numberOfTapsRequired = 1;
    gr.cancelsTouchesInView = NO;
    
    if ([[UIScreen mainScreen] bounds].size.height<=480) {
        
        messageTitleLbl.frame=CGRectMake(messageTitleLbl.frame.origin.x, messageBtn.frame.origin.y+messageBtn.frame.size.height+40, messageTitleLbl.frame.size.width, messageTitleLbl.frame.size.height);
        termsLbl.frame=CGRectMake(termsLbl.frame.origin.x, messageTitleLbl.frame.origin.y+messageTitleLbl.frame.size.height-10, termsLbl.frame.size.width, termsLbl.frame.size.height);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)activityLogsBtnClicked:(id)sender{
    ActivityLogViewController *activityVC=[[ActivityLogViewController alloc]init];
    [self.navigationController pushViewController:activityVC animated:YES];
}


-(IBAction)myPointsBtnClicked:(id)sender{
    
    if([tanningDelegate.dbClass connected])
    {
        AccountViewController *myPointVC=[[AccountViewController alloc]init];
        [self.navigationController pushViewController:myPointVC animated:YES];
    }
    else{
        
        [tanningDelegate.dbClass showNetworkALert];
    }
}


-(IBAction)myPurchasesBtnClicked:(id)sender{
     self.settingVC=[[SettingViewController alloc]init];
    [self.navigationController pushViewController:settingVC animated:YES];
}

-(IBAction)messageBtnClicked:(id)sender{
    msgVC=[[MessageViewController alloc]init];
    [self.navigationController pushViewController:msgVC animated:YES];
}

-(IBAction)termsAction:(id)sender{
    
    TermsAndConditionViewController *termsVC=[[TermsAndConditionViewController alloc]init];
    
    [self.navigationController pushViewController:termsVC animated:YES];
}
@end
