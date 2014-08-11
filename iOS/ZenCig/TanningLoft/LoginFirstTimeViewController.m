//
//  LoginFirstTimeViewController.m
//  MexicanAmigos
//
//  Created by Lavi Gupta on 14/08/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "LoginFirstTimeViewController.h"
#import "AppDelegate.h"
#import "Constant.h"
#import "SignUpViewController.h"
#import "ForgotPasswordViewController.h"
#import "SignInWithEmailViewController.h"
#import "TermsAndConditionViewController.h"

@interface LoginFirstTimeViewController (){
    
    NSString *requestState;
    UITapGestureRecognizer *tapOutside;
    UITapGestureRecognizer *signUpOutside;
}

@end

@implementation LoginFirstTimeViewController
@synthesize userNametxt,passwordTxt,scrollView;
@synthesize signup,forgotpwd;
@synthesize termsandConditionBtn,termsAndConditionLbl;

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
    
   
}

-(void)viewWillAppear:(BOOL)animated{
   
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTapped)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [termsAndConditionLbl addGestureRecognizer:tapGestureRecognizer];
    termsAndConditionLbl.userInteractionEnabled = YES;
    
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

-(IBAction)connectFacebookBtn:(id)sender{
    
    NSLog(@"Bundle ID: %@",[[NSBundle mainBundle] bundleIdentifier]);
    
    if([tanningDelegate.dbClass connected])
    {
    
    if(termsandConditionBtn.tag==1)
    {
        AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
        appDelegate.viewStatus=@"Connect";
    
        if (FBSession.activeSession.state == FBSessionStateOpen) {
        
            [appDelegate switchRootView];
        
        } else {
        // No, display the login page.
        // [self showLoginView];
        
            AppDelegate *delegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
            [delegate openSession];
        }
    }
    else{
        [termsAndConditionLbl setTextColor:[UIColor redColor]];
    }
    }
    else{
        
        [tanningDelegate.dbClass showNetworkALert];
    }

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

-(void)textFieldDidBeginEditing:(UITextField *)textField { //Keyboard becomes visible
    

    if(textField!=userNametxt && textField!=passwordTxt)
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
                //emailTxt.backgroundColor=[UIColor redColor];
            }
            
        }
        
    }
    
}

-(void)labelTapped{
    
    TermsAndConditionViewController *termsVC=[[TermsAndConditionViewController alloc]init];
    
    [self presentViewController:termsVC animated:YES completion:nil];
    UIButton *tempBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    tempBtn.frame=CGRectMake(10, 25, 30, 30);
    
    tempBtn.backgroundColor=[UIColor clearColor];
    
    [tempBtn setTitle:@"" forState:UIControlStateNormal];
    
    [tempBtn setBackgroundImage:[UIImage imageNamed:@"button_grey_close"] forState:UIControlStateNormal];
    
    [tempBtn addTarget:self action:@selector(dismissAlertModal:) forControlEvents:UIControlEventTouchUpInside];
    
    [termsVC.view addSubview:tempBtn];
}
-(IBAction)dismissAlertModal:(id)sender{
    
    [self dismissViewControllerAnimated:YES completion:Nil];
}

-(void)forgotPwdTapped{
    ForgotPasswordViewController *signUpVC=[[ForgotPasswordViewController alloc]init];
    [self presentViewController:signUpVC animated:YES completion:Nil];
}

-(IBAction)signupUsingEmail:(id)sender{
    
    if ([tanningDelegate.dbClass connected]) {
        
    SignInWithEmailViewController *signUpVC=[[SignInWithEmailViewController alloc] init];
    
    [self presentViewController:signUpVC animated:YES completion:nil];
    }
    else{
        
        [tanningDelegate.dbClass showNetworkALert];
    }
}

-(IBAction)termsAndConditionCheckboxClicked:(id)sender{
    
    UIButton *tempBtn=(UIButton *)sender;
    if (tempBtn.tag==0) {
        tempBtn.tag=1;
        
        [tempBtn setBackgroundImage:[UIImage imageNamed:@"check-alt"] forState:UIControlStateNormal];
    }
    else{
        tempBtn.tag=0;
        [tempBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
}
@end
