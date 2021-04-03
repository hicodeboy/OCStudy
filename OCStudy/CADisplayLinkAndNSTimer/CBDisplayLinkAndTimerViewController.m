//
//  CBDisplayLinkAndTimerViewController.m
//  OCStudy
//
//  Created by dujia on 2021/3/29.
//

#import "CBDisplayLinkAndTimerViewController.h"

@interface CBDisplayLinkAndTimerViewController ()
@property (nonatomic, strong) CADisplayLink *link;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation CBDisplayLinkAndTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(linkTest)];
//    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerTest) userInfo:nil repeats:YES];
    __weak typeof(self) weakSelf = self;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [weakSelf timerTest];
    }];
}

- (void)timerTest {
        
    NSLog(@"%s   %@", __func__, [NSThread currentThread]);
}

- (void)linkTest {
        
    NSLog(@"%s   %@", __func__, [NSThread currentThread]);
}

- (void)dealloc {
//    [self.link invalidate];
    [self.timer invalidate];
    NSLog(@"%s", __func__);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
