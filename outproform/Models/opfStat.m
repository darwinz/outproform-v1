//
//  opfStat.m
//  outproform
//

#import "opfStat.h"
#import "opfScoreType.h"
#import "opfUser.h"
#import "opfDrill.h"
#import "opfDBAccess.h"

@implementation opfStat

@synthesize drill;
@synthesize score;
@synthesize scoreTypes;
@synthesize selectedScoreType;
@synthesize user;
@synthesize datetime;



- (id)init {
    self = [super init];
    if (self) {
        [self loadScoreTypes];
        //user = [opfUser sharedUser];
        //Init methods
    }
    return self;
}

-(void) loadScoreTypes{
    scoreTypes = [[NSMutableArray alloc]init];
    [self getScoreTypes];
}

-(void) setSelectedScoreType: (NSInteger) typeID{
    int index = 0;
    BOOL flag = TRUE;
    opfScoreType *scType;
    do {
        scType = [scoreTypes objectAtIndex:index];
        if (scType.stId==typeID) {
            selectedScoreType = index;
            flag = FALSE;
        }
        index=index+1;
    } while (flag && (index < [scoreTypes count]));
}

-(NSString*) scoreTypeCode{
    NSString * code;
    opfScoreType *scType;
    scType = [scoreTypes objectAtIndex:selectedScoreType];
    code = scType.code;
    return code;
}

-(NSInteger) scoreTypeID{
    NSInteger stID;
    opfScoreType *scType;
    scType = [scoreTypes objectAtIndex:selectedScoreType];
    stID = scType.stId;
    return stID;
}

-(NSString*) nowDatetime{
    NSLocale *POSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setLocale:POSIXLocale];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString=[dateFormat stringFromDate:[NSDate date]];
    return dateString;
}

-(BOOL) isBetterScoreThan: (opfStat*) otherStat{
    // IF SCORE TYPE COULD CHANGE, THE COMPARISSON SHOULD CONVERT TO UNITS
    BOOL answer = FALSE;
    if ([self.drill.name isEqual:otherStat.drill.name]) {
        if ([self.drill.name  isEqual:@"Vertical"]) {
            if (self.score > otherStat.score) {
                answer = TRUE;
            }
        }else if ([self.drill.name  isEqual:@"Broad Jump"]){
            if (self.score > otherStat.score) {
                answer = TRUE;
            }
        }else if ([self.drill.name  isEqual:@"Bench Press"]){
            if (self.score > otherStat.score) {
                answer = TRUE;
            }
        }else if ([self.drill.name  isEqual:@"Shuttle Run"]){
            if (self.score < otherStat.score) {
                answer = TRUE;
            }
        }else if ([self.drill.name  isEqual:@"3-Cone Drill"]){
            if (self.score < otherStat.score) {
                answer = TRUE;
            }
        }else if ([self.drill.name  isEqual:@"40-yard Dash"]){
            if (self.score < otherStat.score) {
                answer = TRUE;
            }
        }else {
            if (self.score < otherStat.score) {
                answer = TRUE;
            }
        }
    }
    return answer;
}







-(void) getScoreTypes{
    opfDBAccess *dbControl = [opfDBAccess sharedDbControl];
    sqlite3_stmt *sqlStatement;
    @try {
        [dbControl openDataBaseAsReadOnly];
        sqlStatement = [dbControl prepared_v2_Statement:ALL_SCORETYPES];
        
        while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
            opfScoreType *scType = [[opfScoreType alloc] init];
            scType.stId = sqlite3_column_int(sqlStatement, 0);
            scType.name = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 1)];
            scType.code = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 2)];
            [scoreTypes addObject:scType];
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

-(NSMutableArray*) betterThanTop3{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    opfDBAccess *dbControl = [opfDBAccess sharedDbControl];
    sqlite3_stmt *sqlStatement;
    @try {
        [dbControl openDataBaseAsReadOnly];
        /*sqlStatement = [dbControl prepared_v2_Statement:THAN_TOP_3];
         [dbControl appendNSInteger:drill.drillId toStatement:sqlStatement atPos:1];
         [dbControl appendNSString:[drill betterSymbol] toStatement:sqlStatement atPos:2];
         [dbControl appendDouble:score toStatement:sqlStatement atPos:3];
         [dbControl appendNSString:[drill betterOrderSQL] toStatement:sqlStatement atPos:4];*/
        sqlStatement = [dbControl prepared_v2_Statement:[NSString stringWithFormat:THAN_TOP_3,
                                                         drill.drillId,
                                                         [drill betterSymbol],
                                                         score,
                                                         [drill betterOrderSQL]]];
        
        NSInteger index = 0;
        while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
            index++;
            NSString *nameSQL = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 0)];
            double scoreSQL = sqlite3_column_double(sqlStatement, 1);
            NSString *objectResult = [NSString stringWithFormat:@"%@ \t\t %f", nameSQL, scoreSQL];
            [result addObject:objectResult];
        }
        while (index < 3) {
            index++;
            [result addObject:@"..."];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"An exception ocurred: %@", [exception reason]);
    }
    @finally {
        sqlite3_finalize(sqlStatement);
        [dbControl closeDataBase];
        return result;
    }
}

