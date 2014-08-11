//
//  DBConnectionClass.h
//  TanningLoft
//
//  Created by Lavi on 08/06/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FacebookSDK/FacebookSDK.h"
#include <sqlite3.h>
#import "SBJson.h"
#import "PointDetailDBClass.h"
#import "PackageDetailDBClass.h"
#import "PurchaseDBClass.h"
#import "ActivityLogDBClass.h"
#import "Reachability.h"
#import "SocialWeightDetailDBClass.h"
#import "UserDetailDBClass.h"
#import "MessageDBClass.h"
#import "SocialPostObj.h"

@interface DBConnectionClass : NSObject
{
    NSString *docsDir;
    NSArray *dirPaths;
    sqlite3 *appreaderDB;
}

-(BOOL)insertUserDetail :(UserDetailDBClass *)userDBObj;
-(BOOL)insertUserDetailForUsesAcces :(UserDetailDBClass *)userDBObj;
-(void)insertInitialPoints;
-(NSString *)getUserName;
-(NSString *)getFirstName;
-(NSString *)getLastName;
-(NSString *)getMemberSinceDate;

-(void)insertPackageDetail:(PackageDetailDBClass *)pkgObj;
-(NSMutableArray *)fetchPackageDetail:(NSString *)type;
-(void)insertPurchaseDetails:(PurchaseDBClass *)packageDetail;
-(NSMutableArray *)fetchPurchaseDetail:(NSString *)purchaseType;
-(void)updatePoints : (NSString *)fbPoint : (NSString *)twPoint : (NSString *) istaPoint : (NSString *) frPoint : (NSString *) spinWheelPoint;
-(PointDetailDBClass *)getPointDetails;
-(NSMutableArray *)fetchExpiredPurchase;

-(NSDate *)dateFromString:(NSString *)dateString;
-(NSString *)FormattedDateFromDate:(NSDate *)dateString;

-(void)insertActivityData:(ActivityLogDBClass *)activityObj;
-(NSMutableArray *)fetchAllActivitydata;
-(NSMutableArray *)fetchSocialActivitydata;
-(NSMutableArray *)fetchSocialActivityPendingdata;
-(void)insertTokenDetail:(NSString *)tokenStr;
-(NSMutableArray *)fetchUserDetail;
- (BOOL)connected;
-(void)updatePkgStatus : (NSString *)status : (NSString *)activityId;
-(void)insertSocialPointWeight:(SocialWeightDetailDBClass *)socialObj;
-(void)insertSocialShareData:(PackageDetailDBClass *)pkgObj;
-(NSMutableArray *)fetchSocialDetail;
-(void)UpdateLastSyncTime:(NSString *)time;
-(NSMutableArray *)fetchLastUpdateTime;
-(NSMutableArray *)fetchSocialPointWeight;
-(NSMutableArray *)fetchPurchaseDetailAccordingToID:(NSString *)purchaseID;
-(void)showIndicator;
-(void)hideIndicator;
-(void)showNetworkALert;
-(NSString *)dateFromStringWithMonthText:(NSString *)dateString;
-(void)updateSocialShareStatus:(NSString *)status : (NSString *)pkgID;
-(void)insertMessageDetails:(MessageDBClass *)msgObj;
-(NSMutableArray *)fetchMessageDetails;
-(NSMutableArray *)fetchMessageDetailsForMsgId:(NSString *)msgId;
-(void)updateMessageStatus:(NSString *)status : (NSString *)activityId;
-(void)updatePurchaseAfterRedeemed:(NSString *)pkgId;
-(void)insertPurchaseDetailsFromServer:(PurchaseDBClass *)packageDetail;
-(NSMutableArray *)fetchPackageDetailForID:(NSString *)pkgID;

-(void)insertSocialPostData:(SocialPostObj *)socialObj;
-(NSMutableArray *)fetchSocialPostDetail;
-(NSMutableArray *)fetchSocialPostDetailForID:(NSString *)socialId;
-(void)updateSocialPostStatus:(NSString *)status : (NSString *)pkgID;
@end
