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
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
    }
    
    NSString *regionsURL = @"http://dev.yebimom.com/api/regions/";
    NSData *responseData = [[NSData alloc] initWithData:[self requests:regionsURL]];
    NSArray* regionsArray = [self getJsonArrayFromResponse:responseData];
    
    NSString *moviesURL = @"http://api.androidhive.info/json/movies.json";
    responseData = [[NSData alloc] initWithData:[self requests:moviesURL]];
    NSArray* moviesArray = [self getJsonArrayFromResponse:responseData];
    
    _centerNames = @[[moviesArray[0] objectForKey:@"title"],
                     [moviesArray[1] objectForKey:@"title"],
                     [moviesArray[2] objectForKey:@"title"],
                     [moviesArray[3] objectForKey:@"title"],
                     [moviesArray[4] objectForKey:@"title"],
                     [moviesArray[5] objectForKey:@"title"],
                     [moviesArray[6] objectForKey:@"title"],
                     [moviesArray[7] objectForKey:@"title"],
                     [moviesArray[8] objectForKey:@"title"],
                     [moviesArray[9] objectForKey:@"title"],
                     [moviesArray[10] objectForKey:@"title"],
                     [moviesArray[11] objectForKey:@"title"],
                     [moviesArray[12] objectForKey:@"title"],
                     [moviesArray[13] objectForKey:@"title"],
                     [moviesArray[14] objectForKey:@"title"]];
    
    _centerRegions = @[[regionsArray[0] objectForKey:@"name"],
                       [regionsArray[1] objectForKey:@"name"],
                       [regionsArray[2] objectForKey:@"name"],
                       [regionsArray[3] objectForKey:@"name"],
                       [regionsArray[4] objectForKey:@"name"],
                       [regionsArray[5] objectForKey:@"name"],
                       [regionsArray[6] objectForKey:@"name"],
                       [regionsArray[7] objectForKey:@"name"],
                       [regionsArray[8] objectForKey:@"name"],
                       [regionsArray[9] objectForKey:@"name"],
                       [regionsArray[10] objectForKey:@"name"],
                       [regionsArray[11] objectForKey:@"name"],
                       [regionsArray[12] objectForKey:@"name"],
                       [regionsArray[13] objectForKey:@"name"],
                       [regionsArray[14] objectForKey:@"name"]];
    
    _centerImages = @[[moviesArray[0] objectForKey:@"image"],
                      [moviesArray[1] objectForKey:@"image"],
                      [moviesArray[2] objectForKey:@"image"],
                      [moviesArray[3] objectForKey:@"image"],
                      [moviesArray[4] objectForKey:@"image"],
                      [moviesArray[5] objectForKey:@"image"],
                      [moviesArray[6] objectForKey:@"image"],
                      [moviesArray[7] objectForKey:@"image"],
                      [moviesArray[8] objectForKey:@"image"],
                      [moviesArray[9] objectForKey:@"image"],
                      [moviesArray[10] objectForKey:@"image"],
                      [moviesArray[11] objectForKey:@"image"],
                      [moviesArray[12] objectForKey:@"image"],
                      [moviesArray[13] objectForKey:@"image"],
                      [moviesArray[14] objectForKey:@"image"]];
    
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
    cell.centerImageView.image = [self getImageFromURL:_centerImages[row]];
    
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