-(NSMutableArray*) worseThanTop3{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    opfDBAccess *dbControl = [opfDBAccess sharedDbControl];
    sqlite3_stmt *sqlStatement;
    @try {
        [dbControl openDataBaseAsReadOnly];
        /*sqlStatement = [dbControl prepared_v2_Statement:THAN_TOP_3];
         [dbControl appendNSInteger:drill.drillId toStatement:sqlStatement atPos:1];
         [dbControl appendNSString:[drill worseSymbol] toStatement:sqlStatement atPos:2];
         [dbControl appendDouble:score toStatement:sqlStatement atPos:3];
         [dbControl appendNSString:[drill worseOrderSQL] toStatement:sqlStatement atPos:4];*/
        sqlStatement = [dbControl prepared_v2_Statement:[NSString stringWithFormat:THAN_TOP_3,
                                                         drill.drillId,
                                                         [drill worseSymbol],
                                                         score,
                                                         [drill worseOrderSQL]]];
        
        NSInteger index = 0;
        while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
            index++;
            NSString *nameSQL = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 0)];
            double scoreSQL = sqlite3_column_double(sqlStatement, 1);
            NSString *objectResult = [NSString stringWithFormat:@"%@ \t\t %f", nameSQL, scoreSQL];
            [result addObject:objectResult];
        }
        while (index < 3) {
            index++;
            [result addObject:@"..."];
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"An exception ocurred: %@", [exception reason]);
    }
    @finally {
        sqlite3_finalize(sqlStatement);
        [dbControl closeDataBase];
        return result;
    }
}

-(NSString*) closestBig{
    NSString *result = [[NSString alloc] init];
    opfDBAccess *dbControl = [opfDBAccess sharedDbControl];
    result = @"...";
    sqlite3_stmt *sqlStatement;
    @try {
        [dbControl openDataBaseAsReadOnly];
        /*sqlStatement = [dbControl prepared_v2_Statement:CLOSEST_BIG];
         [dbControl appendNSInteger:drill.drillId toStatement:sqlStatement atPos:1];
         [dbControl appendNSString:[drill betterSymbol] toStatement:sqlStatement atPos:2];
         [dbControl appendDouble:score toStatement:sqlStatement atPos:3];
         [dbControl appendNSString:[drill betterOrderSQL] toStatement:sqlStatement atPos:4];*/
        sqlStatement = [dbControl prepared_v2_Statement:[NSString stringWithFormat:CLOSEST_BIG,
                                                         drill.drillId,
                                                         [drill worseSymbol],
                                                         score,
                                                         [drill worseOrderSQL]]];
        
        if (sqlite3_step(sqlStatement)==SQLITE_ROW) {
            NSString *nameSQL = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 0)];
            double scoreSQL = sqlite3_column_double(sqlStatement, 1);
            result = [NSString stringWithFormat:@"%@ \t\t %f", nameSQL, scoreSQL];
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"An exception ocurred: %@", [exception reason]);
    }
    @finally {
        sqlite3_finalize(sqlStatement);
        [dbControl closeDataBase];
        return result;
    }
}

-(void) saveToDB{
    user = [opfUser sharedUser]; //FIND A WAY TO INITIALIZE IT EARLIER, MAYBE WITH CONSTANTS
    opfDBAccess *dbControl = [opfDBAccess sharedDbControl];
    sqlite3_stmt *sqlStatement;
    @try {
        //NSLog(@"Saving the new record");
        [dbControl openDataBaseAsReadWrite];
        sqlStatement = [dbControl prepared_v2_Statement:INSERT_SCORE_LOG];
        [dbControl appendNSInteger:user.profileID toStatement:sqlStatement atPos:1];
        [dbControl appendNSInteger:drill.drillId toStatement:sqlStatement atPos:2];
        [dbControl appendNSInteger:[self scoreTypeID] toStatement:sqlStatement atPos:3];
        [dbControl appendDouble:score toStatement:sqlStatement atPos:4];
        [dbControl appendNSString:[self nowDatetime] toStatement:sqlStatement atPos:5];
        
        int step = sqlite3_step(sqlStatement);
        if (step != SQLITE_DONE) {
            //Log error
            [dbControl reportError:FAILED_INSERT_ERROR];
        }
        //NSLog(@"supossed to didnt failed");
        
    }
    @catch (NSException *exception) {
        NSLog(@"An exception ocurred: %@", [exception reason]);
    }
    @finally {
        //NSLog(@"closing everyting");
        sqlite3_finalize(sqlStatement);
        [dbControl closeDataBase];
        [user updateRamStats:self];
        return ;
    }
}



@end
