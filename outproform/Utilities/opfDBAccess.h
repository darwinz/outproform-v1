//
//  opfDBAccess.h
//  outproform
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

#define ALLSCORE_OF_ALLDRILLS_OF_USER @"SELECT td.name, tpsl.score, tpsl.FK_OP_ScoreType, tpsl.datetime FROM OP_User AS tu INNER JOIN OP_Profile tp ON tu.id=tp.FK_OP_User INNER JOIN OP_ProfileStatsLog tpsl ON tp.id=tpsl.FK_OP_Profile INNER JOIN OP_Drill td ON tpsl.FK_OP_Drill=td.id WHERE tu.username=?"

#define ALLSCORE_OF_ADRILL_OF_USER @"SELECT td.name, tpsl.score, tpsl.FK_OP_ScoreType, tpsl.datetime FROM OP_User AS tu INNER JOIN OP_Profile tp ON tu.id=tp.FK_OP_User INNER JOIN OP_ProfileStatsLog tpsl ON tp.id=tpsl.FK_OP_Profile INNER JOIN OP_Drill td ON tpsl.FK_OP_Drill=td.id WHERE tu.username=? AND td.id=?"

#define UPDATE_PROFILE @"UPDATE OP_Profile SET name=?, age=?, height_Ins=?, weight_Lbs=?, registered=? WHERE id IN (SELECT aux.id FROM OP_User AS tu INNER JOIN OP_Profile aux ON tu.id=aux.FK_OP_User WHERE tu.username=?)"

#define STATS_PROFILE @"SELECT td.name, max(tpsl.score), tpsl.FK_OP_ScoreType, tpsl.datetime FROM OP_User AS tu INNER JOIN OP_Profile tp ON tu.id=tp.FK_OP_User INNER JOIN OP_ProfileStatsLog tpsl ON tp.id=tpsl.FK_OP_Profile INNER JOIN OP_Drill td ON tpsl.FK_OP_Drill=td.id WHERE tu.username=? GROUP BY td.name"

#define BASIC_PROFILE @"SELECT tp.name, tp.age, tp.height_Ins, tp.weight_Lbs, tp.id, tp.registered FROM OP_User AS tu INNER JOIN OP_Profile tp ON tu.id=tp.FK_OP_User WHERE tu.username=?"

#define ALLSCORES_OF_ATHLETE @"SELECT td.name, tas.score, FK_OP_ScoreType FROM OP_Athlete AS ta INNER JOIN OP_AthletesStats tas ON ta.id=FK_OP_Athlete INNER JOIN OP_Drill td ON td.id=FK_OP_Drill WHERE ta.id=?"

#define DRILL_DESCRIPTION @"SELECT td.id, td.name, td.description, tdst.FK_OP_ScoreType, td.[order] FROM OP_Drill AS td INNER JOIN OP_DrillScoreType tdst ON tdst.FK_OP_Drill=td.id WHERE td.name=?"

#define ALL_DRILLS @"SELECT id, name, description FROM OP_Drill"

#define ALL_ATHLETES @"SELECT id, name, college, url, height_Ins, weight_Lbs, year, wonderlic FROM OP_Athlete ORDER BY name ASC"

#define ALL_SCORETYPES @"SELECT tst.id, tst.name, tst.code FROM OP_ScoreType AS tst"

#define THAN_TOP_3 @"SELECT ta.name, tas.score FROM OP_AthletesStats AS tas INNER JOIN OP_Athlete ta ON ta.id = tas.FK_OP_Athlete WHERE FK_OP_Drill = %d AND score %@ %f ORDER BY score %@ LIMIT 0,3"

#define CLOSEST_BIG @"SELECT ta.name, tas.score FROM OP_AthletesStats AS tas INNER JOIN OP_Athlete ta ON ta.id = tas.FK_OP_Athlete WHERE FK_OP_Drill = %d AND score %@ %f ORDER BY score %@ LIMIT 0,1"

#define INSERT_SCORE_LOG @"INSERT INTO OP_ProfileStatsLog (FK_OP_Profile, FK_OP_Drill, FK_OP_ScoreType, score, datetime) VALUES (?, ?, ?, ?, ?)"

#define RANGESCORES_OF_ADRILL_OF_USER @"SELECT td.name, tpsl.score, tpsl.FK_OP_ScoreType, tpsl.datetime FROM OP_Profile tp INNER JOIN OP_ProfileStatsLog tpsl ON tp.id=tpsl.FK_OP_Profile INNER JOIN OP_Drill td ON tpsl.FK_OP_Drill=td.id WHERE tp.id = %d AND td.id = %d ORDER BY tpsl.score %@ LIMIT %d, %d"
//TOP USING ADITIONAL TABLE "SELECT td.name, tpsl.score, tpsl.FK_OP_ScoreType, tpsl.datetime FROM (SELECT * FROM OP_TopProfileStats AS ttps WHERE ttps.FK_OP_Profile = ?) AS ttus INNER JOIN OP_ProfileStatsLog tpsl ON ttus.FK_OP_ProfileStatsLog = tpsl.id INNER JOIN OP_Drill td ON tpsl.FK_OP_Drill=td.id WHERE td.id=?"



#define FAILED_UPDATE_ERROR @"ERROR: Failed to update priority with message '%s'."

#define FAILED_INSERT_ERROR @"ERROR: Failed to insert priority with message '%s'."

#define DATABASE_FILE_NAME @"outproform_v2.sqlite"


@interface opfDBAccess : NSObject{
    sqlite3 *database;
}


@property (nonatomic, retain)NSString *EditablePathDB;


-(BOOL)openDataBaseAsReadOnly;
-(BOOL)openDataBaseAsReadWrite;
-(void)closeDataBase;
-(sqlite3_stmt*)prepared_v2_Statement:(NSString*)query;
-(void)appendNSString:(NSString*)text toStatement:(sqlite3_stmt*)sqlStatement atPos:(NSInteger)pos;
-(void)appendNSInteger:(NSInteger)integer toStatement:(sqlite3_stmt*)sqlStatement atPos:(NSInteger)pos;
-(void)appendDouble:(double)value toStatement:(sqlite3_stmt*)sqlStatement atPos:(NSInteger)pos;
-(void)reportError:(NSString*)description;
+ (id)sharedDbControl;

@end
