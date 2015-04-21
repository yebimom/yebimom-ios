//
//  CenterTableViewController.h
//  Yebimom-iOS
//
//  Created by wikibootup on 4/16/15.
//  Copyright (c) 2015 wikibootup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CenterTableViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (nonatomic, strong) NSMutableArray *centerImages;
@property (nonatomic, strong) NSMutableArray *centerNames;
@property (nonatomic, strong) NSMutableArray *centerRegions;

- (NSData *)requests:(NSString *)targetURL;
- (NSArray *)getJsonArrayFromResponse:(NSData *)responseData;
- (UIImage *)getImageFromURL:(NSString *)imageURL;

@end
