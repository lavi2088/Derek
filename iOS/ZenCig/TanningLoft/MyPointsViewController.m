//
//  MyPointsViewController.m
//  TanningLoft
//
//  Created by Lavi on 04/08/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "MyPointsViewController.h"
#import "ActivityLogCell.h"
#import "AppDelegate.h"
#import "Constant.h"
#import "DBConnectionClass.h"
#import "ActivityLogDBClass.h"

@interface MyPointsViewController ()

@end

@implementation MyPointsViewController
@synthesize tblView,logArray;
@synthesize totalPoints;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;   // iOS 7 specific
    self.navigationController.navigationBar.translucent = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    
    logArray=[[NSMutableArray alloc]init];
    logArray=[tanningDelegate.dbClass fetchSocialActivitydata];
    
    pointsArray=[[NSMutableArray alloc]init];
    [pointsArray addObject:@"0"];
    [pointsArray addObject:@"0"];
    [pointsArray addObject:@"0"];
    [pointsArray addObject:@"0"];
    [pointsArray addObject:@"0"];
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@pointdetailjson.php?userid=%@&format=json&num=10",tanningDelegate.hostString,[tanningDelegate.dbClass getUserName]] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
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
    return 44;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return logArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"Cell";
    
    ActivityLogCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ActivityLogCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    // Here we use the provided setImageWithURL: method to load the web image
    // Ensure you use a placeholder image otherwise cells will be initialized with no image
    //   // [cell.imageView setImageWithURL:[NSURL URLWithString:@"http://example.com/image.jpg"]
    //                   placeholderImage:[UIImage imageNamed:@"placeholder"]];
    ActivityLogDBClass *activityDBClass=[[ActivityLogDBClass alloc]init];
    
    activityDBClass=[logArray objectAtIndex:indexPath.row];
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss +SSSS"];
    NSDate *activityFormatDate=[formatter dateFromString:activityDBClass.activitydate];
    NSDate *expireFormatDate=[formatter dateFromString:activityDBClass.expiredate];
    
    if ([activityDBClass.activitytype isEqualToString:@"S"]) {
        
        if ([activityDBClass.socialtype isEqualToString:@"F"]) {
            
            cell.socialImg.image=[UIImage imageNamed:@"facebookicon"];
        }
        else if([activityDBClass.socialtype isEqualToString:@"T"]){
            cell.socialImg.image=[UIImage imageNamed:@"twittericon"];
        }
        else if([activityDBClass.socialtype isEqualToString:@"I"]){
            cell.socialImg.image=[UIImage imageNamed:@"istagramicon"];
        }
        else if([activityDBClass.socialtype isEqualToString:@"FR"]){
            cell.socialImg.image=[UIImage imageNamed:@"foursquareicon"];
        }
    }
    else{
        cell.socialImg.image=[UIImage imageNamed:@"redeemIcon"];
    }
    [formatter setDateFormat:@"MMM dd yyyy"];
    cell.title.text=activityDBClass.activitytitle;
    cell.date.text=[formatter stringFromDate:activityFormatDate];
    cell.points.text=[NSString stringWithFormat:@"%@ pts",activityDBClass.point];
    
    if ([activityDBClass.activitytype isEqualToString:@"FREE"]) {
        cell.points.text=@"FREE";
    }
    return cell;
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
            
            [tanningDelegate.dbClass updatePoints:[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"fbpoint"] :[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"twpoint"] :[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"istpoint"] :[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"fourpoint"] :[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"spinpoint"] ];
        }
        
        
        // [pointTable reloadData];
        //[self reloadPoints];
        [self totalPoints];
        
    }
    
}

-(void)totalPoints{
    int point=0;
    for (int i=0; i<[pointsArray count]; i++) {
        point=point+[[pointsArray objectAtIndex:i] integerValue];
    }
    
    totalPoints.text=[NSString stringWithFormat:@"%d pts",point];
}
-(void)reloadPoints{
    //    fbPoint.text=[pointsArray objectAtIndex:0];
    //    twPoint.text=[pointsArray objectAtIndex:1];
    //    instaPoint.text=[pointsArray objectAtIndex:2];
    //    fourSquarePoint.text=[pointsArray objectAtIndex:3];
    //    spinPoint.text=[pointsArray objectAtIndex:4];
    
}

-(IBAction)backBtnClicked:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
