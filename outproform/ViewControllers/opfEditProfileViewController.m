//
//  opfEditProfileViewController.m
//  outproform
//

#import "opfEditProfileViewController.h"

@interface opfEditProfileViewController ()

@end

@implementation opfEditProfileViewController

@synthesize parental;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setParent:(id)newParent
{
    parental = newParent;
}

- (void)configureView
{
    // Update the user interface for the detail item.
    if (self.detailItem) {
        //NSLog(@"configuring detail...");
        self.nameEdited.text = _detailItem.name;
        self.ageEdited.text = [NSString stringWithFormat:@"%d", _detailItem.age];
        self.weightEdited.text = [NSString stringWithFormat:@"%d", _detailItem.weight];
        self.heightEdited.text = [NSString stringWithFormat:@"%d", _detailItem.height];
    }
}

- (void)viewDidLoad
{
    if (!self.detailItem){
        self.detailItem = [opfUser sharedUser];
    }
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self configureView];
    //self.nameEdited.delegate =self;
    //self.weightEdited.delegate =self;
    //self.heightEdited.delegate =self;
    //self.ageEdited.delegate =self;
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.viewScroll layoutIfNeeded];
    self.viewScroll.contentSize = self.viewContent.bounds.size;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveEditedProfile:(id)sender {
    //UPDATE ITEM FIELDS
    self.detailItem.name = self.nameEdited.text;
    self.detailItem.age = [self.ageEdited.text intValue];
    self.detailItem.height = [self.heightEdited.text intValue];
    self.detailItem.weight = [self.weightEdited.text intValue];
    
    //UPDATE DATABASE
    [self.detailItem updateProfile];
    
    //ASK ACTIV PARENT TO UPDATE DISPLAYED INFO
    [parental updateDisplayedInfo];
    
    //POP ONE SEGUE BACK
    [self.navigationController popViewControllerAnimated:YES];
}

/*
 *Hide the Keypad when you perfromed an action over another item
 */
- (IBAction)keypadGoBack:(id)sender {
    [self.nameEdited resignFirstResponder];
    [self.ageEdited resignFirstResponder];
    [self.weightEdited resignFirstResponder];
    [self.heightEdited resignFirstResponder];
}

#pragma -mark UITextField delegate method

/*
 *Hide the Keypad when you hit the return buttom
 *Delegated on the viewdidload
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

/*
 *Hide the Keypad when you touch the background
 */
-(IBAction) touchOnBackground{
    [self.nameEdited resignFirstResponder];
    [self.ageEdited resignFirstResponder];
    [self.weightEdited resignFirstResponder];
    [self.heightEdited resignFirstResponder];
}

@end
