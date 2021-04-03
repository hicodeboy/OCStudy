//
//  PPOperation.m
//  OCStudy
//
//  Created by dujia on 2021/3/29.
//

#import "PPOperation.h"

@implementation PPOperation


- (void)main {
    if (self.isCancelled == YES) {
        return;
    }
    for (int i = 0; i < 2; i ++) {
        [NSThread sleepForTimeInterval:2];
        NSLog(@"3---%@",[NSThread currentThread]); // 打印当前线程
    }
}

@end
