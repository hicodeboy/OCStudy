//
//  HelloWorldVC.h
//  OCStudy
//
//  Created by dujia on 2021/4/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HelloWorldVC : UIViewController

@property (nonatomic, assign) int age;
@property (nonatomic, strong) UIButton *btn;
- (void)helloworld;

@end

NS_ASSUME_NONNULL_END
