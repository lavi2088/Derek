//
//  SpinWheelViewController.m
//  TanningLoft
//
//  Created by Lavi on 09/05/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "SpinWheelViewController.h"
#import "SMRotaryWheel.h"
#import "DBConnectionClass.h"
#import "AppDelegate.h"
#import "Constant.h"
#import "PurchaseDBClass.h"
@interface SpinWheelViewController ()
{
    BOOL moveSpinWheel;
    BOOL SpinWheelRotatingStatus;
    BOOL playSoundStatus;
}
@end

@implementation SpinWheelViewController
@synthesize valueLabel;
@synthesize mShipWheel;
@synthesize img1,lbl1,img2,lbl2,img3,lbl3,img4,lbl4,img5,lbl5,img6,lbl6,img7,lbl7,img8,lbl8;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    counter=0;
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Spin Wheel", @"Spin Wheel");
        //self.tabBarItem.image = [UIImage imageNamed:@"spinTabIcon"];
        self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:230.0/255.0 green:226.0/255.0 blue:225.0/255.0 alpha:1.0];
        self.navigationItem.title=@"Spin Wheel";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    counter=0;
    valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 350, 120, 30)];
    valueLabel.textAlignment = UITextAlignmentCenter;
    valueLabel.backgroundColor = [UIColor lightGrayColor];
    
    prizeArray=[[NSMutableArray alloc]init];
    [prizeArray addObject:@"1"];
    [prizeArray addObject:@"2"];
    [prizeArray addObject:@"1"];
    [prizeArray addObject:@"3"];
    [prizeArray addObject:@"5V"];
    [prizeArray addObject:@"2"];
    
    moveSpinWheel=FALSE;
    SpinWheelRotatingStatus=TRUE;
    playSoundStatus=TRUE;
    
    self.navigationController.navigationBar.clipsToBounds = YES;
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;   // iOS 7 specific
    self.navigationController.navigationBar.translucent = NO;
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:230.0/255.0 green:226.0/255.0 blue:225.0/255.0 alpha:1.0];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:16.0/255.0 green:16.0/255.0 blue:16.0/255.0 alpha:1.0], NSForegroundColorAttributeName,nil]];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    wheelStatus=1;
    
    if (FBSession.activeSession.state != FBSessionStateOpen) {
        [tanningDelegate openSession];
    }
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    if (dimView) {
        
        [dimView removeFromSuperview];
        
    }
    dimView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
    
    [dimView setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.3]];
    
    [self.view addSubview:dimView];
    
    
    
    
    if (activityIndicator) {
        [activityIndicator stopAnimating];
        [activityIndicator removeFromSuperview];
        
    }
    
    activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityIndicator.frame = CGRectMake(10.0, 0.0, 40.0, 40.0);
    activityIndicator.center = self.view.center;
    //[self.view addSubview: activityIndicator];
    
    //  [activityIndicator startAnimating];
    
    
    
    DBConnectionClass *dbClass=[[DBConnectionClass alloc]init];
    
    if([tanningDelegate.dbClass connected])
    {
        NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@postSpinLastDetail.php?userid=%@&format=json&num=10",tanningDelegate.hostString,[dbClass getUserName]] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        lastSpinDetailConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
        
        NSLog(@"%@",theRequest);
        if (lastSpinDetailConnection) {
            // Inform the user that the download failed.
            pointDataArray=[[NSMutableData alloc ]init];
            NSLog(@"JSON download youtube");
        }
        else {
            NSLog(@"JSON download fail");
        }
        
        
        
        theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@SpinWheelPointService.php?userid=%@&format=json&num=10",tanningDelegate.hostString,[dbClass getUserName]] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        SpinPointsDetailConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
        
        if (SpinPointsDetailConnection) {
            // Inform the user that the download failed.
            SpinPointsDataArray=[[NSMutableData alloc ]init];
            
            NSLog(@"SpinPointsDataArray JSON download youtube");
        }
        else {
            NSLog(@"JSON download fail");
        }
    }
    else{
        
        [tanningDelegate.dbClass showNetworkALert];
    }
    CALayer *presentation = (CALayer*)[mShipWheel.layer presentationLayer];
    
    double angle = [[presentation valueForKeyPath:@"transform.rotation.z"] doubleValue];
    
    currentAngle =  angle;
    
    NSLog(@"Dergree %f", RADIANS_TO_DEGREES(currentAngle));
    
    //***********Tarnsform Logic **********************
    
    img1.transform=CGAffineTransformMakeRotation(-M_PI/2);
    lbl1.transform=CGAffineTransformMakeRotation(-M_PI/2);
    
    img2.transform=CGAffineTransformMakeRotation(-M_PI/4);
    lbl2.transform=CGAffineTransformMakeRotation(-M_PI/4);
    
    img3.transform=CGAffineTransformMakeRotation(0);
    lbl3.transform=CGAffineTransformMakeRotation(0);
    
    img4.transform=CGAffineTransformMakeRotation(M_PI/4);
    lbl4.transform=CGAffineTransformMakeRotation(M_PI/4);
    
    img5.transform=CGAffineTransformMakeRotation(M_PI/2);
    lbl5.transform=CGAffineTransformMakeRotation(M_PI/2);
    
    img6.transform=CGAffineTransformMakeRotation(M_PI/2+M_PI/4);
    lbl6.transform=CGAffineTransformMakeRotation(M_PI/2+M_PI/4);
    
    img7.transform=CGAffineTransformMakeRotation(M_PI);
    lbl7.transform=CGAffineTransformMakeRotation(M_PI);
    
    img8.transform=CGAffineTransformMakeRotation(M_PI/2+M_PI/2+M_PI/4);
    lbl8.transform=CGAffineTransformMakeRotation(M_PI/2+M_PI/2+M_PI/4);
    
    
    GetServerCurrentTimeWebService *getService=[[GetServerCurrentTimeWebService alloc] init];
    
    [getService callCurrentServerTimeService];
    
    // Customize the title text for *all* UINavigationBars
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor whiteColor],
      UITextAttributeTextColor,
      [UIColor whiteColor],
      UITextAttributeTextShadowColor,
      [NSValue valueWithUIOffset:UIOffsetMake(0, -1)],
      UITextAttributeTextShadowOffset,[UIFont fontWithName:@"Avenir" size:20],UITextAttributeFont,
      nil]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) wheelDidChangeValue:(NSString *)newValue {
    
    //self.valueLabel.text = newValue;
    
    if (counter==0) {
        ++counter;
        return;
    }
    
    ++counter;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ZENCIG"
                                                    message:[NSString stringWithFormat:@"Congratulation! You won %@ points",newValue]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil];
    [alert show];
    
    if ([newValue isEqualToString:@"FREE TAN"]) {
        newValue=@"100";
    }
    
    DBConnectionClass *dbClass=[[DBConnectionClass alloc]init];
    float x = arc4random_uniform(10000000);
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@updateSpinningWheel.php?userid=%@&type=SP&point=%@&postid=%f",tanningDelegate.hostString,[dbClass getUserName],newValue,x] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    NSLog(@"URL %@",[[NSString stringWithFormat:@"%@updateSpinningWheel.php?userid=%@&type=SP&point=%@&postid=%f",tanningDelegate.hostString,[dbClass getUserName],newValue,x] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]);
    
    spinDetailConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    //************************************************
    
    theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@insertSpinningWheel.php?userid=%@&point=%@",tanningDelegate.hostString,[dbClass getUserName],newValue] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    spinUploadDetailConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    
    //**********************************************
    
    if (spinDetailConnection) {
        // Inform the user that the download failed.
        //shareDataArray=[[NSMutableData alloc ]init];
        
        //  [recievedData writeToFile:path atomically:YES];
        NSLog(@"JSON download youtube");
    }
    else {
        NSLog(@"JSON download fail");
    }
    
    if (lastSpinDetailConnection) {
        // Inform the user that the download failed.
        shareDataArray=[[NSMutableData alloc ]init];
        
        //  [recievedData writeToFile:path atomically:YES];
        NSLog(@"JSON download youtube");
    }
    else {
        NSLog(@"JSON download fail");
    }
    
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if(spinDetailConnection==connection){
        
        // [pointDataArray setLength:0];
        
        
    }
    if(spinUploadDetailConnection==connection){
        
        // [pointDataArray setLength:0];
    }
    if(lastSpinDetailConnection==connection){
        
        [pointDataArray setLength:0];
    }
    if(SpinPointsDetailConnection==connection){
        
        [SpinPointsDataArray setLength:0];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if(spinDetailConnection==connection){
        
        // [pointDataArray setLength:0];
    }
    if(spinUploadDetailConnection==connection){
        
        [dimView removeFromSuperview];
        
        [dimView setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.3]];
        
        [self.view addSubview:dimView];
        
        activityIndicator.frame = CGRectMake(10.0, 0.0, 40.0, 40.0);
        activityIndicator.center = self.view.center;
        
    }
    if(lastSpinDetailConnection==connection){
        
        [pointDataArray appendData:data];
    }
    
    if(SpinPointsDetailConnection==connection){
        
        [SpinPointsDataArray appendData:data];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (connection==lastSpinDetailConnection) {
        
        
        
        NSString *responseString = [[NSString alloc] initWithData:pointDataArray encoding:NSUTF8StringEncoding];
        // [responseData release];
        
        NSLog(@"responseString %@",responseString);
        spinLastData=[[NSMutableArray alloc]init];
        
        NSError *error;
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSMutableDictionary *jsonDictionary = [parser objectWithString:responseString error:nil];
        
        NSArray *nodes = (NSArray*)[jsonDictionary objectForKey:@"posts"];
        
        for (NSDictionary *node in nodes){
            
            NSLog(@"NSDictionary %@", [(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"userid"]);
            NSLog(@"NSDictionary %@", [(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"date"]);
            NSLog(@"NSDictionary %@", [(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"point"]);
            
            [spinLastData removeAllObjects];
            
            [spinLastData addObject:[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"userid"]];
            [spinLastData addObject:[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"date"]];
            [spinLastData addObject:[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"point"]];
            
        }
        
        if(spinLastData.count)
        {
            [self validateSpinWheel:[spinLastData objectAtIndex:1]];
        }
        else{
            
            [dimView removeFromSuperview];
            [activityIndicator stopAnimating];
            [activityIndicator removeFromSuperview];
            wheelStatus=0;
        }
        
    }
    
    if (connection==SpinPointsDetailConnection) {
        
        
        
        NSString *responseString = [[NSString alloc] initWithData:SpinPointsDataArray encoding:NSUTF8StringEncoding];
        // [responseData release];
        
        NSLog(@"responseString %@",responseString);
        spinLastData=[[NSMutableArray alloc]init];
        
        NSError *error;
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSMutableDictionary *jsonDictionary = [parser objectWithString:responseString error:nil];
        
        NSArray *nodes = (NSArray*)[jsonDictionary objectForKey:@"posts"];
        
        for (NSDictionary *node in nodes){
            
            [prizeArray removeAllObjects];
            
            [prizeArray addObject:[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"col1"]];
            [prizeArray addObject:[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"col2"]];
            [prizeArray addObject:[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"col3"]];
            [prizeArray addObject:[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"col4"]];
            [prizeArray addObject:[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"col5"]];
            [prizeArray addObject:[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"col6"]];
            [prizeArray addObject:[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"col7"]];
            [prizeArray addObject:[(NSDictionary *)[node objectForKey:@"post"] objectForKey:@"col8"]];
            
            NSString *str = [prizeArray objectAtIndex:0];
            NSCharacterSet *decimalSet = [NSCharacterSet decimalDigitCharacterSet];
            BOOL valid = [[str stringByTrimmingCharactersInSet: decimalSet] isEqualToString:@""];
            
            if (valid) {
                if ([str isEqualToString:@"0"]) {
                    img1.image=[UIImage imageNamed:@"sorry_icon"];
                    lbl1.text=@"SORRY";
                }
                else{
                    img1.image=[UIImage imageNamed:@"pointStar_icon"];
                    lbl1.text=@"POINTS";
                }
            }
            else{
                img1.image=[UIImage imageNamed:@"voucher_icon"];
                lbl1.text=@"VOUCHER";
            }
            
            //2nd
            
            str = [prizeArray objectAtIndex:1];
            decimalSet = [NSCharacterSet decimalDigitCharacterSet];
            valid = [[str stringByTrimmingCharactersInSet: decimalSet] isEqualToString:@""];
            
            if (valid) {
                if ([str isEqualToString:@"0"]) {
                    img2.image=[UIImage imageNamed:@"sorry_icon"];
                    lbl2.text=@"SORRY";
                }
                else{
                    img2.image=[UIImage imageNamed:@"pointStar_icon"];
                    lbl2.text=@"POINTS";
                }
            }
            else{
                img2.image=[UIImage imageNamed:@"voucher_icon"];
                lbl2.text=@"VOUCHER";
            }
            
            //3rd
            
            str = [prizeArray objectAtIndex:2];
            decimalSet = [NSCharacterSet decimalDigitCharacterSet];
            valid = [[str stringByTrimmingCharactersInSet: decimalSet] isEqualToString:@""];
            
            if (valid) {
                if ([str isEqualToString:@"0"]) {
                    img3.image=[UIImage imageNamed:@"sorry_icon"];
                    lbl3.text=@"SORRY";
                }
                else{
                    img3.image=[UIImage imageNamed:@"pointStar_icon"];
                    lbl3.text=@"POINTS";
                }
            }
            else{
                img3.image=[UIImage imageNamed:@"voucher_icon"];
                lbl3.text=@"VOUCHER";
            }
            
            //4th
            
            str = [prizeArray objectAtIndex:3];
            decimalSet = [NSCharacterSet decimalDigitCharacterSet];
            valid = [[str stringByTrimmingCharactersInSet: decimalSet] isEqualToString:@""];
            
            if (valid) {
                if ([str isEqualToString:@"0"]) {
                    img4.image=[UIImage imageNamed:@"sorry_icon"];
                    lbl4.text=@"SORRY";
                }
                else{
                    img4.image=[UIImage imageNamed:@"pointStar_icon"];
                    lbl4.text=@"POINTS";
                }
            }
            else{
                img4.image=[UIImage imageNamed:@"voucher_icon"];
                lbl4.text=@"VOUCHER";
            }
            
            //2nd
            
            str = [prizeArray objectAtIndex:4];
            decimalSet = [NSCharacterSet decimalDigitCharacterSet];
            valid = [[str stringByTrimmingCharactersInSet: decimalSet] isEqualToString:@""];
            
            if (valid) {
                if ([str isEqualToString:@"0"]) {
                    img5.image=[UIImage imageNamed:@"sorry_icon"];
                    lbl5.text=@"SORRY";
                }
                else{
                    img5.image=[UIImage imageNamed:@"pointStar_icon"];
                    lbl5.text=@"POINTS";
                }
            }
            else{
                img5.image=[UIImage imageNamed:@"voucher_icon"];
                lbl5.text=@"VOUCHER";
            }
            
            //2nd
            
            str = [prizeArray objectAtIndex:5];
            decimalSet = [NSCharacterSet decimalDigitCharacterSet];
            valid = [[str stringByTrimmingCharactersInSet: decimalSet] isEqualToString:@""];
            
            if (valid) {
                if ([str isEqualToString:@"0"]) {
                    img6.image=[UIImage imageNamed:@"sorry_icon"];
                    lbl6.text=@"SORRY";
                }
                else{
                    img6.image=[UIImage imageNamed:@"pointStar_icon"];
                    lbl6.text=@"POINTS";
                }
            }
            else{
                img6.image=[UIImage imageNamed:@"voucher_icon"];
                lbl6.text=@"VOUCHER";
            }
            
            //2nd
            
            str = [prizeArray objectAtIndex:6];
            decimalSet = [NSCharacterSet decimalDigitCharacterSet];
            valid = [[str stringByTrimmingCharactersInSet: decimalSet] isEqualToString:@""];
            
            if (valid) {
                if ([str isEqualToString:@"0"]) {
                    img7.image=[UIImage imageNamed:@"sorry_icon"];
                    lbl7.text=@"SORRY";
                }
                else{
                    img7.image=[UIImage imageNamed:@"pointStar_icon"];
                    lbl7.text=@"POINTS";
                }
            }
            else{
                img7.image=[UIImage imageNamed:@"voucher_icon"];
                lbl7.text=@"VOUCHER";
            }
            
            //2nd
            
            str = [prizeArray objectAtIndex:7];
            decimalSet = [NSCharacterSet decimalDigitCharacterSet];
            valid = [[str stringByTrimmingCharactersInSet: decimalSet] isEqualToString:@""];
            
            if (valid) {
                if ([str isEqualToString:@"0"]) {
                    img8.image=[UIImage imageNamed:@"sorry_icon"];
                    lbl8.text=@"SORRY";
                }
                else{
                    img8.image=[UIImage imageNamed:@"pointStar_icon"];
                    lbl8.text=@"POINTS";
                }
            }
            else{
                img8.image=[UIImage imageNamed:@"voucher_icon"];
                lbl8.text=@"VOUCHER";
            }
            
        }
        
    }
    
    
}

-(void)validateSpinWheel:(NSString *)lastDate{
    DBConnectionClass *dbClass=[[DBConnectionClass alloc]init];
    
    
    NSLog(@"[dbClass dateFromString:lastDate] %@",[dbClass dateFromString:lastDate]);
    
    NSDate *lastFormatDate=[dbClass dateFromString:lastDate];
    NSDate *currentFormatDate=[tanningDelegate.dbClass dateFromString:tanningDelegate.currentServerTime];
    
    lastFormatDate=[lastFormatDate dateByAddingTimeInterval:60*60*24*7];
    
    if ([lastFormatDate compare:currentFormatDate] == NSOrderedDescending) {
        NSLog(@"date1 is later than date2");
        
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"We're Sorry" message:@"You have already used your daily spin. Please check back tomorrow for another chance to win with ZENCIG!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        wheelStatus=1;
    }
    else{
        
        [dimView removeFromSuperview];
        wheelStatus=0;
        //        [activityIndicator stopAnimating];
        //        [activityIndicator removeFromSuperview];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView.title isEqualToString:@"Sorry"]) {
        
        if (buttonIndex==0) {
            
        }
    }
}

//New Spin rool

#pragma mark - math functions

-(double)DistanceBetweenTwoPoints:(CGPoint)point1:(CGPoint) point2
{
	CGFloat dx = point2.x - point1.x;
	CGFloat dy = point2.y - point1.y;
	return sqrt(dx*dx + dy*dy );
}


-(double)angleBetweenThreePoints:(CGPoint)x :(CGPoint)y :(CGPoint)z
{
	double a,b,c;
	
	b = [self DistanceBetweenTwoPoints:x :y];
	a = [self DistanceBetweenTwoPoints:y :z];
	c = [self DistanceBetweenTwoPoints:z :x];
	
	
	double value = (a*a +b*b - c*c)/(2*a*b);
	
	
	return acos(value);
}

-(double)crossProduct:(CGPoint)p1 :(CGPoint)p2 :(CGPoint)p3
{
	CGFloat a1 = p1.x - p2.x;
	CGFloat b1 = p1.y - p2.y;
	
	CGFloat a2 = p3.x - p2.x;
	CGFloat b2 = p3.y - p2.y;
	
	CGFloat slope = a1*b2 - a2*b1;
	
	if (slope < 0)
	{
		return -1;
	}
	else if (slope > 0)
    {
		return 1;
	}
    else
    {
        return 0;
    }
    
}

-(void)spin:(double)delta
{
    NSLog(@"spin1");
	currentAngle = currentAngle + delta;
    
	CATransform3D transform = CATransform3DMakeRotation(currentAngle, 0, 0, 1);
	
	[mShipWheel.layer setTransform:transform];
}


#pragma mark - UITouch delegate methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    return;
    
    if (wheelStatus) {
        return;
    }
    if (!SpinWheelRotatingStatus) {
        return;
    }
	touchesMoved = FALSE;
	SpinWheelRotatingStatus=TRUE;
    playSoundStatus=TRUE;
    //when the wheel is manually stopped
	
    if ([mShipWheel.layer animationForKey:@"transform.rotation.z"])
    {
        CALayer *presentation = (CALayer*)[mShipWheel.layer presentationLayer];
        
        currentTransform = [presentation transform];
        
        double angle = [[presentation valueForKeyPath:@"transform.rotation.z"] doubleValue];
        
        currentAngle = angle;
        
        [mShipWheel.layer removeAnimationForKey:@"transform.rotation.z"];
        
        [mShipWheel.layer setTransform:currentTransform];
        
    }
    
    UITouch *touch = [[event allTouches] anyObject];
    
    lastPoint = [touch locationInView:self.view];
    
    NSLog(@"touches began currentangle%f",currentAngle);
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    return;
    
    if (wheelStatus) {
        return;
    }
    if (!SpinWheelRotatingStatus) {
        return;
    }
    touchesMoved = TRUE;
    //AudioServicesPlaySystemSound(0x450);
    UITouch *touch = [[event allTouches] anyObject];
    
    // get the touch location
    CGPoint currentPoint = [touch locationInView:self.view];
    
    double theta = [self angleBetweenThreePoints: currentPoint :CGPointMake(160,230):lastPoint];
    
    double sign = [self crossProduct:currentPoint:lastPoint: CGPointMake(160,230)];
    
    
    NSTimeInterval deltaTime = event.timestamp - lastTouchTimeStamp;
    
    angularSpeed = DEGREES_TO_RADIANS(theta)/deltaTime;
    
    turnDirection = sign;
    NSLog(@"sign valuve %f",sign);
    if (sign==-1) {
        touchesMoved=FALSE;
        moveSpinWheel=FALSE;
        return;
    }
    else{
        moveSpinWheel=TRUE;
    }
    
    [self spin:sign*theta];
    
    // update the last point
    
    lastPoint = currentPoint;
	
    lastTouchTimeStamp = event.timestamp;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //AudioServicesPlaySystemSound(0x450);
    
    return;
    
    if (wheelStatus) {
        return;
    }
    if (!moveSpinWheel) {
        return;
    }
    if (!SpinWheelRotatingStatus) {
        return;
    }
    
    UITouch *touch = [[event allTouches] anyObject];
    
    CGPoint currentPoint = [touch locationInView:self.view];
    
    
	if (touchesMoved)
	{
        double deltaAngle = [self angleBetweenThreePoints:currentPoint:CGPointMake(160,230) :lastPoint];
        
        [self spin:deltaAngle];
        
        turnDirection = [self crossProduct:currentPoint:lastPoint: CGPointMake(160,230) ];
        
        if (angularSpeed > 0.01)
        {
            [self runSpinAnimation];
            
        }
        [self playTickSound];
        SpinWheelRotatingStatus=FALSE;
	}
    
    NSLog(@"turnDirection %d",turnDirection);
    
}


#pragma mark - Spin Animation

- (void)runSpinAnimation
{
	CAKeyframeAnimation* animation;
	animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
	NSLog(@"spin4");
    animation.duration = 5; //adjust accordingly
    
	animation.repeatCount = 1;
	animation.removedOnCompletion = NO;
	animation.fillMode = kCAFillModeBoth;
	
	animation.calculationMode = kCAAnimationLinear;
    
    NSMutableArray *keyFrameValues = [[NSMutableArray alloc] init];
    
    // Start the animation with the current angle of the wheel
    
    double angleAtTheInstant = currentAngle;
    
    double angleTravelled = DEGREES_TO_RADIANS(720)*angularSpeed; // Angle travelled in 1st second
    
    for (int i = 0; i < 10; i ++)
    {
        NSLog(@"spin2");
        
        [keyFrameValues addObject: [NSNumber numberWithDouble:angleAtTheInstant]];
        
        //updating the angle for the next frame
        
        angleAtTheInstant = angleAtTheInstant +angleTravelled*turnDirection;
        
        angleTravelled = angleTravelled*0.8;
        
    }
    
    animation.values = keyFrameValues;
    
    //  [keyFrameValues release];
    
	animation.keyTimes = [NSArray arrayWithObjects:
                          [NSNumber numberWithFloat:0],
                          [NSNumber numberWithFloat:0.1],
                          [NSNumber numberWithFloat:0.2],
                          [NSNumber numberWithFloat:0.3],
                          [NSNumber numberWithFloat:0.4],
                          [NSNumber numberWithFloat:0.5],
                          [NSNumber numberWithFloat:0.6],
                          [NSNumber numberWithFloat:0.7],
                          [NSNumber numberWithFloat:0.8],
                          [NSNumber numberWithFloat:1.0], nil];
    
    
	NSLog(@"spin3 currentAngle %f   angularSpeed %f",currentAngle,angularSpeed);
	animation.delegate = self;
	
    [mShipWheel.layer addAnimation:animation forKey:@"transform.rotation.z"];
	
}

-(IBAction)runSpinOnClick:(id)sender{
    angularSpeed=arc4random() % 11 * 0.1;;
    CALayer *presentation = (CALayer*)[mShipWheel.layer presentationLayer];
    
    double angle = [[presentation valueForKeyPath:@"transform.rotation.z"] doubleValue];
    
    currentAngle =  angle;
    
    turnDirection=1;
    
    CAKeyframeAnimation* animation;
	animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
	NSLog(@"spin4");
    animation.duration = 5; //adjust accordingly
    
	animation.repeatCount = 1;
	animation.removedOnCompletion = NO;
	animation.fillMode = kCAFillModeBoth;
	
	animation.calculationMode = kCAAnimationLinear;
    
    NSMutableArray *keyFrameValues = [[NSMutableArray alloc] init];
    
    // Start the animation with the current angle of the wheel
    
    double angleAtTheInstant = currentAngle;
    
    double angleTravelled = DEGREES_TO_RADIANS(720)*angularSpeed; // Angle travelled in 1st second
    
    for (int i = 0; i < 10; i ++)
    {
        NSLog(@"spin2");
        
        [keyFrameValues addObject: [NSNumber numberWithDouble:angleAtTheInstant]];
        
        //updating the angle for the next frame
        
        angleAtTheInstant = angleAtTheInstant +angleTravelled*turnDirection;
        
        angleTravelled = angleTravelled*0.8;
        
    }
    
    animation.values = keyFrameValues;
    
    //  [keyFrameValues release];
    
	animation.keyTimes = [NSArray arrayWithObjects:
                          [NSNumber numberWithFloat:0],
                          [NSNumber numberWithFloat:0.1],
                          [NSNumber numberWithFloat:0.2],
                          [NSNumber numberWithFloat:0.3],
                          [NSNumber numberWithFloat:0.4],
                          [NSNumber numberWithFloat:0.5],
                          [NSNumber numberWithFloat:0.6],
                          [NSNumber numberWithFloat:0.7],
                          [NSNumber numberWithFloat:0.8],
                          [NSNumber numberWithFloat:1.0], nil];
    
    
	NSLog(@"spin3");
	animation.delegate = self;
	
    [mShipWheel.layer addAnimation:animation forKey:@"transform.rotation.z"];
}

#pragma mark CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
    
    if (theAnimation == [mShipWheel.layer animationForKey:@"transform.rotation.z"])
    {
        playSoundStatus=FALSE;
        
        CALayer *presentation = (CALayer*)[mShipWheel.layer presentationLayer];
        
        double angle = [[presentation valueForKeyPath:@"transform.rotation.z"] doubleValue];
        
        currentAngle =  angle;
        
        NSLog(@"Dergree %f", RADIANS_TO_DEGREES(currentAngle));
        
        //[self getPointValueIndex: RADIANS_TO_DEGREES(currentAngle)];
        
        CATransform3D transform = CATransform3DMakeRotation(currentAngle, 0, 0, 1);
        
        [mShipWheel.layer setTransform:transform];
        
        [mShipWheel.layer removeAnimationForKey:@"transform.rotation.z"];
        SpinWheelRotatingStatus=TRUE;
        
        CGFloat radians = atan2f(self.mShipWheel.transform.b, self.mShipWheel.transform.a);
        CGFloat degrees = radians * (180 / M_PI);
        
        [self getPointValueIndexNew:degrees];
    }
    
}

-(NSInteger)getPointValueIndex:(float)degreeValue{
    degreeValue=-degreeValue;
    
    if ((degreeValue>-15 && degreeValue<0) || (degreeValue>=0 && degreeValue<15)) {
        NSLog(@"Prize 2 win");
        
        [self updateSpinDetails:1];
    }
    else  if ((degreeValue>45 && degreeValue<75) ) {
        NSLog(@"Prize 4 win");
        [self updateSpinDetails:3];
    }
    else  if ((degreeValue>105 && degreeValue<135) ) {
        NSLog(@"Prize 6 win");
        [self updateSpinDetails:5];
    }
    else  if ((degreeValue>165 && degreeValue<180) || (degreeValue>-179 && degreeValue<-165)) {
        NSLog(@"Prize 1 win");
        [self updateSpinDetails:0];
    }
    else  if ((degreeValue>-145 && degreeValue<-105) ) {
        NSLog(@"Prize 3 win");
        [self updateSpinDetails:2];
    }
    else  if ((degreeValue>-75 && degreeValue<-45) ) {
        NSLog(@"Prize 5 win");
        [self updateSpinDetails:4];
    }
    else{
        
        NSLog(@"Try again");
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry !"
                                                        message:[NSString stringWithFormat:@"Please try again."]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
    return 1;
}

-(NSInteger)getPointValueIndexNew:(float)degreeValue{
    //degreeValue=-degreeValue;
    
    if ((degreeValue>-22.5 && degreeValue<0) || (degreeValue>=0 && degreeValue<22.5)) {
        NSLog(@"Prize 3 win");
        
        [self updateSpinDetails:2];
    }
    else  if ((degreeValue>22.5 && degreeValue<67.5) ) {
        NSLog(@"Prize 2 win");
        [self updateSpinDetails:1];
    }
    else  if ((degreeValue>67.5 && degreeValue<112.5) ) {
        NSLog(@"Prize 1 win");
        [self updateSpinDetails:0];
    }
    else  if ((degreeValue>112.5 && degreeValue<157.5) ) {
        NSLog(@"Prize 8 win");
        [self updateSpinDetails:7];
    }
    else  if ((degreeValue>157.5 && degreeValue<179) || (degreeValue>=-179 && degreeValue<-157.5)) {
        NSLog(@"Prize 7 win");
        [self updateSpinDetails:6];
    }
    else  if ((degreeValue>-157.5 && degreeValue<-112.5) ) {
        NSLog(@"Prize 6 win");
        [self updateSpinDetails:5];
    }
    else  if ((degreeValue>-112.5 && degreeValue<-67.5) ) {
        NSLog(@"Prize 5 win");
        [self updateSpinDetails:4];
    }
    else  if ((degreeValue>-67.5 && degreeValue<-22.5) ) {
        NSLog(@"Prize 4 win");
        [self updateSpinDetails:3];
    }
    else{
        
        NSLog(@"Try again");
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry !"
                                                        message:[NSString stringWithFormat:@"Please try again."]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
    return 1;
}

-(void)updateSpinDetails:(int)index{
    
    NSString *str = [prizeArray objectAtIndex:index];
    NSCharacterSet *decimalSet = [NSCharacterSet decimalDigitCharacterSet];
    BOOL valid = [[str stringByTrimmingCharactersInSet: decimalSet] isEqualToString:@""];
    
    DBConnectionClass *dbClass=[[DBConnectionClass alloc]init];
    
    if(valid)
    {
        float x = arc4random_uniform(10000000);
        NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@updateSpinningWheel.php?userid=%@&type=SP&point=%@&postid=%f",tanningDelegate.hostString,[dbClass getUserName],[prizeArray objectAtIndex:index],x] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        
        NSLog(@"URL %@",[[NSString stringWithFormat:@"%@updateSpinningWheel.php?userid=%@&type=SP&point=%@&postid=%f",tanningDelegate.hostString,[dbClass getUserName],[prizeArray objectAtIndex:index],x] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]);
        
        spinDetailConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
        
        //************************************************
        
        theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@insertSpinningWheel.php?userid=%@&point=%@",tanningDelegate.hostString,[dbClass getUserName],[prizeArray objectAtIndex:index]] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        spinUploadDetailConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
        
        
        //**********************************************
        
        if (spinDetailConnection) {
            // Inform the user that the download failed.
            //shareDataArray=[[NSMutableData alloc ]init];
            
            //  [recievedData writeToFile:path atomically:YES];
            NSLog(@"JSON download youtube");
            
            if([[prizeArray objectAtIndex:index] integerValue]>0)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ZENCIG"
                                                                message:[NSString stringWithFormat:@"Congratulations! You just won %@ points",[prizeArray objectAtIndex:index]]
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles: nil];
                [alert show];
            }
            else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ZENCIG"
                                                                message:[NSString stringWithFormat:@"Sorry :( Bad luck try next time."]
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles: nil];
                [alert show];
            }
            
            float x = arc4random_uniform(10000000);
            
            ActivityLogDBClass *activityClass=[[ActivityLogDBClass alloc]init];
            activityClass.activityId=[NSString stringWithFormat:@"%f",x];
            activityClass.activitytitle=@"Spin Wheel Points";
            activityClass.username=[tanningDelegate.dbClass getUserName];
            activityClass.socialtype=@"SP";
            activityClass.activitytype=@"S";
            activityClass.activitydate=[NSString stringWithFormat:@"%@",[tanningDelegate.dbClass FormattedDateFromDate:[tanningDelegate.dbClass dateFromString:tanningDelegate.currentServerTime]]];
            activityClass.expiredate=[NSString stringWithFormat:@"%@",[tanningDelegate.dbClass FormattedDateFromDate:[tanningDelegate.dbClass dateFromString:tanningDelegate.currentServerTime]]];
            activityClass.amount=@"0";
            activityClass.point=[prizeArray objectAtIndex:index];
            activityClass.status=@"A";
            [tanningDelegate.dbClass insertActivityData:activityClass];
            
            
            //Add activity to server
            
            NSURLRequest *activityRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@ActivityLog.php?activityId=%@&userid=%@&firstname=%@&lastname=%@&socialtype=SP&activitytype=S&activitytitle=Spin Wheel&activitydate=%@&expiredate=%@&amount=0&redeempoint=%@&status=A",tanningDelegate.hostString,[NSString stringWithFormat:@"%f",x],[tanningDelegate.dbClass getUserName],[tanningDelegate.dbClass getFirstName],[tanningDelegate.dbClass getLastName],[tanningDelegate.dbClass FormattedDateFromDate:[tanningDelegate.dbClass dateFromString:tanningDelegate.currentServerTime]],[tanningDelegate.dbClass FormattedDateFromDate:[[tanningDelegate.dbClass dateFromString:tanningDelegate.currentServerTime] dateByAddingTimeInterval:24*60*60*30]],[prizeArray objectAtIndex:index]] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
            NSURLConnection *activityDetailConnection = [[NSURLConnection alloc] initWithRequest:activityRequest delegate:self];
            
            NSLog(@"%@",[[NSString stringWithFormat:@"%@ActivityLog.php?activityId=%@&userid=%@&firstname=%@&lastname=%@&socialtype=SP&activitytype=S&activitytitle=Spin Wheel&activitydate=%@&expiredate=%@&amount=0&redeempoint=%@&status=A",tanningDelegate.hostString,[NSString stringWithFormat:@"%f",x],[tanningDelegate.dbClass getUserName],[tanningDelegate.dbClass getFirstName],[tanningDelegate.dbClass getLastName],[NSDate date],[[NSDate date] dateByAddingTimeInterval:24*60*60*7],[prizeArray objectAtIndex:index]] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]);
            
            if (activityDetailConnection) {
                
            }
            else{
                
            }
            
            
            wheelStatus=1;
        }
        else {
            NSLog(@"JSON download fail");
        }
        
        if (lastSpinDetailConnection) {
            // Inform the user that the download failed.
            shareDataArray=[[NSMutableData alloc ]init];
            
            //  [recievedData writeToFile:path atomically:YES];
            NSLog(@"JSON download youtube");
        }
        else {
            NSLog(@"JSON download fail");
        }
        
        if(![[prizeArray objectAtIndex:index] isEqualToString:@"0"])
        {
            [self postWall:@"ZENCIG" :[NSString stringWithFormat:@"I just #won %@ points @ZENCIG You can spin too. Download the #freeapp for your chance to win! with #ZENCIG",[prizeArray objectAtIndex:index]] :@"SpinWheel" :@"https://itunes.apple.com/us/app/tanningloft/id715090688?mt=8"];
        }
    }
    else{
        //Free tan logic
        
        PackageDetailDBClass *pkgDBClass=[[PackageDetailDBClass alloc]init];
        pkgDBClass=[[tanningDelegate.dbClass fetchPackageDetailForID:[[str componentsSeparatedByString:@"V"] objectAtIndex:0]] objectAtIndex:0];
        
        NSURLRequest *pkgRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@MonthlyPackageService.php?userid=%@&firstname=%@&lastname=%@&pkgtitle=%@&pkgdesc=%@&amount=%@&point=%@&pkgType=%@&pkgId=%@",tanningDelegate.hostString,[tanningDelegate.dbClass getUserName],[tanningDelegate.dbClass getFirstName],[tanningDelegate.dbClass getLastName],pkgDBClass.pkgTitle,pkgDBClass.pkgDescription,pkgDBClass.pkgAmount,pkgDBClass.pkgPoints,pkgDBClass.pkgType,pkgDBClass.pkgID] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        NSURLConnection *pkgPurchaseDetailConnection = [[NSURLConnection alloc] initWithRequest:pkgRequest delegate:self];
        
        NSLog(@"MonthlyPackageService %@",pkgRequest);
        //End of log server
        if (pkgPurchaseDetailConnection) {
            
            NSLog(@"Package detials logged successfully");
        }
        
        //Insert Purchase details
        
        PurchaseDBClass *purchaseClass=[[PurchaseDBClass alloc]init];
        purchaseClass.pkgTitle=pkgDBClass.pkgTitle;
        purchaseClass.pkgId=pkgDBClass.pkgID;
        purchaseClass.pkgDescription=pkgDBClass.pkgDescription;
        purchaseClass.type=@"V";
        purchaseClass.pkgAmount=pkgDBClass.pkgAmount;
        
        DBConnectionClass *dbCon=[[DBConnectionClass alloc]init];
        [dbCon insertPurchaseDetails:purchaseClass];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ZENCIG"
                                                        message:[NSString stringWithFormat:@"Congratulations! You just won a Free Voucher. Please check your account."]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
        float x = arc4random_uniform(10000000);
        ActivityLogDBClass *activityClass=[[ActivityLogDBClass alloc]init];
        activityClass.activityId=[NSString stringWithFormat:@"%f",x];
        activityClass.activitytitle=@"Free Voucher";
        activityClass.username=[tanningDelegate.dbClass getUserName];
        activityClass.socialtype=@"FREE";
        activityClass.activitytype=@"S";
        activityClass.activitydate=[NSString stringWithFormat:@"%@",[tanningDelegate.dbClass FormattedDateFromDate:[tanningDelegate.dbClass dateFromString:tanningDelegate.currentServerTime]]];
        activityClass.expiredate=[NSString stringWithFormat:@"%@",[tanningDelegate.dbClass FormattedDateFromDate:[tanningDelegate.dbClass dateFromString:tanningDelegate.currentServerTime]]];
        activityClass.amount=[[str componentsSeparatedByString:@"V"] objectAtIndex:0];
        activityClass.point=[[str componentsSeparatedByString:@"V"] objectAtIndex:0];
        activityClass.status=@"A";
        [tanningDelegate.dbClass insertActivityData:activityClass];
        
        wheelStatus=1;
        
        //Add activity to server
        
        NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@updateSpinningWheel.php?userid=%@&type=SP&point=%@&postid=%f",tanningDelegate.hostString,[dbClass getUserName],[[str componentsSeparatedByString:@"V"] objectAtIndex:0],x] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        
        NSLog(@"URL %@",[[NSString stringWithFormat:@"%@updateSpinningWheel.php?userid=%@&type=SP&point=%@&postid=%f",tanningDelegate.hostString,[dbClass getUserName],[prizeArray objectAtIndex:index],x] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]);
        
        spinDetailConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
        
        //************************************************
        
        //************************************************
        
        theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@insertSpinningWheel.php?userid=%@&point=%@",tanningDelegate.hostString,[dbClass getUserName],[prizeArray objectAtIndex:index]] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        spinUploadDetailConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
        
        
        //**********************************************
        
        NSURLRequest *activityRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@ActivityLog.php?activityId=%@&userid=%@&firstname=%@&lastname=%@&socialtype=SP&activitytype=R&activitytitle=Free Voucher&activitydate=%@&expiredate=%@&amount=%@&redeempoint=%@&status=A",tanningDelegate.hostString,[NSString stringWithFormat:@"%f",x],[tanningDelegate.dbClass getUserName],[tanningDelegate.dbClass getFirstName],[tanningDelegate.dbClass getLastName],[tanningDelegate.dbClass FormattedDateFromDate:[tanningDelegate.dbClass dateFromString:tanningDelegate.currentServerTime]],[tanningDelegate.dbClass FormattedDateFromDate:[[tanningDelegate.dbClass dateFromString:tanningDelegate.currentServerTime] dateByAddingTimeInterval:24*60*60*30]],[[str componentsSeparatedByString:@"V"] objectAtIndex:0],[[str componentsSeparatedByString:@"V"] objectAtIndex:0]] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        NSURLConnection *activityDetailConnection = [[NSURLConnection alloc] initWithRequest:activityRequest delegate:self];
        
        NSLog(@"%@",[[NSString stringWithFormat:@"%@ActivityLog.php?activityId=%@&userid=%@&firstname=%@&lastname=%@&socialtype=SP&activitytype=S&activitytitle=Spin Wheel&activitydate=%@&expiredate=%@&amount=0&redeempoint=%@&status=A",tanningDelegate.hostString,[NSString stringWithFormat:@"%f",x],[tanningDelegate.dbClass getUserName],[tanningDelegate.dbClass getFirstName],[tanningDelegate.dbClass getLastName],[NSDate date],[[NSDate date] dateByAddingTimeInterval:24*60*60*7],[prizeArray objectAtIndex:index]] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]);
        
        if (activityDetailConnection) {
            
        }
        else{
            
        }
        
        wheelStatus=1;
        [self postWall:@"ZENCIG" :[NSString stringWithFormat:@"I just #won %@ Free Voucher with ZENCIG. SHARE, WIN & REDEEM your points today! Play daily and WIN BIG! @ZENCIG #freeapp #ZENCIG ",[[str componentsSeparatedByString:@"V"] objectAtIndex:0]] :@"SpinWheel" :@"https://zencig.com"];
    }
}

