//
//  AsyncDisplayViewController.m
//  OCStudy
//
//  Created by dujia on 2021/4/2.
//

#import "AsyncDisplayViewController.h"
#import "AsyncLabel.h"
#import "YYLabelT.h"

@interface AsyncDisplayViewController ()

@end

@implementation AsyncDisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    AsyncLabel *asLabel = [[AsyncLabel alloc] initWithFrame:CGRectMake(50, 100, 200, 200)];
//    asLabel.backgroundColor = [UIColor cyanColor];
//    asLabel.asynBGColor = [UIColor greenColor];
//    asLabel.asynFont = [UIFont systemFontOfSize:16 weight:20];
//    asLabel.asynText = @"学习异步绘制相关知识点, 学习异步绘制相关知识点";
//    [self.view addSubview:asLabel];
//    ///不调用的话不会触发 displayLayer方法
//    [asLabel.layer setNeedsDisplay];
    
    YYLabelT *label = [[YYLabelT alloc] initWithFrame:CGRectMake(50, 100, 200, 100)];
    label.text = @"ssss";
    label.font = [UIFont systemFontOfSize:15];
    label.backgroundColor = [UIColor grayColor];
    [self.view addSubview:label];
    
    YYLabelT *label1 = [[YYLabelT alloc] initWithFrame:CGRectMake(50, 400, 200, 100)];
    label1.text = @"qqqqq";
    label1.font = [UIFont systemFontOfSize:15];
    label1.backgroundColor = [UIColor grayColor];
    [self.view addSubview:label1];
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
