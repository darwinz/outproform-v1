//
//  opfDrill.m
//  outproform
//

#import "opfDrill.h"
#import "opfDBAccess.h"


@implementation opfDrill

@synthesize drillId;
@synthesize name;
@synthesize description;
@synthesize defaultScoreType;
@synthesize betterOrderSQL;
@synthesize betterSymbol;
@synthesize worseOrderSQL;
@synthesize worseSymbol;

-(NSString*)obtainDrillType:(int)code{
    NSString * res;
    switch (code) {
        case VERTICAL_DRILL:
            res=@"Vertical";
            break;
            
        case BROAD_DRILL:
            res=@"Broad Jump";
            break;
            
        case BENCH_DRILL:
            res=@"Bench Press";
            break;
            
        case SHUTTLE_DRILL:
            res=@"Shuttle Run";
            break;
            
        case CONE3_DRILL:
            res=@"3-Cone Drill";
            break;
            
        case YARD40_DRILL:
            res=@"40-yard Dash";
            break;
            
        default:
            res=@"NOT FOUNDED";
            break;
    }
    return res;
}

-(void) establishSymbols: (NSString*)order{
    if ([order isEqualToString:@"ASC"]) {
        betterSymbol = @"<";
        betterOrderSQL = @"DESC";
        worseSymbol = @">";
        worseOrderSQL = @"ASC";
    }else if ([order isEqualToString:@"DESC"]) {
        betterSymbol = @">";
        betterOrderSQL = @"ASC";
        worseSymbol = @"<";
        worseOrderSQL = @"DESC";
    }
    
}

-(void) updateInfo:(NSString*)type{
    opfDBAccess * dbControl = [opfDBAccess sharedDbControl];
    sqlite3_stmt *sqlStatement;
    @try {
        [dbControl openDataBaseAsReadOnly];
        sqlStatement = [dbControl prepared_v2_Statement:DRILL_DESCRIPTION];
        [dbControl appendNSString:type toStatement:sqlStatement atPos:1];
        
        if (sqlite3_step(sqlStatement)==SQLITE_ROW) {
            drillId = sqlite3_column_int(sqlStatement, 0);
            name = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 1)];
            description = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 2)];
            defaultScoreType = sqlite3_column_int(sqlStatement, 3);
            NSString *order = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 4)];
            
            [self establishSymbols:order];
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
