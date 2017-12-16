//
//  opfProfileViewController.m
//  outproform
//

#import "opfProfileViewController.h"
#import "opfStat.h"
#import "opfEditProfileViewController.h"
#import "opfStatsTableViewController.h"
#import "opfDrill.h"

@interface opfProfileViewController ()

@end

@implementation opfProfileViewController

@synthesize viewScroll;
@synthesize detailItem;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSLog(@"at init");
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)updateDisplayedInfo
{
    [self configureView];
}

- (void)configureView
{
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.profileName.text = detailItem.name;
        self.profileHeight.text = [NSString stringWithFormat:@"%d in", detailItem.height];
        self.profileWeight.text = [NSString stringWithFormat:@"%d lb", detailItem.weight];
        self.profileAge.text = [NSString stringWithFormat:@"%d", detailItem.age];
        //[_detailItem getStats];
        for (opfStat *stat in detailItem.statsArray) {
            if ([stat.drill.name  isEqual:@"Vertical"]) {
                self.profileVertical.text = [NSString stringWithFormat:@"%.2f %@", stat.score, stat.scoreTypeCode];
            }else if ([stat.drill.name  isEqual:@"Broad Jump"]){
                self.profileBroad.text = [NSString stringWithFormat:@"%.2f %@", stat.score, stat.scoreTypeCode];
            }else if ([stat.drill.name  isEqual:@"Bench Press"]){
                self.profileBench.text = [NSString stringWithFormat:@"%.2f %@", stat.score, stat.scoreTypeCode];
            }else if ([stat.drill.name  isEqual:@"Shuttle Run"]){
                self.profileShuttle.text = [NSString stringWithFormat:@"%.2f %@", stat.score, stat.scoreTypeCode];
            }else if ([stat.drill.name  isEqual:@"3-Cone Drill"]){
                self.profile3Cone.text = [NSString stringWithFormat:@"%.2f %@", stat.score, stat.scoreTypeCode];
            }else if ([stat.drill.name  isEqual:@"40-yard Dash"]){
                self.profile40Yard.text = [NSString stringWithFormat:@"%.2f %@", stat.score, stat.scoreTypeCode];
            }else {
                self.profileVertical.text = [NSString stringWithFormat:@"ERROR %.2f %@", stat.score, stat.scoreTypeCode];
            }
            
        }
    }
}

- (void)viewDidLoad
{
    if (!self.detailItem){
        self.detailItem = [opfUser sharedUser];
        //self.detailItem = [[opfUser alloc] init];
        //[detailItem getProfile];
    }
    /*if (!self.global){
     _global = [opfConstants sharedGlobal];
     }*/
    
    
    //[scroller setScrollEnabled:YES];
    //[scroller setContentSize:CGSizeMake(260, 800)];  //(320, 650) is the size of View which is inside the UIScrollView.
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self configureView];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.viewScroll layoutIfNeeded];
    self.viewScroll.contentSize = self.contentView.bounds.size;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showEditProfile"]) {
        opfEditProfileViewController* dest =[segue destinationViewController];
        //[dest setProfileEditing:detailItem];
        [dest setParent:self];
        
    }
    if ([[segue identifier] isEqualToString:@"showListStatsAllProfile"]) {
        opfStatsTableViewController* dest =[segue destinationViewController];
        [dest setConfigStatsAll_toDrill:@"NULL"];
        //[dest setParent:self];
        
    }
}

@end
