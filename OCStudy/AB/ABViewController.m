//
//  ABViewController.m
//  OCStudy
//
//  Created by dujia on 2021/4/3.
//

#import "ABViewController.h"
#import "SkyLab.h"


@interface ABViewController ()


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;


@end

@implementation ABViewController

#define kScribbleDataPath [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/data"]

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    [SkyLab abTestWithName:@"Title" A:^{
//        self.titleLabel.text = NSLocalizedString(@"Hello, World!", nil);
//    } B:^{
//        self.titleLabel.text = NSLocalizedString(@"Greetings, Planet!", nil);
//    }];
    
    NSLog(@"%d", 36 % 5);
    
    
}
- (IBAction)resetTests:(id)sender {
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
