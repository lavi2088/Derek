//
//  DBConnectionClass.m
//  TanningLoft
//
//  Created by Lavi on 08/06/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import "DBConnectionClass.h"
#import "PackageDetailDBClass.h"
#import "UserDetailDBClass.h"
#import "Constant.h"
#import "AppDelegate.h"
#import "InitialActivityLogWebService.h"
#import "SocialWeightDetailDBClass.h"
#import "CallUserDetails.h"

UIAlertView *alert;
@implementation DBConnectionClass

-(BOOL)insertUserDetail :(UserDetailDBClass *)userDBObj{
 
                 
                 dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                 
                 docsDir = [dirPaths objectAtIndex:0];
                 
                 NSString* databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Tanningloft.db"]];
                 
                 NSFileManager *filemgr = [NSFileManager defaultManager];
                 
                 
                 if ([filemgr fileExistsAtPath: databasePath ] == YES)
                 {
                     NSLog(@"In exist path");
                     
                     const char *dbpath = [databasePath UTF8String];
                     
                     if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
                     {
                         NSLog(@"start JSON Parsing");
                    
                         NSString *insertStatement;
                         
                         if ([self fetchUserDetail].count) {
                             if(userDBObj.firstname.length)
                             {
                                 insertStatement = [NSString stringWithFormat:@"UPDATE userdetail SET userid='%@' , firstName='%@' , lastName='%@', email='%@', membersince='%@', isActive='%@'",userDBObj.userId,userDBObj.firstname,userDBObj.lastname,userDBObj.email,userDBObj.memberSince,userDBObj.isActive];
                             }
                             else{
                                 insertStatement = [NSString stringWithFormat:@"UPDATE userdetail SET userid='%@' , lastName='%@', email='%@', membersince='%@', isActive='%@'",userDBObj.userId,userDBObj.lastname,userDBObj.email,userDBObj.memberSince,userDBObj.isActive];
                             }
                         }
                         else{
                             insertStatement = [NSString stringWithFormat:@"insert into userdetail values ('%@','%@','%@','','%@','%@','%@')",userDBObj.userId,userDBObj.firstname,userDBObj.lastname,userDBObj.memberSince,userDBObj.email,userDBObj.isActive];
                         }
                         // DocFullModePath
                         char *error;
                         NSLog(@"Document %@",insertStatement);
                         if (sqlite3_exec(appreaderDB, [insertStatement UTF8String], NULL, NULL, &error) != SQLITE_OK)
                         {
                             NSLog(@"Failed to update userdetails");
                             
                             // status.text = @"Failed to create table";
                             
                         }
                         else{
                             
                              [self insertInitialPoints];
                             
                             UserDetailDBClass *userObj=[[UserDetailDBClass alloc]init];
                             userObj=[[self fetchUserDetail] objectAtIndex:0];
                             
                             NSURLRequest *tokenRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@DeviceTokenUpdate.php?userid=%@&firstname=%@&lastname=%@&tokenid=%@&email=%@",tanningDelegate.hostString,[self getUserName],[self getFirstName],userObj.lastname,userObj.tokenNo,userDBObj.email] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
                             NSURLConnection *tokenDetailConnection = [[NSURLConnection alloc] initWithRequest:tokenRequest delegate:self];
                             NSLog(@"tokenDetailConnection%@",[[NSString stringWithFormat:@"%@DeviceTokenUpdate.php?userid=%@&firstname=%@&lastname=%@&tokenid=%@&email=%@",tanningDelegate.hostString,[self getUserName],[self getFirstName],userObj.lastname,userObj.tokenNo,userDBObj.email] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]);
                             
                             NSLog(@"Upadtion Done userdetails");
                             
                             InitialActivityLogWebService *initialActivityService=[[InitialActivityLogWebService alloc]init];
                             
                             [initialActivityService callInitailActivityLog];
                        }
                         
                     }
                 }
                 
    return YES;
}


-(BOOL)insertUserDetailForUsesAcces :(UserDetailDBClass *)userDBObj{
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    NSString* databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Tanningloft.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    
    if ([filemgr fileExistsAtPath: databasePath ] == YES)
    {
        NSLog(@"In exist path");
        
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            NSLog(@"start JSON Parsing");
            
            NSString *insertStatement;
            
            if ([self fetchUserDetail].count) {
                
                if(userDBObj.firstname.length)
                {
                    insertStatement = [NSString stringWithFormat:@"UPDATE userdetail SET userid='%@' , firstName='%@' , lastName='%@', email='%@', membersince='%@', isActive='%@'",userDBObj.userId,userDBObj.firstname,userDBObj.lastname,userDBObj.email,userDBObj.memberSince,userDBObj.isActive];
                }
                else{
                    insertStatement = [NSString stringWithFormat:@"UPDATE userdetail SET userid='%@' , lastName='%@', email='%@', membersince='%@', isActive='%@'",userDBObj.userId,userDBObj.lastname,userDBObj.email,userDBObj.memberSince,userDBObj.isActive];
                }
            }
            else{
                insertStatement = [NSString stringWithFormat:@"insert into userdetail values ('%@','%@','%@','','%@','%@','%@')",userDBObj.userId,userDBObj.firstname,userDBObj.lastname,userDBObj.memberSince,userDBObj.email,userDBObj.isActive];
            }
            // DocFullModePath
            char *error;
            NSLog(@"Document %@",insertStatement);
            if (sqlite3_exec(appreaderDB, [insertStatement UTF8String], NULL, NULL, &error) != SQLITE_OK)
            {
                NSLog(@"Failed to update userdetails");
            }
            else{
                
                
            }
            
        }
    }
    
    return YES;
}



-(void)insertTokenDetail:(NSString *)tokenStr{
    
    if([self fetchUserDetail].count)
    {
        return;
    }
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    NSString* databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Tanningloft.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    
    if ([filemgr fileExistsAtPath: databasePath ] == YES)
    {
        NSLog(@"In exist path");
        
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            NSLog(@"start JSON Parsing");
            
            NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            
            NSString *date=[formatter stringFromDate:[NSDate date]];
            
            NSString *insertStatement = [NSString stringWithFormat:@"INSERT INTO userdetail values ('','','','%@','%@','','1')",tokenStr,date];
            // DocFullModePath
            char *error;
            NSLog(@"Document %@",insertStatement);
            if (sqlite3_exec(appreaderDB, [insertStatement UTF8String], NULL, NULL, &error) != SQLITE_OK)
            {
                NSLog(@"Failed to log");
                
            }
            else{
                
                NSLog(@"Insertion Done");
            }
            //  }
            
            
        }
    }
    
    
}



-(NSMutableArray *)fetchUserDetail{
    
    sqlite3_stmt *statement;
    NSMutableArray *pkgDetailArray = nil;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    NSString* databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Tanningloft.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    pkgDetailArray=[[NSMutableArray alloc]init];
    
    if ([filemgr fileExistsAtPath: databasePath ] == YES)
    {
        NSLog(@"In exist path");
        
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            
            NSString *sql;
            
            sql = [NSString stringWithFormat:@"SELECT * FROM userdetail"];
            
            
            NSLog(@"%@",sql);
            
            if(sqlite3_open([databasePath UTF8String], &appreaderDB) == SQLITE_OK) {
                
                if(sqlite3_prepare_v2(appreaderDB, [sql UTF8String], -1, &statement, nil) == SQLITE_OK){
                    while (sqlite3_step(statement) == SQLITE_ROW) {
                        
                        UserDetailDBClass *userObj=[[UserDetailDBClass alloc]init];
                        
                        userObj.userId = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                        userObj.firstname = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                        userObj.lastname = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                        userObj.tokenNo = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                        userObj.memberSince = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                        userObj.email = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
                        userObj.isActive = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
                        
                        
                        [pkgDetailArray addObject:userObj];
                        
                    }
                }
            }
            
            
        }
    }
    
    return pkgDetailArray;
    
}


-(void)insertInitialPoints{
    
    
    if (FBSession.activeSession.isOpen) {
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection,
           NSDictionary<FBGraphUser> *user,
           NSError *error) {
             if (!error) {
                 //                     self.userNameLbl.text =  user.username;
                 //                     self.userProfileImage.profileID = [user objectForKey:@"id"];
                 
                 //TODO
                 
                 dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                 
                 docsDir = [dirPaths objectAtIndex:0];
                 
                 NSString* databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Tanningloft.db"]];
                 
                 NSFileManager *filemgr = [NSFileManager defaultManager];
                 
                 
                 if ([filemgr fileExistsAtPath: databasePath ] == YES)
                 {
                     NSLog(@"In exist path");
                     
                     const char *dbpath = [databasePath UTF8String];
                     
                     if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
                     {
                         NSLog(@"start JSON Parsing");
                         
                         NSString *insertStatement = [NSString stringWithFormat:@"INSERT INTO socialPointsDetail values ('0','0','0','0','0')"];
                         // DocFullModePath
                         char *error;
                         NSLog(@"Document %@",insertStatement);
                         if (sqlite3_exec(appreaderDB, [insertStatement UTF8String], NULL, NULL, &error) != SQLITE_OK)
                         {
                             NSLog(@"Failed to log");
                             
                             // status.text = @"Failed to create table";
                         }
                         else{
                             
                             NSLog(@"Insertion Done");
                         }
                         //  }
                         
                         
                     }
                 }
             
             }
         }];
    }
    
}

//Fetch User Name


