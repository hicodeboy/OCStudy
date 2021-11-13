//
//  LoopViewController.m
//  OCStudy
//
//  Created by dujia on 2021/6/4.
//

#import "LoopViewController.h"
#import "LoopShowView.h"
#import "LoopScrollImageView.h"
#import "ASRotationPageView.h"
@interface LoopViewController ()
@property (nonatomic, strong) ASRotationPageView *rotaView;
@end

@implementation LoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 1; i <= 3; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d", i]]];
        [images addObject:imageView];
    }
    
    
    [images insertObject:[[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"3"]]] atIndex:0];
    
    [images addObject:[[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"1"]]]];
    
    self.rotaView = [[ASRotationPageView alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 100)];
    self.rotaView.scrollDirection = ASRotationScrollDirectionVertical;
    self.rotaView.infiniteSliding = YES;
    self.rotaView.autoSliding = YES;
    
    self.rotaView.backgroundColor = [UIColor redColor];
    
    [self.rotaView updateContentDatas:images];
    
    [self.view addSubview:self.rotaView];
}

- (IBAction)update:(id)sender {
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 1; i <= 2; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d", i]]];
        [images addObject:imageView];
    }
    
    
    [images insertObject:[[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"2"]]] atIndex:0];
    
    [images addObject:[[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"1"]]]];
    [self.rotaView updateContentDatas:images];
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
