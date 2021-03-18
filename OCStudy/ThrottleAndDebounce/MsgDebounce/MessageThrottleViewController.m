//
//  MessageThrottleViewController.m
//  OCStudy
//
//  Created by dujia on 2021/3/16.
//

#import "MessageThrottleViewController.h"
#import "MessageThrottle.h"
#import <objc/runtime.h>
//#import <objc/message.h>
@interface MessageThrottleViewController ()
@property (nonatomic, strong) NSObject *flag;
@end

@implementation MessageThrottleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [MessageThrottle startTest];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
+ (void)load {
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = object_getClass(self);
        Method imgNameMethod = class_getClassMethod(class, @selector(runMethod2));
        Method cb_imgNameMethod = class_getClassMethod(class, @selector(cb_runMethod2));
        class_replaceMethod(class, @selector(cb_runMethod2), method_getImplementation(imgNameMethod), method_getTypeEncoding(cb_imgNameMethod));
        
        
    });
}


- (void)cb_runMethod2 {
    NSLog(@"cb_runMethod2");
}

- (void)runMethod2 {
    NSLog(@"runMethod2");
}

- (void)runMethod {
    NSLog(@"runMethod");
}

- (IBAction)btn2:(id)sender {
    [self cb_runMethod2];
}


// 最简单的函数防抖
- (IBAction)testBtn:(id)sender {
    NSObject *flag = [[NSObject alloc] init];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.flag = flag;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            if (flag == self.flag) {
                NSLog(@"ssss");
            }
        });
        
    });
}

@end
