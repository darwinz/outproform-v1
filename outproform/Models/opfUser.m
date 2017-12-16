//
//  opfUser.m
//  outproform
//

#import "opfUser.h"
#import "opfDrill.h"
#import "opfStat.h"
#import "opfDBAccess.h"


#define ALL_DRILLS_STRING @"NULL"

@implementation opfUser

@synthesize age;
@synthesize obtainedInfo;
@synthesize weight;
@synthesize height;
@synthesize name;
@synthesize username;
@synthesize statsArray;
@synthesize profileID;
@synthesize registered;

#pragma mark Singleton Methods

+ (id)sharedUser {
    static opfUser *sharedMyUser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyUser = [[self alloc] init];
    });
    return sharedMyUser;
}

- (id)init {
    if (self = [super init]) {
        [self getProfile];
    }
    return self;
}


-(void) updateRamStats:(opfStat*)stat{
    int index = 0;
    BOOL flag = TRUE;
    opfStat *curStat;
    do {
        curStat = [statsArray objectAtIndex:index];
        if ([stat isBetterScoreThan:curStat]) {
            [statsArray removeObjectAtIndex:index];
            [statsArray insertObject:stat atIndex:index];
            flag = FALSE;
        }
        index=index+1;
    } while (flag && (index < [statsArray count]));
}

-(BOOL)validateInfo{
    bool isValid = true;
    if ([name isEqualToString:@""]) {
        isValid = false;
    }
    if (age==0) {
        isValid = false;
    }
    return isValid;
}





//****************** SQL METHODS  ****************//



-(void) getProfile{
    self.username = USERNAME_DEFAULT;
    
    if (!obtainedInfo) {
        statsArray = [[NSMutableArray alloc] init];
        opfDBAccess *dbControl = [opfDBAccess sharedDbControl];
        @try {
            [dbControl openDataBaseAsReadOnly];
            [self getBasicProfileSQL:dbControl];
            [self getStatProfile:dbControl];
            
            self.obtainedInfo = true;
        }
        @catch (NSException *exception) {
            NSLog(@"An exception ocurred: %@", [exception reason]);
        }
        @finally {
            [dbControl closeDataBase];
            return ;
        }
    }
}

-(void)getBasicProfileSQL:(opfDBAccess*)dbControl{
    sqlite3_stmt *sqlStatement;
    sqlStatement = [dbControl prepared_v2_Statement:BASIC_PROFILE];
    [dbControl appendNSString:username toStatement:sqlStatement atPos:1];
    
    if (sqlite3_step(sqlStatement)==SQLITE_ROW) {
        self.name = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 0)];
        self.age = sqlite3_column_int(sqlStatement, 1);
        self.height = sqlite3_column_int(sqlStatement, 2);
        self.weight = sqlite3_column_int(sqlStatement, 3);
        self.profileID = sqlite3_column_int(sqlStatement, 4);
        self.registered = sqlite3_column_int(sqlStatement, 5);
    }
    sqlite3_finalize(sqlStatement);
}

-(void)getStatProfile:(opfDBAccess*)dbControl{
    sqlite3_stmt *sqlStatement;
    sqlStatement = [dbControl prepared_v2_Statement:STATS_PROFILE];
    [dbControl appendNSString:username toStatement:sqlStatement atPos:1];
    
    while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
        opfDrill *drill = [[opfDrill alloc] init];
        [drill updateInfo:[NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 0)]];
        opfStat *stat = [[opfStat alloc] init];
        stat.drill = drill;
        stat.score = sqlite3_column_double(sqlStatement, 1);
        [stat setSelectedScoreType:sqlite3_column_int(sqlStatement, 2)];
        stat.datetime =[NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 3)];
        [statsArray addObject:stat];
    }
    sqlite3_finalize(sqlStatement);
}

