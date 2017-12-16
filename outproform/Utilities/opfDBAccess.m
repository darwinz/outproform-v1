//
//  opfDBAccess.m
//  outproform
//

#import "opfDBAccess.h"

@implementation opfDBAccess

@synthesize EditablePathDB;


#pragma mark Singleton Methods

+ (id)sharedDbControl {
    static opfDBAccess *sharedDbControl = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDbControl = [[self alloc] init];
    });
    return sharedDbControl;
}

- (id)init {
    if (self = [super init]) {
        [self createEditableCopyOfDatabaseIfNeeded];
    }
    return self;
}

-(void) createEditableCopyOfDatabaseIfNeeded{
    //Test for existence
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:DATABASE_FILE_NAME];
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (success) {
         NSLog(@"already exist db");
         EditablePathDB = writableDBPath;
         return;
    }
    //The writable DB doesn't exist, so lets create it
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DATABASE_FILE_NAME];
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    
    EditablePathDB = writableDBPath; //defaultDBPath; //
    
    if (!success) {
        NSAssert1(0, @"Failed to create writable dataase file with message '%@'.", [error localizedDescription]);
    }
}

-(BOOL)openDataBaseAsReadOnly{
    if (sqlite3_open_v2([EditablePathDB UTF8String], &database, SQLITE_OPEN_READONLY, NULL) != SQLITE_OK) {
        NSAssert(0, @"Failed to open database");
        return NO;
    }
    return YES;
}
-(BOOL)openDataBaseAsReadWrite{
    if (sqlite3_open_v2([EditablePathDB UTF8String], &database, SQLITE_OPEN_READWRITE, NULL) != SQLITE_OK) {
        NSAssert(0, @"Failed to open database");
        return NO;
    }
    return YES;
}

-(sqlite3_stmt*)prepared_v2_Statement:(NSString*)query{
    sqlite3_stmt *sqlStatement=nil;
    if (sqlite3_prepare_v2(database, [query UTF8String], -1, &sqlStatement, NULL) != SQLITE_OK) {
        NSLog(@"%s Prepare failure '%s' (%1d)", __FUNCTION__, sqlite3_errmsg(database), sqlite3_errcode(database));
        return nil;
    }
    return sqlStatement;
}

-(void)appendNSString:(NSString*)text toStatement:(sqlite3_stmt*)sqlStatement atPos:(NSInteger)pos{
    sqlite3_bind_text(sqlStatement, pos, [text UTF8String], -1, SQLITE_TRANSIENT);
    
}

-(void)appendNSInteger:(NSInteger)integer toStatement:(sqlite3_stmt*)sqlStatement atPos:(NSInteger)pos{
    sqlite3_bind_int(sqlStatement, pos, integer);
    
}

-(void)appendDouble:(double)value toStatement:(sqlite3_stmt*)sqlStatement atPos:(NSInteger)pos{
    sqlite3_bind_double(sqlStatement, pos, value);
    
}

-(void)reportError:(NSString*)description{
    NSAssert1(0, description, sqlite3_errmsg(database));
}

-(void)closeDataBase{
    sqlite3_close(database);
}

@end
