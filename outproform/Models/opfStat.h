//
//  opfStat.h
//  outproform
//

#import <Foundation/Foundation.h>

#import <sqlite3.h>

@class opfUser;
@class opfDrill;


@interface opfStat : NSObject
{
    opfDrill *drill;
    double score;
    NSInteger selectedScoreType;
    NSString *datetime;
    sqlite3 *db;
    opfUser *user;
}

@property (nonatomic, retain)opfDrill *drill;
@property (nonatomic, assign)double score;
@property (nonatomic, assign)NSInteger selectedScoreType;
@property (nonatomic, retain)NSMutableArray *scoreTypes;
@property (nonatomic, retain)NSString *datetime;
@property (nonatomic, retain)opfUser *user;

-(NSString*) scoreTypeCode;
-(void) setSelectedScoreType: (NSInteger) typeID;
-(void) saveToDB;
-(BOOL) isBetterScoreThan: (opfStat*) otherStat;
-(NSMutableArray*) betterThanTop3;
-(NSMutableArray*) worseThanTop3;
-(NSString*) closestBig;

@end
