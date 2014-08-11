//
//  BrowseViewController.m
//  TanningLoft
//
//  Created by Lavi on 09/05/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "BrowseViewController.h"
#import "ContactInfoViewController.h"
#import "ShopViewController.h"
#import "AccountViewController.h"
#import "AboutUsViewController.h"
#import "MobileShopViewController.h"
#import "SocialViewController.h"
#import "LocationViewController.h"
#import "CRGradientNavigationBar.h"
#import "TermsAndConditionViewController.h"

@interface BrowseViewController ()
{
    IBOutlet UILabel *messagetextLbl;
    IBOutlet UIButton *locationBtn;
}
@end

@implementation BrowseViewController
@synthesize termsLbl,scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Browse", @"Browse");
        //self.tabBarItem.image = [UIImage imageNamed:@"browse"];
        self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:230.0/255.0 green:226.0/255.0 blue:225.0/255.0 alpha:1.0];
        self.navigationItem.title=@"Browse";
        

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    categoryArray=[[NSArray alloc]initWithObjects:@"Shop",@"Contact Info",@"Locations",@"Our Beds",@"Job",@"News", nil];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;   // iOS 7 specific
    self.navigationController.navigationBar.translucent = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:230.0/255.0 green:226.0/255.0 blue:225.0/255.0 alpha:1.0];
    // Customize the title text for *all* UINavigationBars
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:16.0/255.0 green:16.0/255.0 blue:16.0/255.0 alpha:1.0], NSForegroundColorAttributeName,nil]];
    
    self.navigationController.navigationBar.clipsToBounds = YES;
    
    termsLbl.userInteractionEnabled = YES;
    UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(termsAction:)];
    [termsLbl addGestureRecognizer:gr];
    gr.numberOfTapsRequired = 1;
    gr.cancelsTouchesInView = NO;
    
    //scrollView.contentSize=CGSizeMake(320, 450);
    
    if ([[UIScreen mainScreen] bounds].size.height<=480) {
        
        messagetextLbl.frame=CGRectMake(messagetextLbl.frame.origin.x, locationBtn.frame.origin.y+locationBtn.frame.size.height+40, messagetextLbl.frame.size.width, messagetextLbl.frame.size.height);
        termsLbl.frame=CGRectMake(termsLbl.frame.origin.x, messagetextLbl.frame.origin.y+messagetextLbl.frame.size.height-25, termsLbl.frame.size.width, termsLbl.frame.size.height);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 30;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [categoryArray count];    //count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:MyIdentifier];
       // [cell setAccessoryType:UITableViewCellSeparatorStyleSingleLine];
    }
    
    // Here we use the provided setImageWithURL: method to load the web image
    // Ensure you use a placeholder image otherwise cells will be initialized with no image
//   // [cell.imageView setImageWithURL:[NSURL URLWithString:@"http://example.com/image.jpg"]
//                   placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cell.textLabel.text = [categoryArray objectAtIndex:indexPath.row];
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.textLabel.font=[UIFont fontWithName:@"Arial" size:14];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row==0) {
        ShopViewController *sc=[[ShopViewController alloc]init];
        
        [self.navigationController pushViewController:sc animated:YES];
        
    }

    else if (indexPath.row==1) {
        ContactInfoViewController *vc=[[ContactInfoViewController alloc]init];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

-(IBAction)shopBtnClicked:(id)sender{
    
    MobileShopViewController *mobileVC=[[MobileShopViewController alloc]init];
    
    [self.navigationController pushViewController:mobileVC animated:YES];

}

-(IBAction)accountBtnClicked:(id)sender{
    
    AccountViewController *acVC=[[AccountViewController alloc]init];
    
    [self.navigationController pushViewController:acVC animated:YES];
}

-(IBAction)ourBedBtnClicked:(id)sender{
   
    ShopViewController *sc=[[ShopViewController alloc]init];
    
    [self.navigationController pushViewController:sc animated:YES];
}

-(IBAction)callUsBtnClicked:(id)sender{
    
    ContactInfoViewController *vc=[[ContactInfoViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

-(IBAction)locationBtnClicked:(id)sender{
    LocationViewController *vc=[[LocationViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];

}

-(IBAction)abputUsBtnClicked:(id)sender{
    AboutUsViewController *vc=[[AboutUsViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

-(IBAction)emailUsBtnClicked:(id)sender{
    
}

-(IBAction)newsBtnClicked:(id)sender{
    
}

-(IBAction)jobsBtnClicked:(id)sender{
    
}

-(IBAction)socialBtnClicked:(id)sender{
    
    SocialViewController *vc=[[SocialViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)drawRect:(CGRect)rect {
    UIColor *color = [UIColor redColor];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColor(context, CGColorGetComponents( [color CGColor]));
    CGContextFillRect(context, rect);
}

-(IBAction)termsAction:(id)sender{
    
    TermsAndConditionViewController *termsVC=[[TermsAndConditionViewController alloc]init];
    
    [self.navigationController pushViewController:termsVC animated:YES];
}
@end
