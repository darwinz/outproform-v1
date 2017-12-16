//
//  opfAthleteDetailViewController.h
//  outproform
//

#import <UIKit/UIKit.h>
#import "opfAthlete.h"

@interface opfAthleteDetailViewController : UIViewController


//@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) opfAthlete *detailItem;


@property (weak, nonatomic) IBOutlet UILabel *athleteWonderlic;
@property (weak, nonatomic) IBOutlet UILabel *athleteName;
@property (weak, nonatomic) IBOutlet UILabel *athleteCollege;
@property (weak, nonatomic) IBOutlet UILabel *athleteHeight;
@property (weak, nonatomic) IBOutlet UILabel *athleteWeight;
@property (weak, nonatomic) IBOutlet UILabel *athleteYear;
@property (weak, nonatomic) IBOutlet UILabel *athleteDrillVert;
@property (weak, nonatomic) IBOutlet UILabel *athleteDrillBroad;
@property (weak, nonatomic) IBOutlet UILabel *athleteDrillBench;
@property (weak, nonatomic) IBOutlet UILabel *athleteDrillShuttle;
@property (weak, nonatomic) IBOutlet UILabel *athleteDrill3Cone;
@property (weak, nonatomic) IBOutlet UILabel *athleteDrill40Yard;

@property (weak, nonatomic) IBOutlet UIScrollView *viewScroll;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end
