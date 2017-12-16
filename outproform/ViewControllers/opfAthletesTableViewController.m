//
//  opfAthletesTableViewController.m
//  outproform
//

#import "opfAthletesTableViewController.h"
#import "opfAthleteDetailViewController.h"
#import "opfAthlete.h"

@interface opfAthletesTableViewController (){
    NSMutableArray *_objects;
}

@end

@implementation opfAthletesTableViewController

@synthesize athletes;

- (id)initWithStyle:(UITableViewStyle)style
{
    NSLog(@"at init");
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)insertNewObject
{
    /*if (!_objects) {
     _objects = [[NSMutableArray alloc] init];
     }
     [_objects insertObject:[NSDate date] atIndex:0];*/
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)viewDidLoad
{
    opfAthlete * myAthlete =[[opfAthlete alloc] init];
    self.athletes = [myAthlete getAthletes];
    
    //[self.viewCellAthleteName setText:((opfAthlete *) [self.athletes objectAtIndex:0]).name];
    /*for (int i=0; i<athletes.count; i++) {
     [self insertNewObject];
     }*/
    
    /*
     [self.wineViewer setImage:((WineList *) [self.wines objectAtIndex:0]).photo];
     [self.winename setText:((WineList *) [self.wines objectAtIndex:0]).wine];
     
     [self.winerating setText:((WineList *) [self.wines objectAtIndex:0]).rating];
     */
    
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return athletes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSString *CellIdentifier = self.cellView.reuseIdentifier;
    /*UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
     //[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
     
     // Configure the cell...
     opfAthlete *athlete = athletes[indexPath.row];
     cell.textLabel.text = [athlete name];
     */
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    opfAthlete *athlete = [self.athletes objectAtIndex:indexPath.row];
    cell.textLabel.text = athlete.name;
    cell.detailTextLabel.text = athlete.college;
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetailAthlete"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        opfAthlete *object = self.athletes[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}



@end

