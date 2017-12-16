//
//  opfStatsTableViewController.h
//  outproform
//

#import <UIKit/UIKit.h>

@interface opfStatsTableViewController : UITableViewController{
    NSMutableArray *stats;
}

@property(nonatomic,retain) NSMutableArray *stats;

-(void)setConfigStatsAll_toDrill:(NSString *)drillId;
@end
