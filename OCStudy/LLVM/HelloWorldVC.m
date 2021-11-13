//
//  HelloWorldVC.m
//  OCStudy
//
//  Created by dujia on 2021/4/17.
//

#import "HelloWorldVC.h"

@interface HelloWorldVC ()

@end

@implementation HelloWorldVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)helloworld {
    NSLog(@"hello world");
    
    self.age = 10;
    _btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_btn setTitle:@"按钮" forState:UIControlStateNormal];
    
    [_btn addTarget:self action:@selector(btnMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
}

- (void)btnMethod {
    self.age += 1;
}
@end
