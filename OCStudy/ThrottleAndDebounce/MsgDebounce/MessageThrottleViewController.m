//
//  MessageThrottleViewController.m
//  OCStudy
//
//  Created by dujia on 2021/3/16.
//

#import "MessageThrottleViewController.h"
#import "MessageThrottle.h"
#import <objc/runtime.h>
@interface MessageThrottleViewController ()
@property (nonatomic, strong) NSObject *flag;
@property (nonatomic, strong) MessageDebounce *debounce;
@end

@implementation MessageThrottleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [MessageThrottle startTest];
    
    _debounce = [[MessageDebounce alloc] init];
}

+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Class class = [self class];
//        // When swizzling a class method, use the following:
//        // Class class = object_getClass((id)self);
//        SEL originalSelector = @selector(runMethod2);
//        SEL swizzledSelector = @selector(cb_runMethod2);
//
//
//        Method originalMethod = class_getInstanceMethod(class, originalSelector);
//        class_addMethod(class,
//                        swizzledSelector,
//                        method_getImplementation(originalMethod),
//                        method_getTypeEncoding(originalMethod));
//        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
//        class_addMethod(cls, NSSelectorFromString(MTForwardInvocationSelectorName), originalImplementation, "v@:@");
       
//        BOOL didAddMethod =
//        class_addMethod(class,
//                        originalSelector,
//                        method_getImplementation(swizzledMethod),
//                        method_getTypeEncoding(swizzledMethod));
        
//        if (didAddMethod) {
//            class_replaceMethod(class,
//                                swizzledSelector,
//                                method_getImplementation(originalMethod),
//                                method_getTypeEncoding(originalMethod));
//        } else {
//            method_exchangeImplementations(originalMethod, swizzledMethod);
//        }
//    });
    
}



- (void)forwardInvocation:(NSInvocation *)anInvocation {
    
}

- (void)ym_imageNamed:(NSString *)str {
    NSLog(@"ym_imageNamed");
}

//- (void)cb_runMethod2 {
//    NSLog(@"cb_runMethod2");
//}

- (void)runMethod2 {
    NSLog(@"runMethod2");
}

- (void)runMethod {
    NSLog(@"runMethod");
}

- (IBAction)btn2:(id)sender {
    
//    [UIImage imageNamed:@"ss"];
    [self runMethod2];
}


// 最简单的函数防抖


- (IBAction)testBtn:(id)sender {
    [_debounce debounce:^{
        NSLog(@"防抖处理");
    }];
//    NSObject *flag = [[NSObject alloc] init];
//
//    dispatch_async(dispatch_get_main_queue(), ^{
//        self.flag = flag;
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//            if (flag == self.flag) {
//                NSLog(@"防抖处理");
//            }
//        });
//
//    });
}

@end
