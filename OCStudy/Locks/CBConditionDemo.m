//
//  CBConditionDemo.m
//  OCStudy
//
//  Created by hicodeboy on 2021/11/20.
//

#import "CBConditionDemo.h"

@interface CBConditionDemo()
@property (strong, nonatomic) NSCondition *condition;
@property (strong, nonatomic) NSMutableArray *data;
@end

@implementation CBConditionDemo
- (instancetype)init
{
    if (self = [super init]) {
        self.condition = [[NSCondition alloc] init];
        self.data = [NSMutableArray array];
    }
    return self;
}

- (void)lockTest
{
    [[[NSThread alloc] initWithTarget:self selector:@selector(_removeData) object:nil] start];
    
    [[[NSThread alloc] initWithTarget:self selector:@selector(_addData) object:nil] start];
}

// 线程1
// 删除数组中的元素
- (void)_removeData
{
    [self.condition lock];
    NSLog(@"删除 - 开始");
    
    if (self.data.count == 0) {
        // 等待
        [self.condition wait];
    }
    
    [self.data removeLastObject];
    NSLog(@"删除 元素");
    
    [self.condition unlock];
}

// 线程2
// 往数组中添加元素
- (void)_addData
{
    [self.condition lock];
    
    sleep(1);
    
    [self.data addObject:@"Hello"];
    NSLog(@"添加元素");
    
    // 信号
    [self.condition signal];
    NSLog(@"释放信号");
    sleep(2);
    NSLog(@"等待结束");
    
    [self.condition unlock];
    
}
@end
