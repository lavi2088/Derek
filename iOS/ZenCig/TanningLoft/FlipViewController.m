//
//  FlipViewController.m
//  MyMobiPoints
//
//  Created by Macmini on 30/12/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "FlipViewController.h"
#import "FacebookSocialPostViewController.h"
#import "PlayVideoViewController.h"

#define FRAME_MARGIN	60
#define MOVIE_MIN		1
#define MOVIE_MAX		4

@interface FlipViewController ()
{
    NSInteger maxIndex;
    NSInteger minIndex;
}
@property (assign, nonatomic) int previousIndex;
@property (assign, nonatomic) int tentativeIndex;
@property (assign, nonatomic) BOOL observerAdded;
@end

@implementation FlipViewController
@synthesize flipViewController;

@synthesize previousIndex = _previousIndex;
@synthesize tentativeIndex = _tentativeIndex;
@synthesize socialType;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        if ([socialType isEqualToString:@"facebook"]) {
            self.navigationItem.title=@"Facebook";
        }
        else{
            self.navigationItem.title=@"Twitter";
        }
        
        
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
    maxIndex=[tanningDelegate.dbClass fetchSocialPostDetail].count-1;
    minIndex=0;
    self.previousIndex = minIndex;
    // Configure the page view controller and add it as a child view controller.
	self.flipViewController = [[MPFlipViewController alloc] initWithOrientation:[self flipViewController:nil orientationForInterfaceOrientation:[UIApplication sharedApplication].statusBarOrientation]];
	self.flipViewController.delegate = self;
	self.flipViewController.dataSource = self;
	
	// Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
	BOOL hasFrame = YES;
	CGRect pageViewRect = self.view.bounds;
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
	{
		pageViewRect = CGRectInset(pageViewRect, 20 + (hasFrame? FRAME_MARGIN : 0), 20 + (hasFrame? FRAME_MARGIN : 0));
		self.flipViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	}
    
    self.flipViewController.view.frame = pageViewRect;
    self.flipViewController.view.frame=CGRectMake(0, 0, 320, 548);
	[self addChildViewController:self.flipViewController];
	[self.view addSubview:self.flipViewController.view];
	[self.flipViewController didMoveToParentViewController:self];
	
	[self.flipViewController setViewController:[self contentViewWithIndex:self.previousIndex] direction:MPFlipViewControllerDirectionForward animated:NO completion:nil];
	
	// Add the page view controller's gesture recognizers to the book view controller's view so that the gestures are started more easily.
	self.view.gestureRecognizers = self.flipViewController.gestureRecognizers;
    
    [self addObserver];
    
    if ([socialType isEqualToString:@"facebook"]) {
        self.navigationItem.title=@"Facebook";
    }
    else{
        self.navigationItem.title=@"Twitter";
    }

}

- (void)viewDidUnload
{
	[self removeObserver];
    [super viewDidUnload];
	
    // Release any retained subviews of the main view.
}

- (void)addObserver
{
	if (![self observerAdded])
	{
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(flipViewControllerDidFinishAnimatingNotification:) name:MPFlipViewControllerDidFinishAnimatingNotification object:nil];
		[self setObserverAdded:YES];
	}
}

- (void)removeObserver
{
	if ([self observerAdded])
	{
		[[NSNotificationCenter defaultCenter] removeObserver:self name:MPFlipViewControllerDidFinishAnimatingNotification object:nil];
		[self setObserverAdded:NO];
	}
}


- (FacebookSocialPostViewController *)contentViewWithIndex:(int)index
{
	FacebookSocialPostViewController *page = [[FacebookSocialPostViewController alloc]init];
    page.socialType=self.socialType;
	page.currentIndex = index;
	page.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	return page;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - MPFlipViewControllerDelegate protocol

- (void)flipViewController:(MPFlipViewController *)flipViewController didFinishAnimating:(BOOL)finished previousViewController:(UIViewController *)previousViewController transitionCompleted:(BOOL)completed
{
	if (completed)
	{
		self.previousIndex = self.tentativeIndex;
	}
}

- (MPFlipViewControllerOrientation)flipViewController:(MPFlipViewController *)flipViewController orientationForInterfaceOrientation:(UIInterfaceOrientation)orientation
{
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
		//return UIInterfaceOrientationIsPortrait(orientation)? MPFlipViewControllerOrientationVertical : MPFlipViewControllerOrientationHorizontal;
        return MPFlipViewControllerOrientationHorizontal;
	else
		return MPFlipViewControllerOrientationHorizontal;
}

#pragma mark - MPFlipViewControllerDataSource protocol

- (UIViewController *)flipViewController:(MPFlipViewController *)flipViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
	int index = self.previousIndex;
	index--;
	if (index < minIndex)
		return nil; // reached beginning, don't wrap
	self.tentativeIndex = index;
	return [self contentViewWithIndex:index];
}

- (UIViewController *)flipViewController:(MPFlipViewController *)flipViewController viewControllerAfterViewController:(UIViewController *)viewController
{
	int index = self.previousIndex;
	index++;
	if (index > maxIndex)
		return nil; // reached end, don't wrap
	self.tentativeIndex = index;
	return [self contentViewWithIndex:index];
}

#pragma mark - Notifications

- (void)flipViewControllerDidFinishAnimatingNotification:(NSNotification *)notification
{
	NSLog(@"Notification received: %@", notification);
}

-(IBAction)backBtnClicked:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}



@end
