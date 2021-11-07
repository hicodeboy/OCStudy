//
//  UserCenterViewController.m
//  OCStudy
//
//  Created by hicodeboy on 2021/6/16.
//

#import "UserCenterViewController.h"
#import "UserCenter.h"

@interface UserCenterViewController ()
@property (nonatomic, strong) UserCenter *userCenter;
@end

@implementation UserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.userCenter = [[UserCenter alloc] init];
    
    [self.userCenter addObserver:self forKeyPath:@"test" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%@", [NSThread currentThread]);
}
- (IBAction)tap:(id)sender {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self.userCenter setObject:@"aaaaa" forKey:@"a"];
    });
    
    
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
