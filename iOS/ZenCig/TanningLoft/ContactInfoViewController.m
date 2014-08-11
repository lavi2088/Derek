//
//  ContactInfoViewController.m
//  TanningLoft
//
//  Created by Lavi on 13/05/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "ContactInfoViewController.h"

@interface ContactInfoViewController ()

@end

@implementation ContactInfoViewController{
    NSInteger diffVal;
}
@synthesize phoneLbl,emailLbl,websiteLbl;
@synthesize lbl1,lbl2,lbl3,lbl4,tw1;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //self.navigationItem.backBarButtonItem.title=@"Back";
         self.navigationItem.title=@"Contact Us";
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchDown];
        [button setTitle:@" " forState:UIControlStateNormal];
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
    diffVal=20;
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;   // iOS 7 specific
    self.navigationController.navigationBar.translucent = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    
    emailLbl.userInteractionEnabled = YES;
    UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(emailAction:)];
    [emailLbl addGestureRecognizer:gr];
    gr.numberOfTapsRequired = 1;
    gr.cancelsTouchesInView = NO;
    
    phoneLbl.userInteractionEnabled = YES;
    UITapGestureRecognizer *gr1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(phoneAction:)];
    [phoneLbl addGestureRecognizer:gr1];
    gr1.numberOfTapsRequired = 1;
    gr1.cancelsTouchesInView = NO;
    
    websiteLbl.userInteractionEnabled = YES;
    UITapGestureRecognizer *gr2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(websiteAction:)];
    [websiteLbl addGestureRecognizer:gr2];
    gr2.numberOfTapsRequired = 1;
    gr2.cancelsTouchesInView = NO;
    
    if (self.view.bounds.size.height<=380) {
        emailLbl.frame=CGRectMake(emailLbl.frame.origin.x, 313-diffVal, emailLbl.frame.size.width, emailLbl.frame.size.height);
        phoneLbl.frame=CGRectMake(phoneLbl.frame.origin.x, 361-diffVal, phoneLbl.frame.size.width, phoneLbl.frame.size.height);
        websiteLbl.frame=CGRectMake(websiteLbl.frame.origin.x, 336-diffVal, websiteLbl.frame.size.width, websiteLbl.frame.size.height);
        lbl1.frame=CGRectMake(lbl1.frame.origin.x, 188-diffVal, lbl1.frame.size.width, lbl1.frame.size.height);
        lbl2.frame=CGRectMake(lbl2.frame.origin.x, 188-diffVal, lbl2.frame.size.width, lbl2.frame.size.height);
        lbl3.frame=CGRectMake(lbl3.frame.origin.x, 210-diffVal, lbl3.frame.size.width, lbl3.frame.size.height);
        lbl4.frame=CGRectMake(lbl4.frame.origin.x, 210-diffVal, lbl4.frame.size.width, lbl4.frame.size.height);
        tw1.frame=CGRectMake(tw1.frame.origin.x, 237-diffVal, tw1.frame.size.width, tw1.frame.size.height);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)backBtnClicked:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)emailAction:(id)sender{
    NSLog(@"Email");
    
    /* create mail subject */
    NSString *subject = [NSString stringWithFormat:@"ZENCIG"];
    
    /* define email address */
    NSString *mail = [NSString stringWithFormat:@"service@zencig.com"];
    
    /* create the URL */
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"mailto:?to=%@&subject=%@",
                                                [mail stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding],
                                                [subject stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]]];
    
    /* load the URL */
    [[UIApplication sharedApplication] openURL:url];
}

-(IBAction)phoneAction:(id)sender{
    NSLog(@"Phone");
   
    
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Phone"
                                                      message:@"Do you want to call ZENCIG ?"
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:@"Cancel", nil];
    message.delegate=self;
    [message show];
}

-(IBAction)websiteAction:(id)sender{
    NSLog(@"Website");
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.zencig.com/"]];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        NSURL *URL = [NSURL URLWithString:@"tel://1-418 717-2553"];
        [[UIApplication sharedApplication] openURL:URL];
    }
}

@end
