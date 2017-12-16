//
//  opfRegistrationViewController.h
//  outproform
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

#define ERROR_TITTLE @"ERROR!"
#define ERR_REG_UNCOMPLETED @"Need to complete the basic information!"

@interface opfRegistrationViewController : UIViewController <FBLoginViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIControl *viewContent;
@property (weak, nonatomic) IBOutlet UIScrollView *viewScroll;
@property (weak, nonatomic) IBOutlet UITextField *textName;
@property (weak, nonatomic) IBOutlet UITextField *textHeight;
@property (weak, nonatomic) IBOutlet UITextField *textWeight;
@property (weak, nonatomic) IBOutlet UITextField *textAge;
@property (weak, nonatomic) IBOutlet UITextField *textStatValue;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerStat;
@property (strong, retain) NSArray *arrStats;
@property (strong, retain) NSArray *arrStatsCodes;
@property (weak, nonatomic) IBOutlet FBProfilePictureView *profilePicture;

- (IBAction)touchOnBackground;
- (IBAction)keypadGoBack:(id)sender;

- (IBAction)includeCombineStat:(id)sender;
- (IBAction)finishRegistration:(id)sender;

@end
