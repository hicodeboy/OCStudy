//
//  ThrottleAndDebounce.m
//  OCStudy
//
//  Created by hicodeboy on 2021/11/13.
//  Copyright © 2021 Location. All rights reserved.
//

#import "ThrottleAndDebounce.h"

@implementation ThrottleAndDebounce

@end

@interface Debounce()
@property (nonatomic, strong) NSObject *flag;
@end

@implementation Debounce
- (void)debounce:(DebounceBlock)debounce {
    NSObject *tmp = [[NSObject alloc] init];
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.flag = tmp;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            if (tmp == weakSelf.flag) {
                debounce();
            }
        });
        
    });
}
@end

@interface Throttle()
@property (nonatomic, strong) NSObject *flag;
@property (nonatomic, strong) NSDate *lastTime;
@property (nonatomic, assign) BOOL start;
@property (nonatomic, assign) BOOL isUsed;
@end

@implementation Throttle

- (instancetype)init {
    self = [super init];
    if (self) {
        _lastTime = [[NSDate alloc] init];
        _start = YES;
        _isUsed = NO;
    }
    return self;
}

- (void)throttle:(ThrottleBlock)throttle mode:(ThrottleMode)mode {
    NSObject *tmp = [[NSObject alloc] init];
    __weak typeof(self) weakSelf = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.flag = tmp;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            if (tmp == weakSelf.flag) {
                weakSelf.start = YES;
                if (!weakSelf.isUsed) {
                    throttle();
                }
                weakSelf.isUsed = NO;
            }
        });
    });
    
    NSDate *newDate = [[NSDate alloc] init];
    
    if (mode == ThrottleModeBefore) {
        if (_start) {
            _start = NO;
            self.lastTime = [[NSDate alloc] init];
            _isUsed = YES;
            throttle();
        } else {
            NSInteger delay = newDate.timeIntervalSince1970 - weakSelf.lastTime.timeIntervalSince1970;
            if (delay > 1) {
                weakSelf.lastTime = [[NSDate alloc] init];
                _isUsed = YES;
                throttle();
            }
        }
    } else {
        if (_start) {
            _start = NO;
            self.lastTime = [[NSDate alloc] init];
        }
        
        NSInteger delay = newDate.timeIntervalSince1970 - self.lastTime.timeIntervalSince1970;
        if (delay > 1) {
            self.lastTime = [[NSDate alloc] init];
            _isUsed = YES;
            throttle();
        }
        
    }
}
@end
