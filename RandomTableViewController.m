//
//  RandomTableViewController.m
//  randomizeNames
//
//  Created by Brock Oberhansley on 12/28/15.
//  Copyright © 2015 Brock Oberhansley. All rights reserved.
//

#import "RandomTableViewController.h"
#import "EntryController.h"

@interface RandomTableViewController ()

@property (strong, nonatomic) NSArray *namesArray;
@property int i;

@end

@implementation RandomTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addNameButton:(id)sender {
    
    UIAlertController *alerController = [UIAlertController alertControllerWithTitle:@"Add Name" message:@"enter a name you want to randomize" preferredStyle:UIAlertControllerStyleAlert];
    [alerController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Name";
    }];
    
    UIAlertAction *addName = [UIAlertAction actionWithTitle:@"ADD" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        self.entry = [[EntryController sharedInstance] createName:alerController.textFields.firstObject.text];
        
        self.namesArray = nil;
        
        [self.tableView reloadData];
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alerController addAction:addName];
    [alerController addAction:cancel];
    
    [self presentViewController:alerController animated:YES completion:nil];
    
}

- (IBAction)randomizeButton:(id)sender {
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:[EntryController sharedInstance].entries];
    
    self.namesArray = [self shuffleArray:array];
    
    self.i = 0;
    
    [self.tableView reloadData];
    
    
}

- (NSArray *)shuffleArray:(NSMutableArray *)array
{
    NSUInteger count = [array count];
    for (NSUInteger i = 0; i < count; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
        [array exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
    
    return array;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (self.namesArray == nil) {
        return 1;
    }else{
    
        if ([EntryController sharedInstance].entries.count%2 == 0) {
            return [EntryController sharedInstance].entries.count/2;
        }else{
            return ([EntryController sharedInstance].entries.count/2) + 1;
        }
        
    }

}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (self.namesArray == nil) {
        return @"";
    }else{
        return @"match";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.namesArray == nil) {
            return [EntryController sharedInstance].entries.count;
        
    }else{
        return 2;
    }


}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nameCell" forIndexPath:indexPath];
    
    Entry *entry;
    
    if (self.namesArray == nil) {
        
       entry = [EntryController sharedInstance].entries[indexPath.row];
        
    }else{
        
//        entry = self.namesArray[indexPath.row];
        entry = self.namesArray[self.i];
        self.i++;
        
    }
    
//    NSString *sectionTitle = [animalSectionTitles objectAtIndex:indexPath.section];
//    NSArray *sectionAnimals = [animals objectForKey:sectionTitle];
//    NSString *animal = [sectionAnimals objectAtIndex:indexPath.row];
//    cell.textLabel.text = animal;
    
    cell.textLabel.text = entry.name;
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.

    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        self.namesArray = nil;
        
        [self.tableView reloadData];
        
        [[EntryController sharedInstance] removeName:[EntryController sharedInstance].entries[indexPath.row]];
            
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
