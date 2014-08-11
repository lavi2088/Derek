//
//  CongratulationViewController.m
//  MyMobiPoints
//
//  Created by Macmini on 21/12/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "CongratulationViewController.h"

@interface CongratulationViewController ()

@end

@implementation CongratulationViewController
@synthesize barButtonItem,msgObj,title,points;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.navigationItem.title=@"Bonus Points";
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchDown];
        [button setTitle:@" " forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:14]];
        button.frame=CGRectMake(0, 0, 30, 30);
        [button setBackgroundImage:[UIImage imageNamed:@"back_d"] forState:UIControlStateNormal];
        
        barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        [self.navigationItem setLeftBarButtonItem:barButtonItem];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title.text=msgObj.title;
    
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

    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;   // iOS 7 specific
    self.navigationController.navigationBar.translucent = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)backBtnClicked:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
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
        
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSMutableDictionary *jsonDictionary = [parser objectWithString:responseString error:nil];
        
        NSArray *nodes = (NSArray*)[jsonDictionary objectForKey:@"posts"];
        
        for (NSDictionary *node in nodes){
            
            NSLog(@"NSDictionary %@", [(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"fbpoint"]);
            NSLog(@"NSDictionary %@", [(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"twpoint"]);
            NSLog(@"NSDictionary %@", [(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"istpoint"]);
            NSLog(@"NSDictionary %@", [(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"fourpoint"]);
            NSLog(@"NSDictionary %@", [(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"swpoint"]);
            
            pointsArray =[[NSMutableArray alloc]init];
            
            [pointsArray addObject:[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"fbpoint"]];
            [pointsArray addObject:[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"twpoint"]];
            [pointsArray addObject:[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"istpoint"]];
            [pointsArray addObject:[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"fourpoint"]];
            [pointsArray addObject:[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"spinpoint"]];
            [pointsArray addObject:[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"totalpoint"]];
            
            [tanningDelegate.dbClass updatePoints:[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"fbpoint"] :[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"twpoint"] :[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"istpoint"] :[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"fourpoint"] :[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"spinpoint"] ];
        }
        
        [self totalPoints];
        
    }
}

-(void)totalPoints{
    int point=0;
    for (int i=0; i<[pointsArray count]; i++) {
        point=point+[[pointsArray objectAtIndex:i] integerValue];
    }
    
    points.text=[NSString stringWithFormat:@"%d points",point];
}

@end
