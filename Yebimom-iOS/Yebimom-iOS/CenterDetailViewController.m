//
//  CenterDetailViewController.m
//  Yebimom-iOS
//
//  Created by wikibootup on 4/18/15.
//  Copyright (c) 2015 wikibootup. All rights reserved.
//

#import "CenterDetailViewController.h"

@interface CenterDetailViewController ()

@end

@implementation CenterDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _centerNameLabel.text = _centerDetail[0];
    _centerImageView.image = [UIImage imageNamed:_centerDetail[1]];
    // Do any additional setup after loading the view.
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
