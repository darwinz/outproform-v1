//
//  opfDrillViewController.h
//  outproform
//

#import <UIKit/UIKit.h>
#import "opfDrill.h"
#import "opfStat.h"
#define CHRONO_UPDATE_DELAY 0.01

@interface opfDrillViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate>{
    
}

@property (weak, nonatomic) IBOutlet UILabel *labelTopScore1;
@property (weak, nonatomic) IBOutlet UILabel *labelTopScore2;
@property (weak, nonatomic) IBOutlet UILabel *labelTopScore3;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UITextField *dispText;
@property (weak, nonatomic) IBOutlet UIScrollView *viewScroll;
@property (weak, nonatomic) IBOutlet UIView *viewContent;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationView;

@property (strong, retain)  opfDrill *drill;
@property (strong, retain)  opfStat *stat;
@property (strong, retain) NSString  *drillType;
@property NSTimeInterval  inter;
@property NSTimeInterval  inicio;
@property NSTimeInterval  paused;
@property int chronoState;

- (IBAction)touchOnBackground;
- (IBAction)keypadGoBack:(id)sender;


- (IBAction)startBtnCom:(id)sender;
- (IBAction)saveValue:(id)sender;
- (IBAction)showInfo:(id)sender;
- (void)customView:(int)typeDrill;
@end
