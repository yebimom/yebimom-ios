//
//  CenterDetailViewController.m
//  Yebimom-iOS
//
//  Created by wikibootup on 4/18/15.
//  Copyright (c) 2015 wikibootup. All rights reserved.
//

#import "CenterDetailViewController.h"
#import "CenterTableViewController.h"

@interface CenterDetailViewController ()

@end

@implementation CenterDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _centerImageView.image = _centerDetail[0];
    _centerNameLabel.text = _centerDetail[1];
    _centerRegionLabel.text = _centerDetail[2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
