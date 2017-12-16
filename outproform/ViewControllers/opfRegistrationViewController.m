//
//  opfRegistrationViewController.m
//  outproform
//

#import "opfRegistrationViewController.h"
#import "opfStat.h"
#import "opfDrill.h"
#import "opfUser.h"
@interface opfRegistrationViewController ()

@end

@implementation opfRegistrationViewController
@synthesize pickerStat;
@synthesize arrStats;
@synthesize textAge;
@synthesize textHeight;
@synthesize textName;
@synthesize textStatValue;
@synthesize textWeight;
@synthesize arrStatsCodes;
@synthesize profilePicture;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    arrStats = [[NSArray alloc] initWithObjects:@"Vertical", @"Broad Jump", @"Bench Press", @"Shuttle Run", @"3 Cone Drill", @"40 Yard Dash", nil];
    arrStatsCodes = [[NSArray alloc] initWithObjects: [NSNumber numberWithInt:VERTICAL_DRILL], [NSNumber numberWithInt:BROAD_DRILL], [NSNumber numberWithInt:BENCH_DRILL], [NSNumber numberWithInt:SHUTTLE_DRILL], [NSNumber numberWithInt:CONE3_DRILL], [NSNumber numberWithInt:YARD40_DRILL], nil];
    opfUser *user = [opfUser sharedUser];
    if (user.registered==1) {
        [self performSegueWithIdentifier:@"showMainMenu" sender:self];;
    }
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








//******************    FACEBOOK HANDLING    *****************//

// This method will be called when the user information has been fetched
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    //profilePicture.profileID = user.id;
    [profilePicture setHidden:false];
    [profilePicture setProfileID:user.id];
    textName.text = user.name;
    
}

// Logged-out user experience
- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    [profilePicture setHidden:true];
    [profilePicture setProfileID:nil];
    textName.text = @"";
}



//******************    ACTIONS    *****************//

- (IBAction)includeCombineStat:(id)sender {
    //verify data of stat
    NSUInteger selectedRow = [pickerStat selectedRowInComponent:0];
    NSString *stat= [arrStats objectAtIndex:selectedRow];
    double score = [textStatValue.text doubleValue];
    //Alert
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Saved!"
                                                    message:[NSString stringWithFormat:@"Saved %@ with score of %.2f", stat, score]
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
    //Insert stat
    
    opfDrill *drill = [[opfDrill alloc] init];
    NSString *drillType = [drill obtainDrillType:[[arrStatsCodes objectAtIndex:selectedRow] integerValue]];
    [drill updateInfo:drillType];
    opfStat *savingStat = [[opfStat alloc] init];
    savingStat.drill = drill;
    savingStat.score = score;
    NSLog(@"default ST: %d",drill.defaultScoreType);
    [savingStat setSelectedScoreType:drill.defaultScoreType];                          //**********NEED TO CHECK THIS
    [savingStat saveToDB];
}

- (IBAction)finishRegistration:(id)sender {
    opfUser *user = [opfUser sharedUser];
    //UPDATE ITEM FIELDS
    user.name = textName.text;
    user.age = [textAge.text intValue];
    user.height = [textHeight.text intValue];
    user.weight = [textWeight.text intValue];
    user.registered = 1;
    
    bool isValidInformation = [user validateInfo];
    if (isValidInformation) {
        //UPDATE DATABASE
        [user updateProfile];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self showMessage:ERROR_TITTLE whithMessage:ERR_REG_UNCOMPLETED];
    }
    
    //Validate data
    //Update User
    NSLog(@"Did access it");
}

-(void)showMessage: (NSString*) tittle whithMessage: (NSString*) message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:tittle
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}


//******************    PICKER HANDLING    *****************//

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    //One column
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    //set number of rows
    return arrStats.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //set item per row
    return [arrStats objectAtIndex:row];
}





//******************    KEYPAD HANDLING    *****************//


- (IBAction)keypadGoBack:(id)sender {
    [self.textName resignFirstResponder];
    [self.textHeight resignFirstResponder];
    [self.textWeight resignFirstResponder];
    [self.textAge resignFirstResponder];
    [self.textStatValue resignFirstResponder];
}

#pragma -mark UITextField delegate method

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(IBAction) touchOnBackground{
    [self.textName resignFirstResponder];
    [self.textHeight resignFirstResponder];
    [self.textWeight resignFirstResponder];
    [self.textAge resignFirstResponder];
    [self.textStatValue resignFirstResponder];
}


@end
