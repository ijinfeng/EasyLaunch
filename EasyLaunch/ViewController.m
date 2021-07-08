//
//  ViewController.m
//  EasyLaunch
//
//  Created by jinfeng on 2021/7/7.
//

#import "ViewController.h"
#import "EasyLaunch.h"
#import "HardTaskViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [EasyLaunch executeWithSection:LaunchSection_homePageDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    HardTaskViewController *vc = [HardTaskViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

EASY_REGISTER_LAUNCH_FUNCATION(LaunchSection_didFinishLaunching) {
    NSLog(@"执行 LaunchSection_didFinishLaunching");
}

EASY_REGISTER_LAUNCH_FUNCATION(LaunchSection_homePageDidLoad) {
    NSLog(@"执行 LaunchSection_homePageDidLoad");
}

EASY_REGISTER_LAUNCH_FUNCATION(LaunchSection_otherTaskFinished) {
    NSLog(@"执行 LaunchSection_otherTaskFinished");
}

@end
