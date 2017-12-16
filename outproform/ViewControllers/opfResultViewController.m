//
//  opfResultViewController.m
//  outproform
//

#import "opfResultViewController.h"
#import "opfStat.h"

@interface opfResultViewController ()

@end

@implementation opfResultViewController

@synthesize stat;
@synthesize scoreLabel;
@synthesize firstBetterLabel;
@synthesize secondBetterLabel;
@synthesize thirdBetterLabel;
@synthesize firstWorseLabel;
@synthesize secondWorseLabel;
@synthesize thirdWorseLabel;
@synthesize bitLabel;

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
    NSMutableArray* betterThan = [stat betterThanTop3];
    NSMutableArray* worseThan = [stat worseThanTop3];
    NSString *bitOne = [stat closestBig];
    
    
    scoreLabel.text = [NSString stringWithFormat:@"%.2f", stat.score];
    scoreLabel.textAlignment = NSTextAlignmentCenter;
    firstBetterLabel.text = [NSString stringWithFormat:@"1) %@", [betterThan objectAtIndex:0]];
    secondBetterLabel.text = [NSString stringWithFormat:@"2) %@", [betterThan objectAtIndex:1]];
    thirdBetterLabel.text = [NSString stringWithFormat:@"3) %@", [betterThan objectAtIndex:2]];
    firstWorseLabel.text = [NSString stringWithFormat:@"1) %@", [worseThan objectAtIndex:0]];
    secondWorseLabel.text = [NSString stringWithFormat:@"2) %@", [worseThan objectAtIndex:1]];
    thirdWorseLabel.text = [NSString stringWithFormat:@"3) %@", [worseThan objectAtIndex:2]];
    bitLabel.text = [NSString stringWithFormat:@"%@", bitOne];
    
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



- (IBAction)shareFacebook:(id)sender {
}

@end
