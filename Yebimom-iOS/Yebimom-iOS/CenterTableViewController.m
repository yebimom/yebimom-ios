//
//  CenterTableViewController.m
//  Yebimom-iOS
//
//  Created by wikibootup on 4/16/15.
//  Copyright (c) 2015 wikibootup. All rights reserved.
//

#import "CenterTableViewController.h"
#import "CenterTableViewCell.h"
#import "CenterDetailViewController.h"

@interface CenterTableViewController ()

@end

@implementation CenterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _centerNames = @[@"미즈 산후조리원 1",
                     @"미즈 산후조리원 2",
                     @"미즈 산후조리원 3",
                     @"미즈 산후조리원 4",
                     @"미즈 산후조리원 5",
                     @"미즈 산후조리원 6",
                     @"미즈 산후조리원 7",
                     @"미즈 산후조리원 8",
                     @"미즈 산후조리원 9",
                     @"미즈 산후조리원 10",
                     @"미즈 산후조리원 11",
                     @"미즈 산후조리원 12",
                     @"미즈 산후조리원 13",
                     @"미즈 산후조리원 14"];
    
    _centerImages =@[@"miz-center.png",
                     @"miz-center.png",
                     @"miz-center.png",
                     @"miz-center.png",
                     @"miz-center.png",
                     @"miz-center.png",
                     @"miz-center.png",
                     @"miz-center.png",
                     @"miz-center.png",
                     @"miz-center.png",
                     @"miz-center.png",
                     @"miz-center.png",
                     @"miz-center.png",
                     @"miz-center.png"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.centerNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"centerTableCell";
    
    CenterTableViewCell *cell = [tableView
                                 dequeueReusableCellWithIdentifier:CellIdentifier
                                 forIndexPath:indexPath];
    
    // Configure the cell...
    long row = [indexPath row];
    cell.centerNameLabel.text = _centerNames[row];
    cell.centerImage.image = [UIImage imageNamed:_centerImages[row]];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
    if ([[segue identifier] isEqualToString:@"ShowCenterDetails"])
    {
        CenterDetailViewController *detailViewController = [segue destinationViewController];
        
        NSIndexPath *centerIndexPath = [self.tableView indexPathForSelectedRow];
        
        long row = [centerIndexPath row];
        
        detailViewController.centerDetail = @[_centerNames[row], _centerImages[row]];
    }
}


@end