-(NSMutableArray*) getAllStatsToDrill:(NSString*)drillID{
    NSMutableArray* allStats = [[NSMutableArray alloc] init];
    opfDBAccess *dbControl = [opfDBAccess sharedDbControl];
    sqlite3_stmt *sqlStatement;
    @try {
        [dbControl openDataBaseAsReadOnly];
        if ([drillID isEqualToString:ALL_DRILLS_STRING]){
            sqlStatement = [dbControl prepared_v2_Statement:ALLSCORE_OF_ALLDRILLS_OF_USER];
            [dbControl appendNSString:username toStatement:sqlStatement atPos:1];
        }else{
            sqlStatement = [dbControl prepared_v2_Statement:ALLSCORE_OF_ADRILL_OF_USER];
            [dbControl appendNSString:username toStatement:sqlStatement atPos:1];
            [dbControl appendNSString:drillID toStatement:sqlStatement atPos:2];
        }
        while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
            opfDrill *drill = [[opfDrill alloc] init];
            [drill updateInfo:[NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 0)]];
            opfStat *stat = [[opfStat alloc] init];
            stat.drill = drill;
            stat.score = sqlite3_column_double(sqlStatement, 1);
            [stat setSelectedScoreType:sqlite3_column_int(sqlStatement, 2)];
            stat.datetime =[NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 3)];
            [allStats addObject:stat];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"An exception ocurred: %@", [exception reason]);
    }
    @finally {
        sqlite3_finalize(sqlStatement);
        [dbControl closeDataBase];
        return allStats;
    }
}

-(NSMutableArray*) getTopStatsToDrill:(opfDrill*) drill{
    NSMutableArray* allStats = [[NSMutableArray alloc] init];
    opfDBAccess *dbControl = [opfDBAccess sharedDbControl];
    int rangeStart = 0;
    int rangeEnd = 3;
    sqlite3_stmt *sqlStatement;
    @try {
        [dbControl openDataBaseAsReadOnly];
        if (drill == nil){
            sqlStatement = [dbControl prepared_v2_Statement:ALLSCORE_OF_ALLDRILLS_OF_USER];         //JUST IN CASE OF FILTER
            [dbControl appendNSString:username toStatement:sqlStatement atPos:1];
        }else{
            /*sqlStatement = [dbControl prepared_v2_Statement:RANGESCORES_OF_ADRILL_OF_USER];
             [dbControl appendNSInteger:profileID toStatement:sqlStatement atPos:1];
             [dbControl appendNSInteger:drill.drillId toStatement:sqlStatement atPos:2];
             [dbControl appendNSString:drill.betterOrderSQL toStatement:sqlStatement atPos:3];
             [dbControl appendNSInteger:rangeStart toStatement:sqlStatement atPos:4];
             [dbControl appendNSInteger:rangeEnd toStatement:sqlStatement atPos:5];*/
            sqlStatement = [dbControl prepared_v2_Statement:[NSString stringWithFormat:RANGESCORES_OF_ADRILL_OF_USER,
                                                             profileID,
                                                             drill.drillId,
                                                             drill.worseOrderSQL,
                                                             rangeStart,
                                                             rangeEnd]];
        }
        while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
            opfDrill *drill = [[opfDrill alloc] init];
            [drill updateInfo:[NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 0)]];
            opfStat *stat = [[opfStat alloc] init];
            stat.drill = drill;
            stat.score = sqlite3_column_double(sqlStatement, 1);
            [stat setSelectedScoreType:sqlite3_column_int(sqlStatement, 2)];
            stat.datetime =[NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 3)];
            [allStats addObject:stat];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"An exception ocurred: %@", [exception reason]);
    }
    @finally {
        sqlite3_finalize(sqlStatement);
        [dbControl closeDataBase];
        return allStats;
    }
}

-(void) updateProfile{
    opfDBAccess *dbControl = [opfDBAccess sharedDbControl];
    //statsArray = [[NSMutableArray alloc] init];
    sqlite3_stmt *sqlStatement;
    @try {
        [dbControl openDataBaseAsReadWrite];
        sqlStatement = [dbControl prepared_v2_Statement:UPDATE_PROFILE];
        [dbControl appendNSString:name toStatement:sqlStatement atPos:1];
        [dbControl appendNSInteger:age toStatement:sqlStatement atPos:2];
        [dbControl appendNSInteger:height toStatement:sqlStatement atPos:3];
        [dbControl appendNSInteger:weight toStatement:sqlStatement atPos:4];
        [dbControl appendNSInteger:registered toStatement:sqlStatement atPos:5];
        [dbControl appendNSString:username toStatement:sqlStatement atPos:6];
        int success = sqlite3_step(sqlStatement);
        
        if (success != SQLITE_DONE) {
            [dbControl reportError:FAILED_UPDATE_ERROR];
        }
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


@end
