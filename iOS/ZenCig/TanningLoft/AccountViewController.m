//
//  AccountViewController.m
//  TanningLoft
//
//  Created by Lavi on 26/05/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "AccountViewController.h"
#import "FacebookSDK/FacebookSDK.h"
#import "AccountCell.h"
#import "SBJson.h"
#import "AppDelegate.h"
#import "Constant.h"
#import "DBConnectionClass.h"

@interface AccountViewController ()
@property (strong,nonatomic) IBOutlet FBProfilePictureView *userProfileImage;
@end

@implementation AccountViewController
@synthesize pointTotal,pointTable,pointStar;
@synthesize pointTableView,fbPoint,twPoint,spinPoint,fourSquarePoint,instaPoint,userProfileImage,username,memeberSince,bonusPoint;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Account", @"Account");
        //self.tabBarItem.image = [UIImage imageNamed:@"reserve"];
        self.navigationItem.title=@"My Account";
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchDown];
        [button setTitle:@"" forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:14]];
        button.frame=CGRectMake(0, 0, 30, 30);
        [button setBackgroundImage:[UIImage imageNamed:@"back_d"] forState:UIControlStateNormal];
        
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        [self.navigationItem setLeftBarButtonItem:barButtonItem];
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    titleArray=[[NSMutableArray alloc]init];
    [titleArray addObject:@"Facebook"];
    [titleArray addObject:@"Twitter Re-Tweet"];
    [titleArray addObject:@"Istagram Photo"];
    [titleArray addObject:@"Four Square"];
    [titleArray addObject:@"Spinning Wheel"];
    
    pointsArray=[[NSMutableArray alloc]init];
    [pointsArray addObject:@"0"];
    [pointsArray addObject:@"0"];
    [pointsArray addObject:@"0"];
    [pointsArray addObject:@"0"];
    [pointsArray addObject:@"0"];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;   // iOS 7 specific
    self.navigationController.navigationBar.translucent = NO;
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    dbClass=[[DBConnectionClass alloc]init];
    
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@pointdetailjson.php?userid=%@&format=json&num=10",tanningDelegate.hostString,[dbClass getUserName]] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    pointDetailConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    NSLog(@"%@",theRequest);
    if (pointDetailConnection) {
        // Inform the user that the download failed.
        pointDataArray=[[NSMutableData alloc ]init];
        
        //  [recievedData writeToFile:path atomically:YES];
        NSLog(@"JSON download youtube");
    }
    else {
        NSLog(@"JSON download fail");
    }

    
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:230.0/255.0 green:226.0/255.0 blue:225.0/255.0 alpha:1.0];
    self.pointTotal.text=@"0";
    
    NSLog(@" pointTableView %f",[UIScreen mainScreen].bounds.size.height);
    
    self.pointTableView.frame=CGRectMake(0, [UIScreen mainScreen].bounds.size.height-255-44-75, 320, 265);
    
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
    if (self.view.bounds.size.height<=380) {
        self.pointStar.frame=CGRectMake((self.view.frame.size.width-80)/2, self.pointStar.frame.origin.y, 80, 80);
        self.pointStar.hidden=YES;
        self.pointTotal.frame=CGRectMake((self.view.frame.size.width-pointTotal.frame.size.width)/2, self.pointStar.frame.origin.y, pointTotal.frame.size.width, pointTotal.frame.size.height);
        self.pointTotal.font=[UIFont fontWithName: @"Arial-BoldMT" size:30.0];
    }
   
}

-(void)viewDidAppear:(BOOL)animated{
    
   
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if(pointDetailConnection==connection){
        
        [pointDataArray setLength:0];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if(pointDetailConnection==connection){
        
        [pointDataArray appendData:data];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (connection==pointDetailConnection) {
        
        
            
            NSString *responseString = [[NSString alloc] initWithData:pointDataArray encoding:NSUTF8StringEncoding];
            // [responseData release];
        
            NSLog(@"responseString %@",responseString);
        
            NSError *error;
            SBJsonParser *parser = [[SBJsonParser alloc] init];
            NSMutableDictionary *jsonDictionary = [parser objectWithString:responseString error:nil];
            
            NSArray *nodes = (NSArray*)[jsonDictionary objectForKey:@"posts"];
            
             for (NSDictionary *node in nodes){
                 
                NSLog(@"NSDictionary %@", [(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"fbpoint"]);
                 NSLog(@"NSDictionary %@", [(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"twpoint"]);
                 NSLog(@"NSDictionary %@", [(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"istpoint"]);
                 NSLog(@"NSDictionary %@", [(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"fourpoint"]);
                  NSLog(@"NSDictionary %@", [(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"swpoint"]);
                 
                 [pointsArray removeAllObjects];
                 
                 [pointsArray addObject:[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"fbpoint"]];
                 [pointsArray addObject:[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"twpoint"]];
                 [pointsArray addObject:[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"istpoint"]];
                 [pointsArray addObject:[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"fourpoint"]];
                  [pointsArray addObject:[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"spinpoint"]];
                 [pointsArray addObject:[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"totalpoint"]];
                 
                 [dbClass updatePoints:[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"fbpoint"] :[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"twpoint"] :[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"istpoint"] :[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"fourpoint"] :[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"spinpoint"] ];
             }
                        
            
       // [pointTable reloadData];
        [self reloadPoints];
        [self totalPoints];
        
    }

}

-(void)totalPoints{
    int point=0;
    for (int i=0; i<[pointsArray count]; i++) {
        point=point+[[pointsArray objectAtIndex:i] integerValue];
    }
    
    pointTotal.text=[NSString stringWithFormat:@"%d points",point];
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
    
    return 36;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [titleArray count];    //count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"Cell";
    
    AccountCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"View" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    // Here we use the provided setImageWithURL: method to load the web image
    // Ensure you use a placeholder image otherwise cells will be initialized with no image
    //   // [cell.imageView setImageWithURL:[NSURL URLWithString:@"http://example.com/image.jpg"]
    //                   placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    cell.title.text=[titleArray objectAtIndex:indexPath.row];
    cell.point.text=[pointsArray objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)reloadPoints{
    fbPoint.text=[pointsArray objectAtIndex:0];
    twPoint.text=[pointsArray objectAtIndex:1];
    instaPoint.text=[pointsArray objectAtIndex:2];
    fourSquarePoint.text=[pointsArray objectAtIndex:3];
    spinPoint.text=[pointsArray objectAtIndex:4];
    bonusPoint.text=[pointsArray objectAtIndex:5];
    
}

-(IBAction)backBtnClicked:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
