//
//  BlockDemo.m
//  OCStudy
//
//  Created by dujia on 2021/8/29.
//

#import "BlockDemo.h"
#import "CBBlockObject.h"

@implementation BlockDemo
typedef void (^CBBlock) (void);
- (void)viewDidLoad {
    [super viewDidLoad];
    [self startTest];
}
- (void)startTest {
    CBBlock block;
//    @autoreleasepool
    {
        CBBlockObject *obj = [[CBBlockObject alloc] init];
        __block __weak CBBlockObject *obj1 = obj;
        block = [^{
            NSLog(@"%p", obj1);
        } copy];
    }
    
    
    
    
    block();
    
}

@end
