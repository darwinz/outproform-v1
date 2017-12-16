//
//  opfAthleteDetailViewController.m
//  outproform
//

#import "opfAthleteDetailViewController.h"
#import "opfStat.h"
#import "opfDrill.h"

@interface opfAthleteDetailViewController ()
- (void)configureView;
@end

@implementation opfAthleteDetailViewController


@synthesize viewScroll;
@synthesize detailItem;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setDetailItem:(id)newDetailItem
{
    if (detailItem != newDetailItem) {
        detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
    
    /*if (self.masterPopoverController != nil) {
     [self.masterPopoverController dismissPopoverAnimated:YES];
     }*/
}

- (void)configureView
{
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.athleteName.text = detailItem.name;
        self.athleteHeight.text = [NSString stringWithFormat:@"%d in", detailItem.height];
        self.athleteWeight.text = [NSString stringWithFormat:@"%d lb", detailItem.weight];
        self.athleteCollege.text = detailItem.college;
        self.athleteYear.text = [NSString stringWithFormat:@"%d", detailItem.year];
        if (detailItem.wonderlic>0) {
            self.athleteWonderlic.text = [NSString stringWithFormat:@"%d", detailItem.wonderlic];
        }else{
            self.athleteWonderlic.text = @"--";
        }
        [detailItem getStats];
        for (opfStat *stat in detailItem.statsArray) {
            if ([stat.drill.name  isEqual:@"Vertical"]) {
                self.athleteDrillVert.text = [NSString stringWithFormat:@"%.2f %@", stat.score, [stat scoreTypeCode]];
            }else if ([stat.drill.name  isEqual:@"Broad Jump"]){
                self.athleteDrillBroad.text = [NSString stringWithFormat:@"%.2f %@", stat.score, [stat scoreTypeCode]];
            }else if ([stat.drill.name  isEqual:@"Bench Press"]){
                self.athleteDrillBench.text = [NSString stringWithFormat:@"%.2f %@", stat.score, [stat scoreTypeCode]];
            }else if ([stat.drill.name  isEqual:@"Shuttle Run"]){
                self.athleteDrillShuttle.text = [NSString stringWithFormat:@"%.2f %@", stat.score, [stat scoreTypeCode]];
            }else if ([stat.drill.name  isEqual:@"3-Cone Drill"]){
                self.athleteDrill3Cone.text = [NSString stringWithFormat:@"%.2f %@", stat.score, [stat scoreTypeCode]];
            }else if ([stat.drill.name  isEqual:@"40-yard Dash"]){
                self.athleteDrill40Yard.text = [NSString stringWithFormat:@"%.2f %@", stat.score, [stat scoreTypeCode]];
            }else {
                self.athleteDrillBroad.text = [NSString stringWithFormat:@"ERROR %.2f %@", stat.score, [stat scoreTypeCode]];
            }
            
        }
    }
}

- (void)viewDidLoad
{
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

@end
