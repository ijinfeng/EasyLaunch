//
//  HardTaskViewController.m
//  EasyLaunch
//
//  Created by jinfeng on 2021/7/8.
//

#import "HardTaskViewController.h"
#import "EasyLaunch.h"

@interface HardTaskViewController ()

@end

@implementation HardTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [EasyLaunch executeWithSection:LaunchSection_otherTaskFinished canRepeatLaunch:YES];
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