-(NSString *)getUserName{
    
    sqlite3_stmt *statement;
    NSMutableArray *docDetailArray = nil;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    NSString* databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Tanningloft.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    docDetailArray=[[NSMutableArray alloc]init];
    NSString *userName;
    
    if ([filemgr fileExistsAtPath: databasePath ] == YES)
    {
        NSLog(@"In exist path");
        
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            
            NSString *sql = [NSString stringWithFormat:@"SELECT * FROM userdetail"];
            
            NSLog(@"%@",sql);
            
            if(sqlite3_open([databasePath UTF8String], &appreaderDB) == SQLITE_OK) {
                
                if(sqlite3_prepare_v2(appreaderDB, [sql UTF8String], -1, &statement, nil) == SQLITE_OK){
                    while (sqlite3_step(statement) == SQLITE_ROW) {
                        
                        
                        userName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                        
                        
                    }
                }
            }
            
            
        }
    }
    return userName;
    
}

-(NSString *)getMemberSinceDate{
   
    sqlite3_stmt *statement;
    NSMutableArray *docDetailArray = nil;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    NSString* databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Tanningloft.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    docDetailArray=[[NSMutableArray alloc]init];
    NSString *userName;
    
    if ([filemgr fileExistsAtPath: databasePath ] == YES)
    {
        NSLog(@"In exist path");
        
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            
            NSString *sql = [NSString stringWithFormat:@"SELECT * FROM userdetail"];
            
            NSLog(@"getMemberSinceDate %@",sql);
            
            if(sqlite3_open([databasePath UTF8String], &appreaderDB) == SQLITE_OK) {
                
                if(sqlite3_prepare_v2(appreaderDB, [sql UTF8String], -1, &statement, nil) == SQLITE_OK){
                    while (sqlite3_step(statement) == SQLITE_ROW) {
                        
                        
                        userName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                        
                        
                    }
                }
            }
            
            
        }
    }
     NSLog(@"getMemberSinceDate userName %@",userName);
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *tempDate=[formatter dateFromString:userName];
    [formatter setDateFormat:@"MMM yyyy"];
    return [formatter stringFromDate:tempDate];
    
}

-(void)updatePoints : (NSString *)fbPoint : (NSString *)twPoint : (NSString *) istaPoint : (NSString *) frPoint : (NSString *) spinWheelPoint {
    
    //    NSString *docsDir;
    //    NSArray *dirPaths;
    //    sqlite3 *appreaderDB;
    sqlite3_stmt *statement;
    sqlite3_stmt *statement1;
    NSMutableArray *docDetailArray = nil;
    
    // Get the documents directory
    
    //tbl_DocumentDetail (DocId TEXT , DocTitle TEXT, DocDesc TEXT, DocName TEXT, DocMode TEXT, DocPath TEXT
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    NSString* databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Tanningloft.db"]];
    NSLog(@"%@",databasePath);
    NSFileManager *filemgr = [NSFileManager defaultManager];
    docDetailArray=[[NSMutableArray alloc]init];
    
    //CREATE TABLE IF NOT EXISTS socialPointsDetail (facbookPoint TEXT , twitterPoint TEXT, istagramPoint TEXT,fourSquarePoint TEXT, spinningWheel TEXT
    
    if ([filemgr fileExistsAtPath: databasePath ] == YES)
    {
        NSLog(@"In exist path");
        
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            
            NSString *sql = [NSString stringWithFormat:@"UPDATE socialPointsDetail SET facbookPoint='%@',twitterPoint='%@', istagramPoint='%@', fourSquarePoint='%@' , spinningWheel='%@' ",fbPoint,twPoint,istaPoint,frPoint,spinWheelPoint];
            
            
            
            NSLog(@"%@",sql);
            
            
            
            
            if(sqlite3_open([databasePath UTF8String], &appreaderDB) == SQLITE_OK) {
                
                if(sqlite3_prepare_v2(appreaderDB,[sql UTF8String], -1, &statement, nil) == SQLITE_OK){
                    
                    NSLog(@"Insertion done");
                    
                    //the binding part is missing in your code , you need to write after Prepare statement.
                    
                    char *str;
                    sqlite3_exec(appreaderDB,[sql UTF8String],0,0,&str);
                    printf("Status :%s\n",str);
                    
                    
                }
                else{
                    NSLog(@"Not updated");
                }
            }
            
            
        }
    }
    
    sqlite3_close(appreaderDB);
    
}

-(PointDetailDBClass *)getPointDetails{
    
    sqlite3_stmt *statement;
    NSMutableArray *docDetailArray = nil;
    
    // Get the documents directory
    
    //tbl_DocumentDetail (DocId TEXT , DocTitle TEXT, DocDesc TEXT, DocName TEXT, DocMode TEXT, DocPath TEXT
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    NSString* databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Tanningloft.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    docDetailArray=[[NSMutableArray alloc]init];
    
    PointDetailDBClass *pointObj=[[PointDetailDBClass alloc]init];
    
    if ([filemgr fileExistsAtPath: databasePath ] == YES)
    {
        NSLog(@"In exist path");
        
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            
            NSString *sql = [NSString stringWithFormat:@"SELECT * FROM socialPointsDetail"];
            
            NSLog(@"%@",sql);
            
            if(sqlite3_open([databasePath UTF8String], &appreaderDB) == SQLITE_OK) {
                
                if(sqlite3_prepare_v2(appreaderDB, [sql UTF8String], -1, &statement, nil) == SQLITE_OK){
                    while (sqlite3_step(statement) == SQLITE_ROW) {
                        
                        
                        pointObj.fbPoint = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                        pointObj.twPoint = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                        pointObj.IstagramPoint = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                        pointObj.fourSqrPoint = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                        pointObj.spinningWheelPoint = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                        
                        
                    }
                }
            }
            
            
        }
    }
    
    return pointObj;
    
}

-(NSString *)getFirstName{
    
    sqlite3_stmt *statement;
    NSMutableArray *docDetailArray = nil;
    
    // Get the documents directory
    
    //tbl_DocumentDetail (DocId TEXT , DocTitle TEXT, DocDesc TEXT, DocName TEXT, DocMode TEXT, DocPath TEXT
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    NSString* databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Tanningloft.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    docDetailArray=[[NSMutableArray alloc]init];
    NSString *userName;
    
    if ([filemgr fileExistsAtPath: databasePath ] == YES)
    {
        NSLog(@"In exist path");
        
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            
            NSString *sql = [NSString stringWithFormat:@"SELECT * FROM userdetail"];
            
            NSLog(@"%@",sql);
            
            if(sqlite3_open([databasePath UTF8String], &appreaderDB) == SQLITE_OK) {
                
                if(sqlite3_prepare_v2(appreaderDB, [sql UTF8String], -1, &statement, nil) == SQLITE_OK){
                    while (sqlite3_step(statement) == SQLITE_ROW) {
                        
                        userName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                    
                    }
                }
            }
            
        }
    }
    return userName;
    
}

-(NSString *)getLastName{
    
    sqlite3_stmt *statement;
    NSMutableArray *docDetailArray = nil;
    
    // Get the documents directory
    
    //tbl_DocumentDetail (DocId TEXT , DocTitle TEXT, DocDesc TEXT, DocName TEXT, DocMode TEXT, DocPath TEXT
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    NSString* databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Tanningloft.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    docDetailArray=[[NSMutableArray alloc]init];
    NSString *userName;
    
    if ([filemgr fileExistsAtPath: databasePath ] == YES)
    {
        NSLog(@"In exist path");
        
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            
            NSString *sql = [NSString stringWithFormat:@"SELECT * FROM userdetail"];
            
            NSLog(@"%@",sql);
            
            if(sqlite3_open([databasePath UTF8String], &appreaderDB) == SQLITE_OK) {
                
                if(sqlite3_prepare_v2(appreaderDB, [sql UTF8String], -1, &statement, nil) == SQLITE_OK){
                    while (sqlite3_step(statement) == SQLITE_ROW) {
                        
                        
                        userName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                        
                        
                    }
                }
            }
            
            
        }
    }
    return userName;
    
}

-(NSDate *)dateFromString:(NSString *)dateString{
    NSLog(@"%@",dateString);
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date=[formatter dateFromString:dateString];
    
    NSLog(@"%@",date);
    return date;
}

-(NSString *)FormattedDateFromDate:(NSDate *)dateString{
    NSLog(@"%@",dateString);
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *date=[formatter stringFromDate:dateString];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSLog(@"%@",date);
    return date;
}

-(NSString *)dateFromStringWithMonthText:(NSString *)dateString{
    NSLog(@"%@",dateString);
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date=[formatter dateFromString:dateString];
    
    [formatter setDateFormat:@"MMM-dd-yyyy"];
    
    NSString *dateText=[formatter stringFromDate:date];
    NSLog(@"%@",date);
    return dateText;
}

