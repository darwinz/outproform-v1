//
//  opfAthlete.m
//  outproform
//

#import "opfAthlete.h"
#import "opfStat.h"
#import "opfDrill.h"
#import "opfDBAccess.h"

@implementation opfAthlete

@synthesize athleteId;
@synthesize name;
@synthesize college;
@synthesize url;
@synthesize height;
@synthesize weight;
@synthesize year;
@synthesize wonderlic;
@synthesize obtainedStats;
@synthesize statsArray;

-(void) getStats{
    if (!obtainedStats) {
        statsArray = [[NSMutableArray alloc] init];
        opfDBAccess * dbControl = [opfDBAccess sharedDbControl];
        sqlite3_stmt *sqlStatement;
        @try {
            [dbControl openDataBaseAsReadOnly];
            sqlStatement = [dbControl prepared_v2_Statement:ALLSCORES_OF_ATHLETE];
            [dbControl appendNSInteger:athleteId toStatement:sqlStatement atPos:1];
            
            while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
                opfStat *stat = [[opfStat alloc] init];
                opfDrill *drill = [[opfDrill alloc] init];
                [drill updateInfo:[NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 0)]];
                stat.drill = drill;
                stat.score = sqlite3_column_double(sqlStatement, 1);
                [stat setSelectedScoreType:sqlite3_column_int(sqlStatement, 2)];
                [statsArray addObject:stat];
            }
            self.obtainedStats = true;
        }
        @catch (NSException *exception) {
            NSLog(@"An exception ocurred: %@", [exception reason]);
        }
        @finally {
            sqlite3_finalize(sqlStatement);
            [dbControl closeDataBase];
            return ;
        }
    }
}


-(NSMutableArray*) getAthletes{
    NSMutableArray *athleteArray = [[NSMutableArray alloc] init];
    opfDBAccess *dbControl = [opfDBAccess sharedDbControl];
    sqlite3_stmt *sqlStatement;
    @try {
        [dbControl openDataBaseAsReadOnly];
        sqlStatement = [dbControl prepared_v2_Statement:ALL_ATHLETES];
        
        while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
            opfAthlete *athlete = [[opfAthlete alloc] init];
            athlete.athleteId = sqlite3_column_int(sqlStatement, 0);
            athlete.name = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 1)];
            athlete.college = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 2)];
            athlete.url = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 3)];
            athlete.height = sqlite3_column_int(sqlStatement, 4);
            athlete.weight = sqlite3_column_int(sqlStatement, 5);
            athlete.year = sqlite3_column_int(sqlStatement, 6);
            athlete.wonderlic = sqlite3_column_int(sqlStatement, 7);
            [athleteArray addObject:athlete];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"An exception ocurred: %@", [exception reason]);
    }
    @finally {
        sqlite3_finalize(sqlStatement);
        [dbControl closeDataBase];
        return athleteArray;
    }
}
@end
