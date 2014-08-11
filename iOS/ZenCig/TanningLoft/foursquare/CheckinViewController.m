//
//  CheckinViewController.m
//  Foursquare2-iOS
//
//  Created by Constantine Fry on 1/21/13.
//
//

#import "CheckinViewController.h"
#import "Foursquare2.h"
#import "FSVenue.h"
#import "AppDelegate.h"
#import "Constant.h"
#import "ActivityLogDBClass.h"
#import "SocialWeightDetailDBClass.h"
@interface CheckinViewController ()

@end

@implementation CheckinViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    dbClass=[[DBConnectionClass alloc]init];
    self.title = @"Checkin";
    self.venueName.text = self.venue.name;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchDown];
    [button setTitle:@"" forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:14]];
    button.frame=CGRectMake(0, 0, 30, 30);
    [button setBackgroundImage:[UIImage imageNamed:@"back_d"] forState:UIControlStateNormal];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
}

- (void)viewDidUnload {
    [self setVenueName:nil];
    [super viewDidUnload];
}
- (IBAction)checkin:(id)sender {
    [Foursquare2  createCheckinAtVenue:self.venue.venueId
                                 venue:nil
                                 shout:@"Testing"
                             broadcast:broadcastPublic
                              latitude:nil
                             longitude:nil
                            accuracyLL:nil
                              altitude:nil
                           accuracyAlt:nil
                              callback:^(BOOL success, id result){
                                  NSLog(@"result %@",result);
                                  if (success) {
                                      
                                      if ([tanningDelegate.dbClass connected]) {
                                       
                                      float x = arc4random_uniform(10000000);
                                      NSString *url=[NSString stringWithFormat:@"https://foursquare.com/v/%@/%@",self.venueName.text,self.venue.venueId];
                                      
                                      NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@receivePost.php?userid=%@&username=%@&socialtype=FR&sharedurl=%@&bonuspoint=%@&postid=%f",tanningDelegate.hostString,[dbClass getUserName],[dbClass getFirstName],url,[(SocialWeightDetailDBClass *)[[tanningDelegate.dbClass fetchSocialPointWeight] objectAtIndex:0]FourSquarePoints],x] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
                                      NSURLConnection *shareDetailConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
                                      
                                      if (shareDetailConnection) {
                                          // Inform the user that the download failed.
                                         // shareDataArray=[[NSMutableData alloc ]init];
                                          
                                          //  [recievedData writeToFile:path atomically:YES];
                                          NSLog(@"JSON download youtube");
                                          
                                          UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Congratulations!"
                                                                                         message:[NSString stringWithFormat:@"You have successfully checked into Tanning Loft with Foursquare.  You currently have %@ points pending.Our team will review your check-in, once approved your %@ points will be awarded to your Account. ",[(SocialWeightDetailDBClass *)[[tanningDelegate.dbClass fetchSocialPointWeight] objectAtIndex:0]FourSquarePoints],[(SocialWeightDetailDBClass *)[[tanningDelegate.dbClass fetchSocialPointWeight] objectAtIndex:0]FourSquarePoints]]
                                                                                        delegate:self
                                                                               cancelButtonTitle:@"Done" otherButtonTitles:nil];
                                          [alert show];
                                          
                                          ActivityLogDBClass *activityClass=[[ActivityLogDBClass alloc]init];
                                          activityClass.activityId=[NSString stringWithFormat:@"%f",x];
                                          activityClass.activitytitle=@"Foursquare checkin";
                                          activityClass.username=[dbClass getUserName];
                                          activityClass.socialtype=@"FR";
                                          activityClass.activitytype=@"S";
                                          activityClass.activitydate=[NSString stringWithFormat:@"%@",[tanningDelegate.dbClass FormattedDateFromDate:[NSDate date]]];
                                          activityClass.expiredate=[NSString stringWithFormat:@"%@",[tanningDelegate.dbClass FormattedDateFromDate:[NSDate date]]];
                                          activityClass.amount=@"0";
                                          activityClass.point=[(SocialWeightDetailDBClass *)[[tanningDelegate.dbClass fetchSocialPointWeight] objectAtIndex:0]FourSquarePoints];
                                          activityClass.status=@"P";
                                          [tanningDelegate.dbClass insertActivityData:activityClass];
                                          
                                          //Add activity to server
                                          
                                          NSURLRequest *activityRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@ActivityLog.php?activityId=%@&userid=%@&firstname=%@&lastname=%@&socialtype=FR&activitytype=S&activitytitle=Foursquare checkin&activitydate=%@&expiredate=%@&amount=0&redeempoint=%@&status=P",tanningDelegate.hostString,[NSString stringWithFormat:@"%f",x],[dbClass getUserName],[dbClass getFirstName],[dbClass getLastName],[tanningDelegate.dbClass FormattedDateFromDate:[NSDate date]],[tanningDelegate.dbClass FormattedDateFromDate:[NSDate date]],[(SocialWeightDetailDBClass *)[[tanningDelegate.dbClass fetchSocialPointWeight] objectAtIndex:0]FourSquarePoints]] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
                                          NSURLConnection *activityDetailConnection = [[NSURLConnection alloc] initWithRequest:activityRequest delegate:self];
                                         
                                          NSLog(@"%@",[NSString stringWithFormat:@"%@ActivityLog.php?activityId=%@&userid=%@&firstname=%@&lastname=%@&socialtype=F&activitytype=S&activitytitle=Foursquare checkin&activitydate=%@&expiredate=%@&amount=0&redeempoint=2&status=P",tanningDelegate.hostString,[NSString stringWithFormat:@"%f",x],[dbClass getUserName],[dbClass getFirstName],[dbClass getLastName],[NSDate date],[NSDate date]]);
                                          
                                          if (activityDetailConnection) {
                                          
                                          }
                                          else{
                                              
                                          }

                                      }
                                      else {
                                          NSLog(@"JSON download fail");
                                      }

                                      
                                      //*************
                                      }
                                      else{
                                          UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Network" message:@"No Network Found" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                          [alert show];
                                      }
                                  }
                              }];

    
}

-(IBAction)backBtnClicked:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