-(void)insertPackageDetail:(PackageDetailDBClass *)pkgObj{
    
       
    //TODO
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    NSString* databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Tanningloft.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    
    if ([filemgr fileExistsAtPath: databasePath ] == YES)
    {
        NSLog(@"In exist path");
        
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            NSLog(@"start JSON Parsing");
            
            NSString *insertStatement ;
            
            if (![self fetchPackageDetailForID:pkgObj.pkgID].count) {
                insertStatement = [NSString stringWithFormat:@"INSERT INTO PackageDetailTable values ('%@','%@','%@','%@','%@','%@', '%@','%@','%@','%@','%@')",pkgObj.pkgID,[pkgObj.pkgTitle stringByReplacingOccurrencesOfString:@"'" withString:@"''"]  ,[pkgObj.pkgDescription stringByReplacingOccurrencesOfString:@"'" withString:@"''"] ,pkgObj.pkgImagePath,pkgObj.pkgPoints,pkgObj.pkgAmount,pkgObj.AddedDate,pkgObj.isActive,pkgObj.pkgType,[pkgObj.imgName stringByReplacingOccurrencesOfString:@"'" withString:@"''"],pkgObj.pkgDurationType];
            }
            else{
                insertStatement = [NSString stringWithFormat:@"UPDATE PackageDetailTable SET  pkgTitle='%@', pkgDescription='%@', pkgImagePath='%@',pkgPoints='%@',pkgAmount='%@',AddedDate='%@', isActive='%@', pkgType='%@', imgname='%@' where pkgId='%@' AND  pkgDurationType='%@'",[pkgObj.pkgTitle stringByReplacingOccurrencesOfString:@"'" withString:@"''"],[pkgObj.pkgDescription stringByReplacingOccurrencesOfString:@"'" withString:@"''"] ,pkgObj.pkgImagePath,pkgObj.pkgPoints,pkgObj.pkgAmount,pkgObj.AddedDate,pkgObj.isActive,pkgObj.pkgType,[pkgObj.imgName stringByReplacingOccurrencesOfString:@"'" withString:@"''"],pkgObj.pkgID,pkgObj.pkgDurationType];
            }
            // DocFullModePath
            char *error;
            NSLog(@"Document %@",insertStatement);
            if (sqlite3_exec(appreaderDB, [insertStatement UTF8String], NULL, NULL, &error) != SQLITE_OK)
            {
                NSLog(@"PackageDetailTable Failed to log");
                
                // status.text = @"Failed to create table";
            }
            else{
                if([pkgObj.isActive isEqualToString:@"1"])
                {
                NSLog(@"%@",[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",tanningDelegate.hostString,pkgObj.pkgImagePath]]);
                
                UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",tanningDelegate.hostString,pkgObj.pkgImagePath]]]];
                
                NSLog(@"%f,%f",image.size.width,image.size.height);
                
                // Let's save the file into Document folder.
                // You can also change this to your desktop for testing. (e.g. /Users/kiichi/Desktop/)
                // NSString *deskTopDir = @"/Users/kiichi/Desktop";
                
                NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                
                // If you go to the folder below, you will find those pictures
                NSLog(@"%@",docDir);
                
                NSLog(@"saving png");
                
                    NSString *pngFilePath = [NSString stringWithFormat:@"%@/upload/%@",docDir,pkgObj.imgName];
                    NSData *data1 = [NSData dataWithData:UIImagePNGRepresentation(image)];
                    [data1 writeToFile:pngFilePath atomically:YES];
                }
                
                NSLog(@"saving image done");
            }
            
            
            
            
        }
    }
    
    
    //End of insert stmt
    
    
}

-(NSMutableArray *)fetchPackageDetail:(NSString *)type{
    
    sqlite3_stmt *statement;
    NSMutableArray *pkgDetailArray = nil;
    
    // Get the documents directory
    
    //tbl_DocumentDetail (DocId TEXT , DocTitle TEXT, DocDesc TEXT, DocName TEXT, DocMode TEXT, DocPath TEXT
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    NSString* databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Tanningloft.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    pkgDetailArray=[[NSMutableArray alloc]init];
    NSString *userName;
    
    if ([filemgr fileExistsAtPath: databasePath ] == YES)
    {
        NSLog(@"In exist path");
        
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            
            NSString *sql;
            
            if ([type isEqualToString:@""]) {
                sql = [NSString stringWithFormat:@"SELECT * FROM PackageDetailTable where isActive='1' AND pkgType!='B' order by AddedDate asc"];
            }
            else{
                sql = [NSString stringWithFormat:@"SELECT * FROM PackageDetailTable where pkgType='%@' AND isActive='1' order by AddedDate asc",type];
            }
            
            NSLog(@"%@",sql);
            
            if(sqlite3_open([databasePath UTF8String], &appreaderDB) == SQLITE_OK) {
                
                if(sqlite3_prepare_v2(appreaderDB, [sql UTF8String], -1, &statement, nil) == SQLITE_OK){
                    while (sqlite3_step(statement) == SQLITE_ROW) {
                        
                        PackageDetailDBClass *pkgObj=[[PackageDetailDBClass alloc]init];
                        
                        pkgObj.pkgID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                        pkgObj.pkgTitle = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)] ;
                        pkgObj.pkgDescription = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                        pkgObj.pkgImagePath = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                        pkgObj.pkgPoints = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                        pkgObj.pkgAmount = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
                        pkgObj.AddedDate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
                        pkgObj.isActive = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)];
                        pkgObj.pkgType = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 8)];
                        pkgObj.imgName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 9)];
                        pkgObj.pkgDurationType = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 10)];
                        
                        [pkgDetailArray addObject:pkgObj];
                        
                    }
                }
            }
            
            
        }
    }
    return pkgDetailArray;
    
}

-(NSMutableArray *)fetchPackageDetailForID:(NSString *)pkgID{
    
    
    //    NSString *docsDir;
    //    NSArray *dirPaths;
    //    sqlite3 *appreaderDB;
    sqlite3_stmt *statement;
    NSMutableArray *pkgDetailArray = nil;
    
    // Get the documents directory
    
    //tbl_DocumentDetail (DocId TEXT , DocTitle TEXT, DocDesc TEXT, DocName TEXT, DocMode TEXT, DocPath TEXT
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    NSString* databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Tanningloft.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    pkgDetailArray=[[NSMutableArray alloc]init];
    NSString *userName;
    
    if ([filemgr fileExistsAtPath: databasePath ] == YES)
    {
        NSLog(@"In exist path");
        
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            
            NSString *sql;
            
            
            //CREATE TABLE IF NOT EXISTS PackageDetailTable (pkgId TEXT,pkgTitle TEXT , pkgDescription TEXT, pkgImagePath TEXT,pkgPoints TEXT, pkgAmount TEXT, AddedDate TEXT, isActive TEXT,pkgType TEXT, imgname TEXT
            
            sql = [NSString stringWithFormat:@"SELECT * FROM PackageDetailTable where pkgId='%@'",pkgID];
           
            
            NSLog(@"%@",sql);
            
            if(sqlite3_open([databasePath UTF8String], &appreaderDB) == SQLITE_OK) {
                
                if(sqlite3_prepare_v2(appreaderDB, [sql UTF8String], -1, &statement, nil) == SQLITE_OK){
                    while (sqlite3_step(statement) == SQLITE_ROW) {
                        
                        PackageDetailDBClass *pkgObj=[[PackageDetailDBClass alloc]init];
                        
                        pkgObj.pkgID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                        pkgObj.pkgTitle = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                        pkgObj.pkgDescription = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                        pkgObj.pkgImagePath = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                        pkgObj.pkgPoints = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                        pkgObj.pkgAmount = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
                        pkgObj.AddedDate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
                        pkgObj.isActive = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)];
                        pkgObj.pkgType = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 8)];
                        pkgObj.imgName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 9)];
                        pkgObj.pkgDurationType = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 10)];
                        
                        [pkgDetailArray addObject:pkgObj];
                        
                    }
                }
            }
            
            
        }
    }
    return pkgDetailArray;
    
}


-(NSMutableArray *)fetchSocialDetail{
    
    sqlite3_stmt *statement;
    NSMutableArray *pkgDetailArray = nil;
    
    // Get the documents directory
    
    //tbl_DocumentDetail (DocId TEXT , DocTitle TEXT, DocDesc TEXT, DocName TEXT, DocMode TEXT, DocPath TEXT
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    NSString* databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Tanningloft.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    pkgDetailArray=[[NSMutableArray alloc]init];
    NSString *userName;
    
    if ([filemgr fileExistsAtPath: databasePath ] == YES)
    {
        NSLog(@"In exist path");
        
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            
            NSString *sql;
            
            
            sql = [NSString stringWithFormat:@"SELECT * FROM SocialShareDetails where isActive='1'"];
            
            
            NSLog(@"%@",sql);
            
          //  CREATE TABLE IF NOT EXISTS SocialShareDetails (Id TEXT,Title TEXT , Description TEXT, ImgPath TEXT,AddedDate TEXT, Hyperlink TEXT,imgname TEXT
                                                           
            if(sqlite3_open([databasePath UTF8String], &appreaderDB) == SQLITE_OK) {
                
                if(sqlite3_prepare_v2(appreaderDB, [sql UTF8String], -1, &statement, nil) == SQLITE_OK){
                    while (sqlite3_step(statement) == SQLITE_ROW) {
                        
                        PackageDetailDBClass *pkgObj=[[PackageDetailDBClass alloc]init];
                        
                        pkgObj.pkgID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                        pkgObj.pkgTitle = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                        pkgObj.pkgDescription = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                        pkgObj.pkgImagePath = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                        pkgObj.AddedDate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                        pkgObj.pkgLink = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
                        pkgObj.imgName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
                        
                        [pkgDetailArray addObject:pkgObj];
                        
                    }
                }
            }
            
            
        }
    }
    return pkgDetailArray;
    
}

