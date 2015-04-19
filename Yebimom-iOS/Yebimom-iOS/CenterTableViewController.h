//
//  CenterTableViewController.h
//  Yebimom-iOS
//
//  Created by wikibootup on 4/16/15.
//  Copyright (c) 2015 wikibootup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CenterTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *centerNames;
@property (nonatomic, strong) NSArray *centerImages;
@property (nonatomic, strong) NSArray *centerRegions;

- (NSData *)requests:(NSString *)targetURL;
- (NSArray *)getJsonArrayFromResponse:(NSData *)responseData;

@end
