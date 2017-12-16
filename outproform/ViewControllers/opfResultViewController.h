//
//  opfResultViewController.h
//  outproform
//

#import <UIKit/UIKit.h>
#import "opfStat.h"


@interface opfResultViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstBetterLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondBetterLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdBetterLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstWorseLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondWorseLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdWorseLabel;
@property (weak, nonatomic) IBOutlet UILabel *bitLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *viewScroll;
@property (weak, nonatomic) IBOutlet UIView *viewContent;

@property (strong, retain)  opfStat *stat;

- (IBAction)shareFacebook:(id)sender;


@end