-(NSMutableArray *)fetchSocialDetailForID:(NSString *)pkgId{
    
    
    //    NSString *docsDir;
    //    NSArray *dirPaths;
    //    sqlite3 *appreaderDB;
    sqlite3_stmt *statement;
    NSMutableArray *pkgDetailArray = nil;
    
    // Get the documents directory
    
    //tbl_DocumentDetail (DocId TEXT , DocTitle TEXT, DocDesc TEXT, DocName TEXT, DocMode TEXT, DocPath TEXT
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    NSString* databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Tanningloft.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    pkgDetailArray=[[NSMutableArray alloc]init];
    NSString *userName;
    
    if ([filemgr fileExistsAtPath: databasePath ] == YES)
    {
        NSLog(@"In exist path");
        
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            
            NSString *sql;
            
            
            sql = [NSString stringWithFormat:@"SELECT * FROM SocialShareDetails where Id='%@'",pkgId];
            
            
            NSLog(@"%@",sql);
            
            //  CREATE TABLE IF NOT EXISTS SocialShareDetails (Id TEXT,Title TEXT , Description TEXT, ImgPath TEXT,AddedDate TEXT, Hyperlink TEXT,imgname TEXT
            
            if(sqlite3_open([databasePath UTF8String], &appreaderDB) == SQLITE_OK) {
                
                if(sqlite3_prepare_v2(appreaderDB, [sql UTF8String], -1, &statement, nil) == SQLITE_OK){
                    while (sqlite3_step(statement) == SQLITE_ROW) {
                        
                        PackageDetailDBClass *pkgObj=[[PackageDetailDBClass alloc]init];
                        
                        pkgObj.pkgID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                        pkgObj.pkgTitle = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                        pkgObj.pkgDescription = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                        pkgObj.pkgImagePath = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                        pkgObj.AddedDate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                        pkgObj.pkgLink = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
                        pkgObj.imgName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
                        
                        [pkgDetailArray addObject:pkgObj];
                        
                    }
                }
            }
            
            
        }
    }
    return pkgDetailArray;
    
}

-(void)updateSocialShareStatus:(NSString *)status : (NSString *)pkgID{
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    NSString* databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Tanningloft.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    
    if ([filemgr fileExistsAtPath: databasePath ] == YES)
    {
        NSLog(@"In exist path");
        
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            NSLog(@"start JSON Parsing");
        
            NSString *insertStatement = [NSString stringWithFormat:@"UPDATE SocialShareDetails SET isActive='%@' where Id='%@'",status,pkgID];
            // DocFullModePath
            char *error;
            NSLog(@"Document %@",insertStatement);
            if (sqlite3_exec(appreaderDB, [insertStatement UTF8String], NULL, NULL, &error) != SQLITE_OK)
            {
                NSLog(@"Failed to update activity status");
                
            }
            else{
                
            }
            //  }
            
            
        }
    }
    
}

-(void)insertPurchaseDetails:(PurchaseDBClass *)packageDetail {
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    NSString* databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Tanningloft.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    
    if ([filemgr fileExistsAtPath: databasePath ] == YES)
    {
        NSLog(@"In exist path");
        
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            NSLog(@"start JSON Parsing");
            
            //CREATE TABLE IF NOT EXISTS purchasedetail (ArticleId TEXT , ArticleTitle TEXT, Amount TEXT, Date TEXT, ArticleDesc TEXT
            
            NSString *insertStatement = [NSString stringWithFormat:@"INSERT INTO purchasedetail values ('%@','%@','%@','%@','%@','%@','%@','%@','%@')",packageDetail.pkgId,[packageDetail.pkgTitle stringByReplacingOccurrencesOfString:@"'" withString:@"''"],packageDetail.pkgAmount,[tanningDelegate.dbClass dateFromString:tanningDelegate.currentServerTime],[[tanningDelegate.dbClass dateFromString:tanningDelegate.currentServerTime] dateByAddingTimeInterval:24*3600*30],[packageDetail.pkgDescription stringByReplacingOccurrencesOfString:@"'" withString:@"''"],packageDetail.type ,packageDetail.redeemedDate,packageDetail.isRedeemed];
            // DocFullModePath
            char *error;
            NSLog(@"Document %@",insertStatement);
            if (sqlite3_exec(appreaderDB, [insertStatement UTF8String], NULL, NULL, &error) != SQLITE_OK)
            {
                NSLog(@"purchasedetail Failed to log %s",error);
            }
            else{
                
                NSLog(@"Insertion Done");
            }
        }
    }
}

-(void)insertPurchaseDetailsFromServer:(PurchaseDBClass *)packageDetail {
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    NSString* databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Tanningloft.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    
    if ([filemgr fileExistsAtPath: databasePath ] == YES)
    {
        NSLog(@"In exist path");
        
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            NSLog(@"start JSON Parsing");
            
            NSString *insertStatement = [NSString stringWithFormat:@"INSERT INTO purchasedetail values ('%@','%@','%@','%@','%@','%@','%@','%@','%@')",packageDetail.pkgId,[packageDetail.pkgTitle stringByReplacingOccurrencesOfString:@"'" withString:@"''"],packageDetail.pkgAmount,[tanningDelegate.dbClass dateFromString:packageDetail.AddedDate],[tanningDelegate.dbClass dateFromString:packageDetail.ExpireDate] ,[packageDetail.pkgDescription stringByReplacingOccurrencesOfString:@"'" withString:@"''"],packageDetail.type,packageDetail.redeemedDate,packageDetail.isRedeemed];
            // DocFullModePath
            char *error;
            NSLog(@"Document %@",insertStatement);
            if (sqlite3_exec(appreaderDB, [insertStatement UTF8String], NULL, NULL, &error) != SQLITE_OK)
            {
                NSLog(@"purchasedetail Failed to log %s",error);
            }
            else{
                
                NSLog(@"Insertion Done");
            }
        }
    }
}

-(NSMutableArray *)fetchPurchaseDetail:(NSString *)purchaseType{
    
    
    //    NSString *docsDir;
    //    NSArray *dirPaths;
    //    sqlite3 *appreaderDB;
    sqlite3_stmt *statement;
    NSMutableArray *pkgDetailArray = nil;
    
    // Get the documents directory
    
    // CREATE TABLE IF NOT EXISTS purchasedetail (ArticleId TEXT , ArticleTitle TEXT, Amount TEXT, Date TEXT, ArticleDesc TEXT
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    NSString* databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Tanningloft.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    pkgDetailArray=[[NSMutableArray alloc]init];
    NSString *userName;
    
    if ([filemgr fileExistsAtPath: databasePath ] == YES)
    {
        NSLog(@"In exist path");
        
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            
            NSString *sql = [NSString stringWithFormat:@"SELECT * FROM purchasedetail where ExpireDate>'%@'",[tanningDelegate.dbClass dateFromString:tanningDelegate.currentServerTime]];
            
            NSLog(@"%@",sql);
            
            if(sqlite3_open([databasePath UTF8String], &appreaderDB) == SQLITE_OK) {
                
                if(sqlite3_prepare_v2(appreaderDB, [sql UTF8String], -1, &statement, nil) == SQLITE_OK){
                    while (sqlite3_step(statement) == SQLITE_ROW) {
                        
                        PurchaseDBClass *pkgObj=[[PurchaseDBClass alloc]init];
                        
                        
                        pkgObj.pkgId = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                        pkgObj.pkgTitle = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                        pkgObj.pkgAmount = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                        pkgObj.AddedDate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                        pkgObj.ExpireDate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                        pkgObj.pkgDescription = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
                        pkgObj.type = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
                        pkgObj.redeemedDate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)];
                        pkgObj.isRedeemed = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 8)];
                        
                        [pkgDetailArray addObject:pkgObj];
                        
                    }
                }
            }
            
            
        }
    }
    return pkgDetailArray;
    
}

-(NSMutableArray *)fetchPurchaseDetailAccordingToID:(NSString *)purchaseID{
    
    
    //    NSString *docsDir;
    //    NSArray *dirPaths;
    //    sqlite3 *appreaderDB;
    sqlite3_stmt *statement;
    NSMutableArray *pkgDetailArray = nil;
    
    // Get the documents directory
    
    // CREATE TABLE IF NOT EXISTS purchasedetail (ArticleId TEXT , ArticleTitle TEXT, Amount TEXT, Date TEXT, ArticleDesc TEXT
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    NSString* databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Tanningloft.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    pkgDetailArray=[[NSMutableArray alloc]init];
    NSString *userName;
    
    if ([filemgr fileExistsAtPath: databasePath ] == YES)
    {
        NSLog(@"In exist path");
        
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            
            NSString *sql = [NSString stringWithFormat:@"SELECT * FROM purchasedetail where ArticleId='%@'",purchaseID];
            
            NSLog(@"%@",sql);
            
            if(sqlite3_open([databasePath UTF8String], &appreaderDB) == SQLITE_OK) {
                
                if(sqlite3_prepare_v2(appreaderDB, [sql UTF8String], -1, &statement, nil) == SQLITE_OK){
                    while (sqlite3_step(statement) == SQLITE_ROW) {
                        
                        PurchaseDBClass *pkgObj=[[PurchaseDBClass alloc]init];
                        
                        
                        pkgObj.pkgId = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                        pkgObj.pkgTitle = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                        pkgObj.pkgAmount = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                        pkgObj.AddedDate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                        pkgObj.ExpireDate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                        pkgObj.pkgDescription = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
                        pkgObj.type = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
                        pkgObj.redeemedDate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)];
                        pkgObj.isRedeemed = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 8)];
                        
                        [pkgDetailArray addObject:pkgObj];
                        
                    }
                }
            }
            
            
        }
    }
    return pkgDetailArray;
    
}

