//
//  opfDrill.h
//  outproform
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>



#define VERTICAL_DRILL 1
#define BROAD_DRILL 2
#define BENCH_DRILL 3
#define SHUTTLE_DRILL 4
#define CONE3_DRILL 5
#define YARD40_DRILL 6



@interface opfDrill : NSObject{
    NSInteger drillId;
    NSInteger defaultScoreType;
    NSString *name;
    NSString *description;
    sqlite3 *db;
}

@property (nonatomic, assign)NSInteger drillId;
@property (nonatomic, assign)NSInteger defaultScoreType;
@property (nonatomic, retain)NSString *name;
@property (nonatomic, retain)NSString *description;
@property (nonatomic, retain)NSString *betterSymbol;
@property (nonatomic, retain)NSString *betterOrderSQL;
@property (nonatomic, retain)NSString *worseOrderSQL;
@property (nonatomic, retain)NSString *worseSymbol;

-(NSString*)obtainDrillType:(int)code;
-(void) updateInfo:(NSString*)code;
@end
