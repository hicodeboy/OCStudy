//
//  DebounceViewController.m
//  OCStudy
//
//  Created by dujia on 2021/3/16.
//

#import "DebounceViewController.h"
#import "NSObject+Throttle.h"

@interface DebounceViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation DebounceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) + 1000)];
}


static int thro = 0;
- (void)testThrottle
{
    NSLog(@"thro is %d", thro);
    thro++;
}

static int withoutThro = 0;
- (void)testWithoutThrottle
{
    NSLog(@"withoutThro is %d", withoutThro);
    withoutThro++;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    [self testWithoutThrottle];
    [self wz_performSelector:@selector(testThrottle) withThrottle:0.25];
}

@end