-(NSMutableArray *)fetchExpiredPurchase{
    
    
    //    NSString *docsDir;
    //    NSArray *dirPaths;
    //    sqlite3 *appreaderDB;
    sqlite3_stmt *statement;
    NSMutableArray *pkgDetailArray = nil;
    
    // Get the documents directory
    
    // CREATE TABLE IF NOT EXISTS purchasedetail (ArticleId TEXT , ArticleTitle TEXT, Amount TEXT, Date TEXT, ArticleDesc TEXT
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    NSString* databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Tanningloft.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    pkgDetailArray=[[NSMutableArray alloc]init];
    NSString *userName;
    
    if ([filemgr fileExistsAtPath: databasePath ] == YES)
    {
        NSLog(@"In exist path");
        
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            
            NSString *sql = [NSString stringWithFormat:@"SELECT * FROM purchasedetail where ExpireDate<='%@'",[tanningDelegate.dbClass dateFromString:tanningDelegate.currentServerTime]];
            
            NSLog(@"%@",sql);
            
            if(sqlite3_open([databasePath UTF8String], &appreaderDB) == SQLITE_OK) {
                
                if(sqlite3_prepare_v2(appreaderDB, [sql UTF8String], -1, &statement, nil) == SQLITE_OK){
                    while (sqlite3_step(statement) == SQLITE_ROW) {
                        
                        PurchaseDBClass *pkgObj=[[PurchaseDBClass alloc]init];
                        
                        
                        pkgObj.pkgId = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                        pkgObj.pkgTitle = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                        pkgObj.pkgAmount = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                        pkgObj.AddedDate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                        pkgObj.ExpireDate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                        pkgObj.pkgDescription = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
                        pkgObj.type = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
                        pkgObj.redeemedDate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)];
                        pkgObj.isRedeemed = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 8)];
                        
                        [pkgDetailArray addObject:pkgObj];
                        
                    }
                }
            }
            
            
        }
    }
    return pkgDetailArray;
    
}

-(void)insertActivityData:(ActivityLogDBClass *)activityObj{
    
    //    NSString *docsDir;
    //    NSArray *dirPaths;
    //    sqlite3 *appreaderDB;
    
    //TODO
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    NSString* databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Tanningloft.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    
    if ([filemgr fileExistsAtPath: databasePath ] == YES)
    {
        NSLog(@"In exist path");
        
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            NSLog(@"start JSON Parsing");
            
            //CREATE TABLE IF NOT EXISTS ActivityLog (activityId TEXT,username TEXT , socialtype TEXT, activitytype TEXT,activitytitle TEXT, activitydate TEXT, expiredate TEXT, amount TEXT,point TEXT, status TEXT
            
            
            NSString *insertStatement = [NSString stringWithFormat:@"INSERT INTO ActivityLog values ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",activityObj.activityId,activityObj.username,activityObj.socialtype,activityObj.activitytype,activityObj.activitytitle,activityObj.activitydate,activityObj.expiredate,activityObj.amount,activityObj.point,activityObj.status];
            // DocFullModePath
            char *error;
            NSLog(@"ActivityLog %@",insertStatement);
            if (sqlite3_exec(appreaderDB, [insertStatement UTF8String], NULL, NULL, &error) != SQLITE_OK)
            {
                NSLog(@"ActivityLog Failed to log %s",error);
                
                // status.text = @"Failed to create table";
            }
            else{
                
                NSLog(@"ActivityLog Insertion Done");
            }
        }
    }
}

-(NSMutableArray *)fetchAllActivitydata{
    
    sqlite3_stmt *statement;
    NSMutableArray *pkgDetailArray = nil;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    NSString* databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Tanningloft.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    pkgDetailArray=[[NSMutableArray alloc]init];
    NSString *userName;
    
    if ([filemgr fileExistsAtPath: databasePath ] == YES)
    {
        NSLog(@"In exist path");
        
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            
            NSString *sql = [NSString stringWithFormat:@"SELECT * FROM ActivityLog ORDER BY activitydate DESC"];
            
            NSLog(@"%@",sql);
            
            if(sqlite3_open([databasePath UTF8String], &appreaderDB) == SQLITE_OK) {
                
                if(sqlite3_prepare_v2(appreaderDB, [sql UTF8String], -1, &statement, nil) == SQLITE_OK){
                    while (sqlite3_step(statement) == SQLITE_ROW) {
                        
                        ActivityLogDBClass *activityObj=[[ActivityLogDBClass alloc]init];
                        //CREATE TABLE IF NOT EXISTS ActivityLog (activityId TEXT,username TEXT , socialtype TEXT, activitytype TEXT,activitytitle TEXT, activitydate TEXT, expiredate TEXT, amount TEXT,point TEXT, status TEXT
                        
                        activityObj.activityId = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                        activityObj.username = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                        activityObj.socialtype = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                        activityObj.activitytype = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                        activityObj.activitytitle = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                        activityObj.activitydate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
                        activityObj.expiredate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
                        activityObj.amount = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)];
                        activityObj.point = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 8)];
                        activityObj.status = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 9)];
                        
                        [pkgDetailArray addObject:activityObj];
                        
                    }
                }
            }
            
            
        }
    }
    return pkgDetailArray;
    
}

-(NSMutableArray *)fetchSocialActivitydata{
    
    sqlite3_stmt *statement;
    NSMutableArray *pkgDetailArray = nil;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    NSString* databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Tanningloft.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    pkgDetailArray=[[NSMutableArray alloc]init];
    NSString *userName;
    
    if ([filemgr fileExistsAtPath: databasePath ] == YES)
    {
        NSLog(@"In exist path");
        
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            
            NSString *sql = [NSString stringWithFormat:@"SELECT * FROM ActivityLog where activitytype='S'"];
            
            NSLog(@"%@",sql);
            
            if(sqlite3_open([databasePath UTF8String], &appreaderDB) == SQLITE_OK) {
                
                if(sqlite3_prepare_v2(appreaderDB, [sql UTF8String], -1, &statement, nil) == SQLITE_OK){
                    while (sqlite3_step(statement) == SQLITE_ROW) {
                        
                        ActivityLogDBClass *activityObj=[[ActivityLogDBClass alloc]init];
                        //CREATE TABLE IF NOT EXISTS ActivityLog (activityId TEXT,username TEXT , socialtype TEXT, activitytype TEXT,activitytitle TEXT, activitydate TEXT, expiredate TEXT, amount TEXT,point TEXT, status TEXT
                        
                        activityObj.activityId = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                        activityObj.username = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                        activityObj.socialtype = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                        activityObj.activitytype = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                        activityObj.activitytitle = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                        activityObj.activitydate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
                        activityObj.expiredate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
                        activityObj.amount = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)];
                        activityObj.point = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 8)];
                        activityObj.status = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 9)];
                        
                        [pkgDetailArray addObject:activityObj];
                        
                    }
                }
            }
            
            
        }
    }
    return pkgDetailArray;
    
}

-(NSMutableArray *)fetchSocialActivityPendingdata{
    
    sqlite3_stmt *statement;
    NSMutableArray *pkgDetailArray = nil;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    NSString* databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Tanningloft.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    pkgDetailArray=[[NSMutableArray alloc]init];
    NSString *userName;
    
    if ([filemgr fileExistsAtPath: databasePath ] == YES)
    {
        NSLog(@"In exist path");
        
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            
            NSString *sql = [NSString stringWithFormat:@"SELECT * FROM ActivityLog where activitytype='S' AND status='P'"];
            
            NSLog(@"%@",sql);
            
            if(sqlite3_open([databasePath UTF8String], &appreaderDB) == SQLITE_OK) {
                
                if(sqlite3_prepare_v2(appreaderDB, [sql UTF8String], -1, &statement, nil) == SQLITE_OK){
                    while (sqlite3_step(statement) == SQLITE_ROW) {
                        
                        ActivityLogDBClass *activityObj=[[ActivityLogDBClass alloc]init];
                        //CREATE TABLE IF NOT EXISTS ActivityLog (activityId TEXT,username TEXT , socialtype TEXT, activitytype TEXT,activitytitle TEXT, activitydate TEXT, expiredate TEXT, amount TEXT,point TEXT, status TEXT
                        
                        activityObj.activityId = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                        activityObj.username = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                        activityObj.socialtype = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                        activityObj.activitytype = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                        activityObj.activitytitle = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                        activityObj.activitydate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
                        activityObj.expiredate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
                        activityObj.amount = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)];
                        activityObj.point = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 8)];
                        activityObj.status = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 9)];
                        
                        [pkgDetailArray addObject:activityObj];
                        
                    }
                }
            }
            
            
        }
    }
    return pkgDetailArray;
    
}

//Check Network

- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}

-(void)updatePkgStatus:(NSString *)status : (NSString *)activityId{
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    NSString* databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Tanningloft.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    
    if ([filemgr fileExistsAtPath: databasePath ] == YES)
    {
        NSLog(@"In exist path");
        
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            NSLog(@"start JSON Parsing");
            
            NSString *insertStatement = [NSString stringWithFormat:@"UPDATE ActivityLog SET status='%@' where activityId='%@'",status,activityId];
            // DocFullModePath
            char *error;
            NSLog(@"Document %@",insertStatement);
            if (sqlite3_exec(appreaderDB, [insertStatement UTF8String], NULL, NULL, &error) != SQLITE_OK)
            {
                NSLog(@"Failed to update activity status");
                
                // status.text = @"Failed to create table";
                
            }
            else{
                
            }
            //  }
            
            
        }
    }
    
}

