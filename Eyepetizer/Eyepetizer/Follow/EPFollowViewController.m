//
//  EPFollowViewController.m
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/9.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import "EPFollowViewController.h"

@interface EPFollowViewController ()<UINavigationControllerDelegate>

@end

@implementation EPFollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    [navigationController setNavigationBarHidden:YES animated:YES];
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
