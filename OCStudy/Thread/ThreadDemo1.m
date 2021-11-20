//
//  ThreadDemo1.m
//  OCStudy
//
//  Created by hicodeboy on 2021/11/13.
//

#import "ThreadDemo1.h"

@implementation ThreadDemo1
+ (void)startTest {
    
    NSLock *lockA = [[NSLock alloc] init];
    NSLock *lockB = [[NSLock alloc] init];
    NSLock *lockC = [[NSLock alloc] init];
    
    [lockB lock];
    [lockC lock];
    
    dispatch_queue_t queueA = dispatch_queue_create("queue1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queueA, ^{
        for (int i = 0; i<10; i++) {
            [lockA lock];
            NSLog(@"A======= %@",@(i));
            [lockB unlock];
        }
    });
    
    dispatch_queue_t queueB = dispatch_queue_create("queue2", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queueB, ^{
        for (int i = 0; i<10; i++) {
            [lockB lock];
             NSLog(@"B======= %@",@(i));
            [lockC unlock];
        }
    });
    
    dispatch_queue_t queueC = dispatch_queue_create("queue3", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queueC, ^{
        for (int i = 0; i<10; i++) {
            [lockC lock];
             NSLog(@"C======= %@",@(i));
             NSLog(@"   ");
            [lockA unlock];
        }
    });

}

+ (void)startTest2 {
    NSLock *lockA = [[NSLock alloc] init];
    NSLock *lockB = [[NSLock alloc] init];
    NSLock *lockC = [[NSLock alloc] init];
    
    [lockB lock];
    [lockC lock];
    
    dispatch_queue_t queueA = dispatch_queue_create("queue1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queueB = dispatch_queue_create("queue2", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queueC = dispatch_queue_create("queue3", DISPATCH_QUEUE_CONCURRENT);
    
    
    dispatch_async(queueA, ^{
        for (int i = 0; i<10; i+=3) {
            [lockA lock];
            NSLog(@"%@======= %@", [NSThread currentThread], @(i));
            [lockB unlock];
        }
    });
    
    
    dispatch_async(queueB, ^{
        for (int i = 1; i<10; i+=3) {
            [lockB lock];
             NSLog(@"%@======= %@", [NSThread currentThread],@(i));
            [lockC unlock];
        }
    });
    
    
    dispatch_async(queueC, ^{
        for (int i = 2; i<10; i+=3) {
            [lockC lock];
             NSLog(@"%@======= %@", [NSThread currentThread],@(i));
            NSLog(@"    ");
            [lockA unlock];
        }
    });

    
}
@end
