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
#import "SWRevealViewController.h"

@interface CenterTableViewController ()

@end

@implementation CenterTableViewController

- (NSData *)requests:(NSString *)targetURL {
    NSURL * url = [[NSURL alloc] initWithString:targetURL];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url
                                                cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                            timeoutInterval:30];
    
    NSURLResponse *response;
    NSError *error;
    
    NSData *urlData = [NSURLConnection sendSynchronousRequest:urlRequest
                                    returningResponse:&response
                                                error:&error];
    
    return urlData;
}

- (NSArray *)getJsonArrayFromResponse:(NSData *)responseData {
    NSError *error;
    NSArray* jsonArray = [NSJSONSerialization
                       JSONObjectWithData:responseData
                       options:0
                       error:&error];
    
    return jsonArray;
}

- (UIImage *)getImageFromURL:(NSString *)imageURLStr {
    NSURL *imageURL = [NSURL URLWithString:imageURLStr];
    NSData *imageDataFromURL = [NSData dataWithContentsOfURL:imageURL];
    return [UIImage imageWithData:imageDataFromURL];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // NSMuableArray initialization
    _centerNames = [[NSMutableArray alloc] init];
    _centerRegions = [[NSMutableArray alloc] init];
    _centerImages = [[NSMutableArray alloc] init];
    
    // Sidebar button configuration
    SWRevealViewController *revealViewController = [self revealViewController];
    
    [revealViewController tapGestureRecognizer];
    
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
    }
    
    // Get data from API server
    NSString *centersURL = @"http://yebimom.com/api/centers/";
    NSData *responseData = [[NSData alloc] initWithData:[self requests:centersURL]];
    NSArray* centersArray = [self getJsonArrayFromResponse:responseData];
    
    for(int i=0 ; i<[centersArray count] ; i++) {
        [_centerImages addObject:[self getImageFromURL:@"http://img.etoday.co.kr/pto_db/2013/05/20130531093321_305736_400_283.jpg"]];
        [_centerNames addObject:[centersArray[i] objectForKey:@"name"]];
        [_centerRegions addObject:[centersArray[i] objectForKey:@"address"]];
    }
    
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
    cell.centerRegionLabel.text = _centerRegions[row];
    cell.centerImageView.image = _centerImages[row];
    
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
    if (editingStyle == UITableViewCellEditingStyleDelete)
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
        
        detailViewController.centerDetail = @[_centerImages[row],
                                              _centerNames[row],
                                              _centerRegions[row]];
    }
}


@end
