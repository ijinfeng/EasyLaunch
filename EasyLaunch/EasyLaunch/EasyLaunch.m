//
//  EasyLaunch.m
//  EasyLaunch
//
//  Created by jinfeng on 2021/7/7.
//

#import "EasyLaunch.h"
#import <dlfcn.h>
#include <mach-o/getsect.h>

@implementation EasyLaunch {
    NSMutableSet *set;
}

#ifndef __LP64__
#define mach_header_c mach_header
#else
#define mach_header_c mach_header_64
#endif

void _executeWithSection(long section) {
    Dl_info info;
    if (dladdr(&_executeWithSection, &info)) {
        struct mach_header_c *machHeader = (struct mach_header_c *)info.dli_fbase;
        NSString *s = [NSString stringWithFormat:@"_easy_%zd",section];
#ifndef __LP64__
        unsigned long size = 0;
        uintptr_t *data = (uintptr_t *)getsectiondata(machHeader, "__DATA", s.UTF8String, &size);
        if (data == NULL) {
            return;
        }
        int count = (int)(size / sizeof(void *));
        for (int i = 0; i < count; ++i) {
            void (*function)(void) = (void (*)(void))data[i];
            (function)();
        }
#else
        const struct section_64 * section64 = getsectbynamefromheader_64(machHeader, "__DATA", s.UTF8String);
        if (section64 == nil) {
            return;
        }
        uint16_t step = sizeof(void *);
        for (uint16_t offset = section64->offset; offset < section64->offset + section64->size; offset += step) {
            void (**function)(void) = (void (**)(void))((uint64_t)machHeader + offset);
            (*function)();
        }
#endif
    }
}

+ (instancetype)shared {
    static EasyLaunch *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [EasyLaunch new];
        instance->set = [NSMutableSet set];
    });
    return instance;
}

+ (void)executeWithSection:(NSInteger)section {
    [self executeWithSection:section canRepeatLaunch:NO];
}

+ (void)executeWithSection:(NSInteger)section canRepeatLaunch:(BOOL)launch {
    if ([[EasyLaunch shared]->set containsObject:@(section)]) {
        return;
    }
    if (!launch) {
        [[EasyLaunch shared]->set addObject:@(section)];
    }
    _executeWithSection(section);
}

@end


