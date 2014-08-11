//
//  SignInWithEmailViewController.m
//  GregMayHair
//
//  Created by Lavi Gupta on 07/09/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "SignInWithEmailViewController.h"
#import "SignUpViewController.h"
#import "ForgotPasswordViewController.h"
#import "UserDetailDBClass.h"
#import "AppDelegate.h"
#import "Constant.h"

@interface SignInWithEmailViewController (){
    NSString *requestState;
    UITapGestureRecognizer *tapOutside;
    UITapGestureRecognizer *signUpOutside;
}

@end

@implementation SignInWithEmailViewController
@synthesize userNametxt,passwordTxt,forgotpwd,signup;

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
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;   // iOS 7 specific
    self.navigationController.navigationBar.translucent = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTapped)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [signup addGestureRecognizer:tapGestureRecognizer];
    signup.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(forgotPwdTapped)];
    tapGestureRecognizer1.numberOfTapsRequired = 1;
    [forgotpwd addGestureRecognizer:tapGestureRecognizer1];
    forgotpwd.userInteractionEnabled = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)labelTapped{
    SignUpViewController *signUpVC=[[SignUpViewController alloc]init];
    [self presentViewController:signUpVC animated:YES completion:Nil];
}
-(void)forgotPwdTapped{
    ForgotPasswordViewController *signUpVC=[[ForgotPasswordViewController alloc]init];
    [self presentViewController:signUpVC animated:YES completion:Nil];
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


//This hides keyboard BUT IS ALSO CALLED WHEN CLEAR BUTTON IS TAPPED
- (void)textFieldTouchOutSide:(id)sender
{
    [self.userNametxt resignFirstResponder];
    [self.passwordTxt resignFirstResponder];
    
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
                
                [self dismissModalViewControllerAnimated:YES];
                
            }
        }
        else{
            
            if ([requestState isEqualToString:@"LOGIN"]) {
                userNametxt.backgroundColor=[UIColor redColor];
                passwordTxt.backgroundColor=[UIColor redColor];
            }
            else{
                //emailTxt.backgroundColor=[UIColor redColor];
            }
            
        }
        
    }
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField { //Keyboard becomes visible
    
    if (tapOutside == nil)
        tapOutside = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textFieldTouchOutSide:)];
    
    [self.view addGestureRecognizer:tapOutside];
}

-(void)textFieldDidEndEditing:(UITextField *)textField { //keyboard will hide
    
    
}
-(IBAction)cancelButtonClicked:(id)sender{
    
    [self dismissModalViewControllerAnimated:YES];
}

@end