-(void)playTickSound{
    //    if (!playSoundStatus) {
    //        return;
    //    }
    //    AudioServicesPlaySystemSound(0x450);
    //    [self playTickSound];
}

- (void) postWall:(NSString *)caption : (NSString *)description : (NSString *) name : (NSString *)link{
    
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    appDelegate.viewStatus=@"Home";
    
    if (FBSession.activeSession.state == FBSessionStateOpen) {
        
        NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
        [params setObject:description forKey:@"message"];
        [params setObject:link forKey:@"link"];
        [params setObject:description forKey:@"name"];
        [params setObject:description forKey:@"description"];
        [params setObject:UIImagePNGRepresentation([UIImage imageNamed:@"icon"]) forKey:@"picture"];
        
        
        [FBRequestConnection startWithGraphPath:@"me/photos"
                                     parameters:params
                                     HTTPMethod:@"POST"
                              completionHandler:^(FBRequestConnection *connection,
                                                  id result,
                                                  NSError *error)
         {
             if (error)
             {
                 //showing an alert for failure
                 
             }
             else
             {
                 //showing an alert for success
                 NSLog(@"facebook Posted successfully %@",result);
                 
             }
         }];
        
        
    }
    else {
        // No, display the login page.
        // [self showLoginView];
        
        AppDelegate *delegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
        [delegate openSession];
        
    }
}
@end
