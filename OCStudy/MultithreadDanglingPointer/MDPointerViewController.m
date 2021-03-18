//
//  MDPointerViewController.m
//  OCStudy
//
//  Created by dujia on 2021/3/8.
//

#import "MDPointerViewController.h"
#import "MDPointer.h"
#import "OnceManagerA.h"
#import "OnceManagerB.h"

@interface MDPointerViewController ()

@property (nonatomic, strong) MDPointer *mdPointer;

@end

@implementation MDPointerViewController {
    dispatch_queue_t queue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mdPointer = [[MDPointer alloc] init];
    // Do any additional setup after loading the view.
    
    [OnceManagerA sharedInstance];
    
}
- (IBAction)mdTest1:(id)sender {
    queue = dispatch_queue_create("hello", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        [self.mdPointer mdTest1];
    });

  
}
- (IBAction)mdTest2:(id)sender {
//    dispatch_async(queue, ^{
//        [self.mdPointer mdTest3];
//    });
    [self.mdPointer hookAllPropertiesSetter];
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
