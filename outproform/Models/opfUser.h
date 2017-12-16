//
//  opfUser.h
//  outproform
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

#define USERNAME_DEFAULT @"oktara"

@class opfStat;
@class opfDrill;


@interface opfUser : NSObject{
    NSString *username;
    NSString *name;
    NSInteger age;
    NSInteger weight;
    NSInteger height;
    NSInteger profileID;
    Boolean obtainedInfo;
    NSMutableArray *statsArray;
    sqlite3 *db;
    NSInteger registered;
}

@property (nonatomic, assign)NSInteger registered;
@property (nonatomic, assign)NSInteger age;
@property (nonatomic, assign)NSInteger weight;
@property (nonatomic, assign)NSInteger height;
@property (nonatomic, assign)NSInteger profileID;
@property (nonatomic, retain)NSString *name;
@property (nonatomic, retain)NSString *username;
@property (nonatomic, assign)Boolean obtainedInfo;
@property (nonatomic, retain)NSMutableArray *statsArray;


-(void) getProfile;
-(void) updateProfile;
+ (id)sharedUser;
-(void) updateRamStats:(opfStat*)stat;
-(NSMutableArray*) getAllStatsToDrill:(NSString*)drillID;
-(NSMutableArray*) getTopStatsToDrill:(opfDrill*)drillID;
-(BOOL)validateInfo;
@end
