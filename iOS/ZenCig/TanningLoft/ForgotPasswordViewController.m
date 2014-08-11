//
//  ForgotPasswordViewController.m
//  MexicanAmigos
//
//  Created by Lavi Gupta on 15/08/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "SBJson.h"
#import "AppDelegate.h"
#import "Constant.h"

@interface ForgotPasswordViewController ()

@end

@implementation ForgotPasswordViewController
@synthesize emailTxt;

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


-(IBAction)submitButtonClicked:(id)sender{
    if ( [self validEmail:emailTxt.text] ) {
        
        emailTxt.backgroundColor=[UIColor whiteColor];
    }
    else{
       
        emailTxt.text=@"";
        emailTxt.backgroundColor=[UIColor redColor];
    }
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@ResetPassword.php?email=%@&format=json&num=10",tanningDelegate.hostString,emailTxt.text ] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding] ] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0] ;
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

-(IBAction)cancelButtonClicked:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
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
        
        NSLog(@"responseString %@",responseString);
        
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSMutableDictionary *jsonDictionary = [parser objectWithString:responseString error:nil];
        
        if([[jsonDictionary objectForKey:@"responsestatus"] integerValue] ==1 )
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Password Reset" message:@"New password has been sent to your registered Email Id." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
            [alert show];
        }
        else{
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Your email id is not registered with our system." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
            [alert show];
            
        }
        
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView.title isEqualToString:@"Password Reset"]) {
        
        if (buttonIndex==0) {
            [self dismissModalViewControllerAnimated:YES];
        }
    }
}

@end
