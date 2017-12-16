//
//  opfEditProfileViewController.h
//  outproform
//

#import <UIKit/UIKit.h>
#import "opfUser.h"
#import "opfProfileViewController.h"

@interface opfEditProfileViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameEdited;
@property (weak, nonatomic) IBOutlet UITextField *ageEdited;
@property (weak, nonatomic) IBOutlet UITextField *heightEdited;
@property (weak, nonatomic) IBOutlet UITextField *weightEdited;

@property (weak, nonatomic) IBOutlet UIScrollView *viewScroll;
@property (weak, nonatomic) IBOutlet UIControl *viewContent;

@property (strong, nonatomic) opfUser *detailItem;
@property (strong, nonatomic) opfProfileViewController *parental;
- (IBAction)saveEditedProfile:(id)sender;

//- (void)setProfileEditing:(id)sender;
- (void)setParent:(id)newDetailItem;

- (IBAction)keypadGoBack:(id)sender;
-(IBAction) touchOnBackground;

@end
