//
//  opfAthlete.h
//  outproform
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface opfAthlete : NSObject{
    NSInteger athleteId;
    NSString *name;
    NSString *college;
    NSString *url;
    NSInteger height;
    NSInteger weight;
    NSInteger year;
    NSInteger wonderlic;
    Boolean obtainedStats;
    sqlite3 *db;
    NSMutableArray *statsArray;
}

@property (nonatomic, assign)NSInteger athleteId;
@property (nonatomic, assign)NSInteger height;
@property (nonatomic, assign)NSInteger weight;
@property (nonatomic, assign)NSInteger year;
@property (nonatomic, assign)NSInteger wonderlic;
@property (nonatomic, retain)NSString *name;
@property (nonatomic, retain)NSString *college;
@property (nonatomic, retain)NSString *url;
@property (nonatomic, assign)Boolean obtainedStats;
@property (nonatomic, retain)NSMutableArray *statsArray;


-(void)getStats;
-(NSMutableArray*) getAthletes;

@end