-(void)insertSocialPointWeight:(SocialWeightDetailDBClass *)socialObj{
    
    //    NSString *docsDir;
    //    NSArray *dirPaths;
    //    sqlite3 *appreaderDB;
    
    //TODO
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    NSString* databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Tanningloft.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    
    if ([filemgr fileExistsAtPath: databasePath ] == YES)
    {
        NSLog(@"In exist path");
        
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            NSLog(@"start JSON Parsing");
            
            //CREATE TABLE IF NOT EXISTS ActivityLog (activityId TEXT,username TEXT , socialtype TEXT, activitytype TEXT,activitytitle TEXT, activitydate TEXT, expiredate TEXT, amount TEXT,point TEXT, status TEXT
            
            
            NSString *insertStatement ;
            
            if (![self fetchSocialPointWeight].count) {
                insertStatement = [NSString stringWithFormat:@"INSERT INTO SocialPointWeight values ('%@','%@','%@','%@','%@')",socialObj.FacebookPoints,socialObj.TwitterPoints,socialObj.InstagramPoints,socialObj.FourSquarePoints,socialObj.UpdatedDate];
            }
            else{
                insertStatement = [NSString stringWithFormat:@"UPDATE  SocialPointWeight SET FacebookPoints='%@', TwitterPoints='%@', InstagramPoints='%@', FourSquarePoints='%@',UpdatedDate='%@'",socialObj.FacebookPoints,socialObj.TwitterPoints,socialObj.InstagramPoints,socialObj.FourSquarePoints,socialObj.UpdatedDate];
            }
            // DocFullModePath
            char *error;
            NSLog(@"SocialPointWeight %@",insertStatement);
            if (sqlite3_exec(appreaderDB, [insertStatement UTF8String], NULL, NULL, &error) != SQLITE_OK)
            {
                NSLog(@"SocialPointWeight Failed to log %s",error);
                
                // status.text = @"Failed to create table";
            }
            else{
                
                NSLog(@"SocialPointWeight Insertion Done");
            }
        }
    }
}

-(NSMutableArray *)fetchSocialPointWeight{
    
    sqlite3_stmt *statement;
    NSMutableArray *pkgDetailArray = nil;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    NSString* databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Tanningloft.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    pkgDetailArray=[[NSMutableArray alloc]init];
    NSString *userName;
    
    if ([filemgr fileExistsAtPath: databasePath ] == YES)
    {
        NSLog(@"In exist path");
        
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            
            NSString *sql = [NSString stringWithFormat:@"SELECT * FROM SocialPointWeight "];
            
            NSLog(@"%@",sql);
            
            if(sqlite3_open([databasePath UTF8String], &appreaderDB) == SQLITE_OK) {
                
                if(sqlite3_prepare_v2(appreaderDB, [sql UTF8String], -1, &statement, nil) == SQLITE_OK){
                    while (sqlite3_step(statement) == SQLITE_ROW) {
                        
                        SocialWeightDetailDBClass *socialObj=[[SocialWeightDetailDBClass alloc]init];
                        //CREATE TABLE IF NOT EXISTS ActivityLog (activityId TEXT,username TEXT , socialtype TEXT, activitytype TEXT,activitytitle TEXT, activitydate TEXT, expiredate TEXT, amount TEXT,point TEXT, status TEXT
                        
                        socialObj.FacebookPoints = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                        socialObj.TwitterPoints = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                        socialObj.InstagramPoints = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                        socialObj.FourSquarePoints = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                        socialObj.UpdatedDate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                        
                        [pkgDetailArray addObject:socialObj];
                        
                    }
                }
            }
            
            
        }
    }
    return pkgDetailArray;
    
}

-(void)insertSocialShareData:(PackageDetailDBClass *)pkgObj{
    
    //    NSString *docsDir;
    //    NSArray *dirPaths;
    //    sqlite3 *appreaderDB;
    
    //TODO
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    NSString* databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Tanningloft.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    
    if ([filemgr fileExistsAtPath: databasePath ] == YES)
    {
        NSLog(@"In exist path");
        
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            NSLog(@"SocialShareDetails JSON Parsing");
            
            //CREATE TABLE IF NOT EXISTS SocialShareDetails (Id TEXT,Title TEXT , Description TEXT, ImgPath TEXT,AddedDate TEXT, Hyperlink TEXT,imgname TEXT)";
            NSString *insertStatement;
            if (![self fetchSocialDetailForID:pkgObj.pkgID].count) {
               insertStatement = [NSString stringWithFormat:@"INSERT INTO SocialShareDetails values ('%@','%@','%@','%@','%@','%@','%@','%@')",pkgObj.pkgID,[pkgObj.pkgTitle stringByReplacingOccurrencesOfString:@"'" withString:@"''"] ,[pkgObj.pkgDescription stringByReplacingOccurrencesOfString:@"'" withString:@"''"],pkgObj.pkgImagePath,pkgObj.AddedDate,pkgObj.pkgLink,pkgObj.imgName,pkgObj.isActive];
            }
            else{
                insertStatement = [NSString stringWithFormat:@"UPDATE SocialShareDetails SET Title='%@', Description='%@', ImgPath='%@', AddedDate='%@', Hyperlink='%@', imgname='%@', isActive='%@' where Id='%@'",[pkgObj.pkgTitle stringByReplacingOccurrencesOfString:@"'" withString:@"''"] ,[pkgObj.pkgDescription stringByReplacingOccurrencesOfString:@"'" withString:@"''"] ,pkgObj.pkgImagePath,pkgObj.AddedDate,pkgObj.pkgLink,pkgObj.imgName,pkgObj.isActive,pkgObj.pkgID];
            }
            
            // DocFullModePath
            char *error;
            NSLog(@"SocialShareDetails %@",insertStatement);
            if (sqlite3_exec(appreaderDB, [insertStatement UTF8String], NULL, NULL, &error) != SQLITE_OK)
            {
                NSLog(@"SocialShareDetails Failed to log %s",error);
                
                // status.text = @"Failed to create table";
            }
            else{
                if([pkgObj.isActive isEqualToString:@"1"])
                {
                NSLog(@"%@",[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",tanningDelegate.hostString,pkgObj.pkgImagePath]]);
                
                UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",tanningDelegate.hostString,pkgObj.pkgImagePath]]]];
                
                NSLog(@"%f,%f",image.size.width,image.size.height);
                
                // Let's save the file into Document folder.
                // You can also change this to your desktop for testing. (e.g. /Users/kiichi/Desktop/)
                // NSString *deskTopDir = @"/Users/kiichi/Desktop";
                
                NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                
                // If you go to the folder below, you will find those pictures
                NSLog(@"%@",docDir);
                
                NSLog(@"saving png");
               
                    NSString *pngFilePath = [NSString stringWithFormat:@"%@/upload/%@",docDir,pkgObj.imgName];
                    NSData *data1 = [NSData dataWithData:UIImagePNGRepresentation(image)];
                    [data1 writeToFile:pngFilePath atomically:YES];
                }
                
                NSLog(@"saving image done");
                //[imageData writeToFile:imagePath atomically:YES];
            }
        }
    }
}

-(NSMutableArray *)fetchLastUpdateTime{
    
    
    //    NSString *docsDir;
    //    NSArray *dirPaths;
    //    sqlite3 *appreaderDB;
    sqlite3_stmt *statement;
    NSMutableArray *pkgDetailArray = nil;
    
    // Get the documents directory
    
    //tbl_DocumentDetail (DocId TEXT , DocTitle TEXT, DocDesc TEXT, DocName TEXT, DocMode TEXT, DocPath TEXT
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    NSString* databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Tanningloft.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    pkgDetailArray=[[NSMutableArray alloc]init];
    NSString *userName;
    
    if ([filemgr fileExistsAtPath: databasePath ] == YES)
    {
        NSLog(@"In exist path");
        
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            
            NSString *sql;
            
            
            sql = [NSString stringWithFormat:@"SELECT * FROM SyncDetails"];
            
            
            NSLog(@"%@",sql);
            
            //  CREATE TABLE IF NOT EXISTS SocialShareDetails (Id TEXT,Title TEXT , Description TEXT, ImgPath TEXT,AddedDate TEXT, Hyperlink TEXT,imgname TEXT
            
            if(sqlite3_open([databasePath UTF8String], &appreaderDB) == SQLITE_OK) {
                
                if(sqlite3_prepare_v2(appreaderDB, [sql UTF8String], -1, &statement, nil) == SQLITE_OK){
                    while (sqlite3_step(statement) == SQLITE_ROW) {
                        [pkgDetailArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)]];
                      
                    }
                }
            }
            
            
        }
    }
    return pkgDetailArray;
    
}

-(void)UpdateLastSyncTime:(NSString *)time {
    
    //    NSString *docsDir;
    //    NSArray *dirPaths;
    //    sqlite3 *appreaderDB;
    sqlite3_stmt *statement;
    NSMutableArray *pkgDetailArray = nil;
    //TODO
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    NSString* databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Tanningloft.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    
    if ([filemgr fileExistsAtPath: databasePath ] == YES)
    {
        NSLog(@"In exist path");
        
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            NSLog(@"start JSON Parsing");
            
            //            CREATE TABLE IF NOT EXISTS purchasedetail (ArticleId TEXT , ArticleTitle TEXT, Amount TEXT, Date TEXT, ArticleDesc TEXT
            NSString *insertStatement;
            
            if ([self fetchLastUpdateTime].count) {
                insertStatement = [NSString stringWithFormat:@"UPDATE SyncDetails SET lasttime= '%@'",time];
            }
            else{
                insertStatement = [NSString stringWithFormat:@"INSERT INTO SyncDetails values ('%@')",time];
            }
            
           
            // DocFullModePath
            char *error;
            NSLog(@"Document %@",insertStatement);
            if (sqlite3_exec(appreaderDB, [insertStatement UTF8String], NULL, NULL, &error) != SQLITE_OK)
            {
                NSLog(@"purchasedetail Failed to log %s",error);
                
                // status.text = @"Failed to create table";
            }
            else{
                [self hideIndicator];
                NSLog(@"Insertion Done");
                
                CallUserDetails *callObj=[[CallUserDetails alloc]init];
                [callObj callUserDetails];
            }
        }
    }
}

