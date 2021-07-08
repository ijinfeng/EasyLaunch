//
//  EasyLaunch.h
//  EasyLaunch
//
//  Created by jinfeng on 2021/7/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define EASY_REGISTER_LAUNCH_FUNCATION(key) __EASY_REGISTER_LAUNCH_FUNCATION(key)
#define __EASY_REGISTER_LAUNCH_FUNCATION(key) \
    static void __EASY_REGISTER_LAUNCH_##key(void); \
    __attribute__((used, section("__DATA," "_easy_" #key))) \
    static const void * __EASY__##key = __EASY_REGISTER_LAUNCH_##key; \
    static void __EASY_REGISTER_LAUNCH_##key(void) \


@interface EasyLaunch : NSObject

/// 在指定section执行启动项
/// @param section ‘Launch section keys’
+ (void)executeWithSection:(NSInteger)section;

/// 在指定section执行启动项
/// @param section section ‘Launch section keys’
/// @param launch 是否可以重复启动
+ (void)executeWithSection:(NSInteger)section canRepeatLaunch:(BOOL)launch;

@end

#pragma mark -- Launch section keys
/// didFinishLaunching后执行
#define LaunchSection_didFinishLaunching 1
/// 首页加载后执行
#define LaunchSection_homePageDidLoad 2
/// 其他阶段完成后执行（自定义）
#define LaunchSection_otherTaskFinished 3

NS_ASSUME_NONNULL_END
