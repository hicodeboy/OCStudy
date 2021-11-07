//
//  UserCenter.m
//  OCStudy
//
//  Created by hicodeboy on 2021/6/16.
//

#import "UserCenter.h"

@interface UserCenter()
{
    // 定义一个并发队列
    dispatch_queue_t concurrent_queue;
    
    // 用户数据中心, 可能多个线程需要数据访问
    NSMutableDictionary *userCenterDic;
    NSString *_test;
}

@end

@implementation UserCenter

- (id)init
{
    self = [super init];
    if (self) {
        // 通过宏定义 DISPATCH_QUEUE_CONCURRENT 创建一个并发队列
        concurrent_queue = dispatch_queue_create("read_write_queue", DISPATCH_QUEUE_CONCURRENT);
        // 创建数据容器
        userCenterDic = [NSMutableDictionary dictionary];
    }
    
    return self;
}

//- (void)test {
//
//}

- (id)objectForKey:(NSString *)key
{
    
    __block id obj;
    // 同步读取指定数据
    dispatch_sync(concurrent_queue, ^{
        obj = [userCenterDic objectForKey:key];
    });
    
    return obj;
}

- (void)setObject:(id)obj forKey:(NSString *)key
{
    NSLog(@"%@", [NSThread currentThread]);
//    GCDMain(^{
//        [self willChangeValueForKey:@"test"];
//
//        NSLog(@"1111");
//        // 异步栅栏调用设置数据
//        dispatch_barrier_async(concurrent_queue, ^{
//            [self->userCenterDic setObject:obj forKey:key];
//            NSLog(@"3333");
//        });
//        NSLog(@"222");
//        [self didChangeValueForKey:@"test"];
//    });
//    [self safetyThread:^{
//        [self willChangeValueForKey:@"test"];
//
//        NSLog(@"1111");
//        // 异步栅栏调用设置数据
//        dispatch_barrier_async(concurrent_queue, ^{
//            [self->userCenterDic setObject:obj forKey:key];
//            NSLog(@"3333");
//        });
//        NSLog(@"222");
//        [self didChangeValueForKey:@"test"];
//    }];
}
- (void)safetyThread:(dispatch_block_t)block {
    
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            block();
        });
    }
}
@end