-(void)showIndicator{
    
    if(alert){
        [alert dismissWithClickedButtonIndex:0 animated:YES];
        alert=nil;
    }
    alert = [[UIAlertView alloc] initWithTitle:@"Loading\nPlease Wait..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil] ;
    [alert show];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    // Adjust the indicator so it is up a few pixels from the bottom of the alert
    indicator.center = CGPointMake(140, 80);
    //indicator.frame=CGRectMake(160, 215, indicator.frame.size.width, indicator.frame.size.height);
    [indicator startAnimating];
    [alert addSubview:indicator];
   
}

-(void)hideIndicator{
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}

-(void)showNetworkALert{
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Network Error" message:@"Unable to load details. Your device may be offline due to network issues. Please try again later or check device settings." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
    
    [alert show];
}

-(void)insertMessageDetails:(MessageDBClass *)msgObj{
    
    //TODO
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    NSString* databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Tanningloft.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    
    if ([filemgr fileExistsAtPath: databasePath] == YES)
    {
        NSLog(@"In exist path");
        
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            NSLog(@"SocialShareDetails JSON Parsing");
            
            NSString *insertStatement;
            
            //CREATE TABLE IF NOT EXISTS message (id TEXT, title TEXT, description TEXT, type TEXT, date TEXT, voucher_id TEXT, voucher_amount TEXT, voucher_point TEXT, voucher_expiry TEXT, isActive TEXT
            if([self fetchMessageDetailsForMsgId:msgObj.msgid].count)
            {
                insertStatement = [NSString stringWithFormat:@"UPDATE message SET title='%@', description='%@', type='%@', date='%@', voucher_id='%@', voucher_amount='%@', voucher_point='%@', voucher_expiry='%@', isActive='%@' where id='%@'",[msgObj.title stringByReplacingOccurrencesOfString:@"'" withString:@"''"] ,[msgObj.description stringByReplacingOccurrencesOfString:@"'" withString:@"''"] ,msgObj.type,msgObj.date,msgObj.voucher_id,msgObj.voucher_amount,msgObj.voucher_point,msgObj.voucher_expiry,msgObj.isActive,msgObj.msgid];
            }
            else{
                insertStatement = [NSString stringWithFormat:@"INSERT INTO message values ('%@','%@','%@','%@','%@','%@','%@','%@', '%@', '%@')",msgObj.msgid,[msgObj.title stringByReplacingOccurrencesOfString:@"'" withString:@"''"] ,[msgObj.description stringByReplacingOccurrencesOfString:@"'" withString:@"''"],msgObj.type,msgObj.date,msgObj.voucher_id,msgObj.voucher_amount,msgObj.voucher_point,msgObj.voucher_expiry,msgObj.isActive];
            }
           
            // DocFullModePath
            char *error;
            NSLog(@"message %@",insertStatement);
            if (sqlite3_exec(appreaderDB, [insertStatement UTF8String], NULL, NULL, &error) != SQLITE_OK)
            {
                NSLog(@"message Failed to log %s",error);
                
                // status.text = @"Failed to create table";
            }
            
        }
    }
}

-(NSMutableArray *)fetchMessageDetails{
    
    sqlite3_stmt *statement;
    NSMutableArray *pkgDetailArray = nil;
    
    // Get the documents directory
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    NSString* databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Tanningloft.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    pkgDetailArray=[[NSMutableArray alloc]init];
    NSString *userName;
    
    if ([filemgr fileExistsAtPath: databasePath ] == YES)
    {
        NSLog(@"In exist path");
        
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            
            NSString *sql;
            sql = [NSString stringWithFormat:@"SELECT * FROM message where isActive='1' order by date desc"];
            
            NSLog(@"%@",sql);
            
            if(sqlite3_open([databasePath UTF8String], &appreaderDB) == SQLITE_OK) {
                
                if(sqlite3_prepare_v2(appreaderDB, [sql UTF8String], -1, &statement, nil) == SQLITE_OK){
                    while (sqlite3_step(statement) == SQLITE_ROW) {
                        
                        MessageDBClass *msgObj=[[MessageDBClass alloc]init];
                        
                        msgObj.msgid = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                        msgObj.title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                        msgObj.description = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                        msgObj.type = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                        msgObj.date = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                        msgObj.voucher_id = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
                        msgObj.voucher_amount = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
                        msgObj.voucher_point = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)];
                        msgObj.voucher_expiry = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 8)];
                        msgObj.isActive = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 9)];
                        
                        [pkgDetailArray addObject:msgObj];
                        
                    }
                }
            }
            
            
        }
    }
    return pkgDetailArray;
}


-(NSMutableArray *)fetchMessageDetailsForMsgId:(NSString *)msgId{
    
    sqlite3_stmt *statement;
    NSMutableArray *pkgDetailArray = nil;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    NSString* databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Tanningloft.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    pkgDetailArray=[[NSMutableArray alloc]init];
    NSString *userName;
    
    if ([filemgr fileExistsAtPath: databasePath ] == YES)
    {
        NSLog(@"In exist path");
        
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            
            NSString *sql;
            
            
            sql = [NSString stringWithFormat:@"SELECT * FROM message where id='%@'",msgId];
            
            
            NSLog(@"%@",sql);
            
            if(sqlite3_open([databasePath UTF8String], &appreaderDB) == SQLITE_OK) {
                
                if(sqlite3_prepare_v2(appreaderDB, [sql UTF8String], -1, &statement, nil) == SQLITE_OK){
                    while (sqlite3_step(statement) == SQLITE_ROW) {
                        
                        MessageDBClass *msgObj=[[MessageDBClass alloc]init];
                        
                        msgObj.msgid = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                        msgObj.title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                        msgObj.description = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                        msgObj.type = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                        msgObj.date = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                        msgObj.voucher_id = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
                        msgObj.voucher_amount = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
                        msgObj.voucher_point = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)];
                        msgObj.voucher_expiry = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 8)];
                        msgObj.isActive = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 9)];
                        
                        [pkgDetailArray addObject:msgObj];
                        
                    }
                }
            }
            
            
        }
    }
    return pkgDetailArray;
    
}


-(void)updateMessageStatus:(NSString *)status : (NSString *)activityId{
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    NSString* databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Tanningloft.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    
    if ([filemgr fileExistsAtPath: databasePath ] == YES)
    {
        NSLog(@"In exist path");
        
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            NSLog(@"start JSON Parsing");
            
            NSString *insertStatement = [NSString stringWithFormat:@"UPDATE message SET isActive='%@' where id='%@'",status,activityId];
            // DocFullModePath
            char *error;
            NSLog(@"message %@",insertStatement);
            if (sqlite3_exec(appreaderDB, [insertStatement UTF8String], NULL, NULL, &error) != SQLITE_OK)
            {
                NSLog(@"Failed to update message status");
                
                // status.text = @"Failed to create table";
                
            }
            else{
                
            }
            //  }
            
            
        }
    }
    
}

-(void)updatePurchaseAfterRedeemed:(NSString *)pkgId{

    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    NSString* databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Tanningloft.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    
    if ([filemgr fileExistsAtPath: databasePath ] == YES)
    {
        NSLog(@"In exist path");
        
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            NSLog(@"start JSON Parsing");
            
            //            CREATE TABLE IF NOT EXISTS purchasedetail (ArticleId TEXT , ArticleTitle TEXT, Amount TEXT, Date TEXT, ArticleDesc TEXT
            NSString *insertStatement;
            
            
            insertStatement = [NSString stringWithFormat:@"UPDATE purchasedetail SET ExpireDate='%@', redeemedDate='%@', isRedeemed='1' where ArticleId='%@'",[tanningDelegate.dbClass dateFromString:tanningDelegate.currentServerTime],[tanningDelegate.dbClass dateFromString:tanningDelegate.currentServerTime],pkgId];
           
            
            
            // DocFullModePath
            char *error;
            NSLog(@"Document %@",insertStatement);
            if (sqlite3_exec(appreaderDB, [insertStatement UTF8String], NULL, NULL, &error) != SQLITE_OK)
            {
                NSLog(@"purchasedetail Failed to log %s",error);
                
            }
            else{
                
               NSLog(@"purchasedetail update succesfully");
            }
        }
    }
}

