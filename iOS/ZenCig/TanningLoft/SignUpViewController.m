//
//  SignUpViewController.m
//  TanningLoft
//
//  Created by Lavi Gupta on 03/08/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "SignUpViewController.h"
#import "SBJson.h"
#import "UserDetailDBClass.h"
#import "Constant.h"
#import "AppDelegate.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController{
    
    NSString *requestState;
    UITapGestureRecognizer *tapOutside;
}

@synthesize scrollView;
@synthesize userNametxt;
@synthesize passwordTxt;
@synthesize firstNameTxt;
@synthesize lastNameTxt;
@synthesize emailTxt;
@synthesize signUpPwdTxt;
@synthesize signUpConfirmPwdTxt;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    scrollView.contentSize=CGSizeMake(320, 548);
    
    if ([tanningDelegate.dbClass fetchUserDetail].count) {
        UserDetailDBClass *userObj=[[tanningDelegate.dbClass fetchUserDetail] objectAtIndex:0];
        if(userObj.userId.length)
            [tanningDelegate switchRootView];
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

-(IBAction)loginBtnClicked:(id)sender{
    requestState=@"LOGIN";
    BOOL txtStatus=TRUE;
    if ([self validEmail:userNametxt.text] && userNametxt.text.length) {
        
        userNametxt.backgroundColor=[UIColor whiteColor];
    }
    else{
        txtStatus=FALSE;
        userNametxt.text=@"";
        userNametxt.backgroundColor=[UIColor redColor];
    }
    
    if ([passwordTxt.text isMatchedByRegex:@"^[a-zA-Z0-9]*$"] && passwordTxt.text.length>=6) {
        
        passwordTxt.backgroundColor=[UIColor whiteColor];
    }
    else{
        txtStatus=FALSE;
        passwordTxt.text=@"";
        passwordTxt.backgroundColor=[UIColor redColor];
    }
    
    if (txtStatus) {
        //TODO Call Sign up webservice
        
        NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@SignUpService.php?userid=%@&password=%@&format=json&num=10&state=LOGIN",tanningDelegate.hostString,[userNametxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]],[passwordTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        signUpConnection= [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
        
        NSLog(@"%@",theRequest);
        if (signUpConnection) {
            // Inform the user that the download failed.
            signUpDataArray=[[NSMutableData alloc ]init];
            
            //  [recievedData writeToFile:path atomically:YES];
            NSLog(@"JSON download youtube");
        }
        else {
            NSLog(@"JSON download fail");
        }
    }
}

-(IBAction)submitButtonClicked:(id)sender{
    requestState=@"SIGNUP";
    BOOL txtStatus=TRUE;
    if ( firstNameTxt.text.length) {
        
        firstNameTxt.backgroundColor=[UIColor whiteColor];
        
    }
    else{
        txtStatus=FALSE;
        firstNameTxt.text=@"";
        firstNameTxt.backgroundColor=[UIColor redColor];
    }
    
    if (  lastNameTxt.text.length) {
        
        lastNameTxt.backgroundColor=[UIColor whiteColor];
    }
    else{
        txtStatus=FALSE;
        lastNameTxt.text=@"";
        lastNameTxt.backgroundColor=[UIColor redColor];
    }
    
    if ( [self validEmail:emailTxt.text] ) {
        
        emailTxt.backgroundColor=[UIColor whiteColor];
    }
    else{
        txtStatus=FALSE;
        emailTxt.text=@"";
        emailTxt.backgroundColor=[UIColor redColor];
    }
    
    if ( signUpPwdTxt.text.length>=6) {
        
        signUpPwdTxt.backgroundColor=[UIColor whiteColor];
    }
    else{
        txtStatus=FALSE;
        signUpPwdTxt.text=@"";
        signUpPwdTxt.backgroundColor=[UIColor redColor];
    }
    
    if ( [signUpConfirmPwdTxt.text isEqualToString:signUpPwdTxt.text]) {
        
        signUpConfirmPwdTxt.backgroundColor=[UIColor whiteColor];
    }
    else{
        txtStatus=FALSE;
        signUpConfirmPwdTxt.text=@"";
        signUpConfirmPwdTxt.backgroundColor=[UIColor redColor];
    }
    
    if (txtStatus) {
        //TODO Call Sign up webservice
        
        NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@SignUpService.php?userid=%@&password=%@&firstname=%@&lastname=%@&email=%@&format=json&num=10&state=SIGNUP",tanningDelegate.hostString,[emailTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]],[signUpPwdTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]],[firstNameTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]],[lastNameTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]],[emailTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        signUpConnection= [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
        
        NSLog(@"%@",theRequest);
        if (signUpConnection) {
            // Inform the user that the download failed.
            signUpDataArray=[[NSMutableData alloc ]init];
            
            //  [recievedData writeToFile:path atomically:YES];
            NSLog(@"JSON download youtube");
        }
        else {
            NSLog(@"JSON download fail");
        }
    }
}

-(BOOL) validEmail:(NSString*) emailString {
    NSString *regExPattern = @"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$";
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger regExMatches = [regEx numberOfMatchesInString:emailString options:0 range:NSMakeRange(0, [emailString length])];
    NSLog(@"%i", regExMatches);
    if (regExMatches == 0) {
        return NO;
    } else
        return YES;
}

-(IBAction)cancelButtonClicked:(id)sender{
    
    [self dismissModalViewControllerAnimated:YES];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField { //Keyboard becomes visible
    
    if(textField!=firstNameTxt && textField!=lastNameTxt && textField!=emailTxt)
    {
    UIScrollView* v = (UIScrollView*) self.scrollView ;
    
    CGRect rc = [textField bounds];
    rc = [textField convertRect:rc toView:v];
    CGPoint pt = rc.origin ;
    pt.x = 0 ;
    pt.y -= 250 ;
    [v setContentOffset:pt animated:YES];
        scrollView.contentSize=CGSizeMake(320, 800);
    }
    if (tapOutside == nil)
        tapOutside = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textFieldTouchOutSide:)];
    
    [self.scrollView addGestureRecognizer:tapOutside];
}

