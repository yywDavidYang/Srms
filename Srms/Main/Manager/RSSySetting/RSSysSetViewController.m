//
//  SystermsViewController.m
//  Srms
//
//  Created by apple on 16/6/23.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "RSSysSetViewController.h"

@interface RSSysSetViewController ()

@end

@implementation RSSysSetViewController

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view from its nib.
    self.title = @"系统设置";
    
    self.view.backgroundColor = [UIColor cyanColor];

}

- (BOOL)prefersStatusBarHidden{
    
    return YES;
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