-(void)insertSocialPostData:(SocialPostObj *)socialObj{
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    NSString* databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Tanningloft.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    
    if ([filemgr fileExistsAtPath: databasePath ] == YES)
    {
        NSLog(@"In exist path");
        
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            NSLog(@"SocialPost JSON Parsing");
            
            //CREATE TABLE IF NOT EXISTS SocialShareDetails (Id TEXT,Title TEXT , Description TEXT, ImgPath TEXT,AddedDate TEXT, Hyperlink TEXT,imgname TEXT)";
            NSString *insertStatement;
            if (![self fetchSocialPostDetailForID:socialObj.socialid].count) {
                insertStatement = [NSString stringWithFormat:@"INSERT INTO tbl_socialpost values ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@', '%@', '%@', '%@', '%@', '%@', '%@')",socialObj.socialid,[socialObj.title stringByReplacingOccurrencesOfString:@"'" withString:@"''"],[socialObj.description stringByReplacingOccurrencesOfString:@"'" withString:@"''"] ,socialObj.imgpath,socialObj.addeddate,socialObj.link,socialObj.imgname,socialObj.isactive,socialObj.pointvalue,socialObj.isvalidforcoupon,socialObj.couponcode,socialObj.savingper,socialObj.tags,socialObj.amount,socialObj.type,socialObj.subtype,socialObj.extra,socialObj.colorcode,socialObj.isfeatured,[socialObj.writername stringByReplacingOccurrencesOfString:@"'" withString:@"''"],socialObj.expiredate,socialObj.logoimagename,socialObj.logoimagepath];
            }
            else{
                insertStatement = [NSString stringWithFormat:@"UPDATE tbl_socialpost SET title='%@', description='%@', imgpath='%@', addeddate='%@', link='%@', imgname='%@', isactive='%@', pointvalue='%@', isvalidforcoupon='%@', couponcode='%@', savingper='%@', tags='%@', amount='%@', type='%@', subtype='%@', extra='%@',colorcode='%@', isfeatured='%@', writername='%@', expiredate='%@', logoimagename='%@', logoimagepath='%@' where socialid='%@'",[socialObj.title stringByReplacingOccurrencesOfString:@"'" withString:@"''"] ,[socialObj.description stringByReplacingOccurrencesOfString:@"'" withString:@"''"] ,socialObj.imgpath,socialObj.addeddate,socialObj.link,socialObj.imgname,socialObj.isactive,socialObj.pointvalue,socialObj.isvalidforcoupon,socialObj.couponcode,socialObj.savingper,socialObj.tags,socialObj.amount,socialObj.type,socialObj.subtype,socialObj.extra,socialObj.colorcode,socialObj.isfeatured,[socialObj.writername stringByReplacingOccurrencesOfString:@"'" withString:@"''"],socialObj.expiredate,socialObj.logoimagename,socialObj.logoimagepath,socialObj.socialid];
            }
            
            // DocFullModePath
            char *error;
            NSLog(@"tbl_socialpost %@",insertStatement);
            if (sqlite3_exec(appreaderDB, [insertStatement UTF8String], NULL, NULL, &error) != SQLITE_OK)
            {
                NSLog(@"tbl_socialpost Failed to log %s",error);
                
                // status.text = @"Failed to create table";
            }
            else{
                if([socialObj.isactive isEqualToString:@"1"])
                {
                    NSLog(@"%@",[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",tanningDelegate.hostString,socialObj.imgpath]]);
                    
                    UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",tanningDelegate.hostString,socialObj.imgpath]]]];
                    
                    NSLog(@"%f,%f",image.size.width,image.size.height);
                    
                    // Let's save the file into Document folder.
                    // You can also change this to your desktop for testing. (e.g. /Users/kiichi/Desktop/)
                    // NSString *deskTopDir = @"/Users/kiichi/Desktop";
                    
                    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                    
                    NSLog(@"%@",docDir);
                    
                    NSLog(@"saving png");
                    
                    NSString *pngFilePath = [NSString stringWithFormat:@"%@/upload/%@",docDir,socialObj.imgname];
                    NSData *data1 = [NSData dataWithData:UIImagePNGRepresentation(image)];
                    [data1 writeToFile:pngFilePath atomically:YES];
                    
                    
                    if ([socialObj.subtype isEqualToString:@"coupon"]) {
                        
                        UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",tanningDelegate.hostString,socialObj.logoimagepath]]]];
                        
                        NSLog(@"%f,%f",image.size.width,image.size.height);
                        
                        // Let's save the file into Document folder.
                        // You can also change this to your desktop for testing. (e.g. /Users/kiichi/Desktop/)
                        // NSString *deskTopDir = @"/Users/kiichi/Desktop";
                        
                        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                        
                        NSLog(@"%@",docDir);
                        
                        NSLog(@"saving png");
                        
                        NSString *pngFilePath = [NSString stringWithFormat:@"%@/upload/%@",docDir,socialObj.logoimagename];
                        NSData *data1 = [NSData dataWithData:UIImagePNGRepresentation(image)];
                        [data1 writeToFile:pngFilePath atomically:YES];
                    }
                }
                
                NSLog(@"saving image done");
                //[imageData writeToFile:imagePath atomically:YES];
            }
        }
    }
}

-(NSMutableArray *)fetchSocialPostDetail{
    
    sqlite3_stmt *statement;
    NSMutableArray *socialDetailArray = nil;
    
    // Get the documents directory
    
    //tbl_DocumentDetail (DocId TEXT , DocTitle TEXT, DocDesc TEXT, DocName TEXT, DocMode TEXT, DocPath TEXT
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    NSString* databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Tanningloft.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    socialDetailArray=[[NSMutableArray alloc]init];
    
    if ([filemgr fileExistsAtPath: databasePath ] == YES)
    {
        NSLog(@"In exist path");
        
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            
            NSString *sql;
            
            
            sql = [NSString stringWithFormat:@"SELECT * FROM tbl_socialpost where isactive='1' order by addeddate desc"];
            
            
            NSLog(@"%@",sql);
            
            //  CREATE TABLE IF NOT EXISTS SocialShareDetails (Id TEXT,Title TEXT , Description TEXT, ImgPath TEXT,AddedDate TEXT, Hyperlink TEXT,imgname TEXT
            
            if(sqlite3_open([databasePath UTF8String], &appreaderDB) == SQLITE_OK) {
                
                if(sqlite3_prepare_v2(appreaderDB, [sql UTF8String], -1, &statement, nil) == SQLITE_OK){
                    while (sqlite3_step(statement) == SQLITE_ROW) {
                        
                        SocialPostObj *socialObj=[[SocialPostObj alloc]init];
                        
                        socialObj.socialid=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                        socialObj.title=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                        socialObj.description=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)] ;
                        socialObj.imgpath=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                        socialObj.addeddate=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                        socialObj.link=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
                        socialObj.imgname=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
                        socialObj.isactive=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)];
                        socialObj.pointvalue=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 8)];
                        socialObj.isvalidforcoupon=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 9)];
                        socialObj.couponcode=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 10)];
                        socialObj.savingper=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 11)];
                        socialObj.tags=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 12)];
                        socialObj.amount=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 13)];
                        socialObj.type=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 14)];
                        socialObj.subtype=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 15)];
                        socialObj.extra=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 16)];
                        socialObj.colorcode=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 17)];
                        socialObj.isfeatured=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 18)];
                        socialObj.writername=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 19)];
                        socialObj.expiredate=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 20)];
                        socialObj.logoimagename=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 21)];
                        socialObj.logoimagepath=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 22)];
                        
                        [socialDetailArray addObject:socialObj];
                        
                    }
                }
            }
            
            
        }
    }
    return socialDetailArray;
    
}

-(NSMutableArray *)fetchSocialPostDetailForID:(NSString *)socialId{
    
    sqlite3_stmt *statement;
    NSMutableArray *socialDetailArray = nil;
    
    // Get the documents directory
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    NSString* databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Tanningloft.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    socialDetailArray=[[NSMutableArray alloc]init];
    
    if ([filemgr fileExistsAtPath: databasePath ] == YES)
    {
        NSLog(@"In exist path");
        
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            NSString *sql;
            
            sql = [NSString stringWithFormat:@"SELECT * FROM tbl_socialpost where socialid='%@'",socialId];
            
            NSLog(@"%@",sql);
            
            //  CREATE TABLE IF NOT EXISTS SocialShareDetails (Id TEXT,Title TEXT , Description TEXT, ImgPath TEXT,AddedDate TEXT, Hyperlink TEXT,imgname TEXT
            
            if(sqlite3_open([databasePath UTF8String], &appreaderDB) == SQLITE_OK) {
                
                if(sqlite3_prepare_v2(appreaderDB, [sql UTF8String], -1, &statement, nil) == SQLITE_OK){
                    while (sqlite3_step(statement) == SQLITE_ROW) {
                        
                        SocialPostObj *socialObj=[[SocialPostObj alloc]init];
                        
                        socialObj.socialid=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                        socialObj.title=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                        socialObj.description=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                        socialObj.imgpath=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                        socialObj.addeddate=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                        socialObj.link=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
                        socialObj.imgname=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
                        socialObj.isactive=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)];
                        socialObj.pointvalue=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 8)];
                        socialObj.isvalidforcoupon=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 9)];
                        socialObj.couponcode=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 10)];
                        socialObj.savingper=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 11)];
                        socialObj.tags=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 12)];
                        socialObj.amount=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 13)];
                        socialObj.type=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 14)];
                        socialObj.subtype=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 15)];
                        socialObj.extra=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 16)];
                        
                        socialObj.colorcode=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 17)];
                        socialObj.isfeatured=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 18)];
                        socialObj.writername=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 19)];
                        socialObj.expiredate=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 20)];
                        socialObj.logoimagename=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 21)];
                        socialObj.logoimagepath=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 22)];
                        
                        [socialDetailArray addObject:socialObj];
                        
                    }
                }
            }
            
            
        }
    }
    return socialDetailArray;
    
}

-(void)updateSocialPostStatus:(NSString *)status : (NSString *)pkgID{
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    NSString* databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Tanningloft.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    
    if ([filemgr fileExistsAtPath: databasePath ] == YES)
    {
        NSLog(@"In exist path");
        
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &appreaderDB) == SQLITE_OK)
        {
            NSLog(@"start JSON Parsing");
            
            NSString *insertStatement = [NSString stringWithFormat:@"UPDATE tbl_socialpost SET isactive='%@' where socialid='%@'",status,pkgID];
            // DocFullModePath
            char *error;
            NSLog(@"Document %@",insertStatement);
            if (sqlite3_exec(appreaderDB, [insertStatement UTF8String], NULL, NULL, &error) != SQLITE_OK)
            {
                NSLog(@"Failed to update activity status");
                
            }
            else{
                
            }
            //  }
            
            
        }
    }
    
}

@end
