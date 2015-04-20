//
//  CenterDetailViewController.h
//  Yebimom-iOS
//
//  Created by wikibootup on 4/18/15.
//  Copyright (c) 2015 wikibootup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CenterDetailViewController : UIViewController


@property (strong, nonatomic) IBOutlet UIImageView *centerImageView;
@property (strong, nonatomic) IBOutlet UILabel *centerNameLabel;
@property (strong, nonatomic) NSArray *centerDetail;
@property (strong, nonatomic) IBOutlet UILabel *centerRegionLabel;

- (UIImage *)getImageFromURL:(NSString *)imageURL;

@end
