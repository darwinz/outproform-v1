//
//  opfDrillViewController.m
//  outproform
//

#import "opfDrillViewController.h"
#import "opfStatsTableViewController.h"
#import "opfResultViewController.h"
#import "opfUser.h"

@interface opfDrillViewController ()

@end

@implementation opfDrillViewController





//*********************    ATRIBUTES    *********************//


@synthesize drill;
@synthesize drillType;
@synthesize dispText;
@synthesize chronoState;
@synthesize inter;
@synthesize inicio;
@synthesize paused;
@synthesize startBtn;
@synthesize stat;
@synthesize labelTopScore1;
@synthesize labelTopScore2;
@synthesize labelTopScore3;





//*********************    BASIC    *********************//


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)customView:(int)typeDrill
{
    if (!drill){
        drill = [[opfDrill alloc] init];
    }
    drillType = [drill obtainDrillType:typeDrill];
    [drill updateInfo:drillType];
    self.navigationView.title=drillType;
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if ([drillType isEqual:@"Vertical"] || [drillType isEqual:@"Broad Jump"] || [drillType isEqual:@"Bench Press"]) {
        [startBtn setEnabled:NO];
        [startBtn setHidden:YES];
    }
    [self viewLoadTop];
    dispText.delegate = self;
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

-(void) viewLoadTop{
    opfUser *user = [opfUser sharedUser];
    NSMutableArray *top3 = [user getTopStatsToDrill:drill];
    opfStat *statAux;
    int topCount = [top3 count];
    if (topCount > 0) {
        statAux = [top3 objectAtIndex:0];
        labelTopScore1.text = [NSString stringWithFormat:@"%@ \t\t %.2f", statAux.datetime, statAux.score];
    }
    if (topCount > 1) {
        statAux = [top3 objectAtIndex:1];
        labelTopScore2.text = [NSString stringWithFormat:@"%@ \t\t %.2f", statAux.datetime, statAux.score];
    }
    if (topCount > 2) {
        statAux = [top3 objectAtIndex:2];
        labelTopScore3.text = [NSString stringWithFormat:@"%@ \t\t %.2f", statAux.datetime, statAux.score];
    }
}








//*********************    ACTIONS    *********************//


- (IBAction)showInfo:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:drill.name
                                                    message:drill.description
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    //[alert release];
}

- (IBAction)saveValue:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"SURE?"
                                                    message:@"Are you sure you want to save this record?"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Save!", nil];
    [alert show];
}


/*
 *Delegated method, that captures UIAlertView button actions,
 *Differentiate buttons by the title
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    //NSLog(@"Some action");
    if([title isEqualToString:@"Save!"])
    {
        //NSLog(@"saving");
        stat = [[opfStat alloc] init];
        stat.drill = drill;
        stat.score = [dispText.text doubleValue];
        [stat setSelectedScoreType:1];                          //**********NEED TO CHECK THIS
        [stat saveToDB];
        [self viewLoadTop];
        [self performSegueWithIdentifier:@"showResultViewController" sender:self];
    }
}

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showListStatsAllDrill"]) {
        opfStatsTableViewController* dest =[segue destinationViewController];
        [dest setConfigStatsAll_toDrill:[NSString stringWithFormat:@"%d",drill.drillId]];
        //[dest setParent:self];
        
    }else if ([[segue identifier] isEqualToString:@"showResultViewController"]){
        opfResultViewController* dest =[segue destinationViewController];
        [dest setStat:stat];
        //[dest setParent:self];
    }
}







//******************    CHRONO HANDLING    *****************//


- (IBAction)startBtnCom:(id)sender {
    
    if(chronoState == 0){
        chronoState = 1;
        inicio = [NSDate timeIntervalSinceReferenceDate];
        inter = 0;
        [startBtn setTitle:@"STOP" forState:UIControlStateNormal];
        [self updateTime];
    }
    /*else if (chronoState == 2){
     chronoState = 1;
     inter = [NSDate timeIntervalSinceReferenceDate] - paused;
     NSLog(@"Inter = %f", inter);
     [self updateTime];
     }*/
    
    else if(chronoState != 0){
        chronoState = 0;
        [startBtn setTitle:@"START" forState:UIControlStateNormal];
        //dispText.text = @"0:00.0";
    }
}

-(void)updateTime{
    
    if(chronoState == 0 || chronoState == 2) return;
    
    NSTimeInterval actual = [NSDate timeIntervalSinceReferenceDate];
    
    actual = actual - inter;
    
    //NSLog(@"Actual = %f", actual);
    
    NSTimeInterval interval = actual - inicio;
    /*NSTimeInterval intervalAux = interval;
    
    int mins = (int) (interval / 60.0);
    interval -= mins * 60;
    
    int secs = (int) (interval);
    interval -= secs;
    
    int frac = interval * 100.0;*/
    
    //dispText.text = [NSString stringWithFormat: @"%u:%02u.%u", mins, secs, frac];
    dispText.text = [NSString stringWithFormat: @"%2.2f", interval];
    
    [self performSelector:@selector(updateTime) withObject:self afterDelay:CHRONO_UPDATE_DELAY];
}






//******************    KEYPAD HANDLING    *****************//


- (IBAction)keypadGoBack:(id)sender {
    
    [self.dispText resignFirstResponder];
}

#pragma -mark UITextField delegate method

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(IBAction) touchOnBackground{
    [self.dispText resignFirstResponder];
}


@end
