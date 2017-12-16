//
//  opfProfileViewController.h
//  outproform
//

#import <UIKit/UIKit.h>
#import "opfUser.h"

@interface opfProfileViewController : UIViewController


@property (strong, nonatomic) opfUser *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *profileName;
@property (weak, nonatomic) IBOutlet UILabel *profileHeight;
@property (weak, nonatomic) IBOutlet UILabel *profileWeight;
@property (weak, nonatomic) IBOutlet UILabel *profileAge;
@property (weak, nonatomic) IBOutlet UILabel *profileVertical;
@property (weak, nonatomic) IBOutlet UILabel *profileBroad;
@property (weak, nonatomic) IBOutlet UILabel *profileBench;
@property (weak, nonatomic) IBOutlet UILabel *profileShuttle;
@property (weak, nonatomic) IBOutlet UILabel *profile3Cone;
@property (weak, nonatomic) IBOutlet UILabel *profile40Yard;
@property (weak, nonatomic) IBOutlet UIScrollView *viewScroll;
@property (weak, nonatomic) IBOutlet UIView *contentView;


- (void)updateDisplayedInfo;


@end