-(void)textFieldDidEndEditing:(UITextField *)textField { //keyboard will hide
    
    scrollView.contentSize=CGSizeMake(320, 548);
    [scrollView setContentOffset:CGPointMake(0, 0)];
}

//This hides keyboard BUT IS ALSO CALLED WHEN CLEAR BUTTON IS TAPPED
- (void)textFieldTouchOutSide:(id)sender
{
    [self.userNametxt resignFirstResponder];
    [self.passwordTxt resignFirstResponder];
    [self.firstNameTxt resignFirstResponder];
    [self.lastNameTxt resignFirstResponder];
    [self.emailTxt resignFirstResponder];
    [self.signUpPwdTxt resignFirstResponder];
    [self.signUpConfirmPwdTxt resignFirstResponder];
}

//NEVER GETS CALLED
- (BOOL) textFieldShouldClear:(UITextField *)textField {
    return YES;
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if(signUpConnection==connection){
        
        [signUpDataArray setLength:0];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if(signUpConnection==connection){
        
        [signUpDataArray appendData:data];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (connection==signUpConnection) {
        
        
        
        NSString *responseString = [[NSString alloc] initWithData:signUpDataArray encoding:NSUTF8StringEncoding];
        // [responseData release];
        
        NSLog(@"responseString %@",responseString);
        
        NSError *error;
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSMutableDictionary *jsonDictionary = [parser objectWithString:responseString error:nil];
        
        NSArray *nodes = (NSArray*)[jsonDictionary objectForKey:@"posts"];
        if(![jsonDictionary objectForKey:@"responsestatus"] ==2 || nodes.count)
        {
            for (NSDictionary *node in nodes){
                UserDetailDBClass *userDBClass=[[UserDetailDBClass alloc]init];
                
                userDBClass.userId=[[node objectForKey:@"post"] objectForKey:@"userid"];
                userDBClass.firstname=[[node objectForKey:@"post"] objectForKey:@"firstname"];
                userDBClass.lastname=[[node objectForKey:@"post"] objectForKey:@"lastname"];
                userDBClass.memberSince=[[node objectForKey:@"post"] objectForKey:@"membersince"];
                userDBClass.tokenNo=[[node objectForKey:@"post"] objectForKey:@"tokenid"];
                userDBClass.email=[[node objectForKey:@"post"] objectForKey:@"email"];
                userDBClass.isActive=[[node objectForKey:@"post"] objectForKey:@"isActive"];
                
                [tanningDelegate.dbClass insertUserDetail:userDBClass];
                [tanningDelegate switchRootView];
                
            }
        }
        else{
            
            if ([requestState isEqualToString:@"LOGIN"]) {
                userNametxt.backgroundColor=[UIColor redColor];
                passwordTxt.backgroundColor=[UIColor redColor];
            }
            else{
                emailTxt.backgroundColor=[UIColor redColor];
            }
           
        }
        
    }
    
}

@end
