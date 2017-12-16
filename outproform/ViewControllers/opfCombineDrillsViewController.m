//
//  opfCombineDrillsViewController.m
//  outproform
//

#import "opfCombineDrillsViewController.h"
#import "opfDrill.h"

@interface opfCombineDrillsViewController ()

@end

@implementation opfCombineDrillsViewController

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

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"verticalSegue"]) {
        opfDrillViewController* dest =[segue destinationViewController];
        [dest customView:VERTICAL_DRILL];
        
    }
    else if ([[segue identifier] isEqualToString:@"broadSegue"]) {
        opfDrillViewController* dest =[segue destinationViewController];
        [dest customView:BROAD_DRILL];
        
    }
    else if ([[segue identifier] isEqualToString:@"benchSegue"]) {
        opfDrillViewController* dest =[segue destinationViewController];
        [dest customView:BENCH_DRILL];
        
    }
    else if ([[segue identifier] isEqualToString:@"shuttleSegue"]) {
        opfDrillViewController* dest =[segue destinationViewController];
        [dest customView:SHUTTLE_DRILL];
        
    }
    else if ([[segue identifier] isEqualToString:@"3coneSegue"]) {
        opfDrillViewController* dest =[segue destinationViewController];
        [dest customView:CONE3_DRILL];
        
    }
    else if ([[segue identifier] isEqualToString:@"40yardSegue"]) {
        opfDrillViewController* dest =[segue destinationViewController];
        [dest customView:YARD40_DRILL];
        
    }
}


@end
