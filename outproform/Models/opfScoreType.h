//
//  opfScoreType.h
//  outproform
//

#import <Foundation/Foundation.h>

@interface opfScoreType : NSObject
{
    NSString *name;
    NSInteger stId;
    NSString *code;
}

@property (nonatomic, assign)NSInteger stId;
@property (nonatomic, retain)NSString *name;
@property (nonatomic, retain)NSString *code;

@end
