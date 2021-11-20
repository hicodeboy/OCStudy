//
//  ViewController.m
//  OCStudy
//
//  Created by dujia on 2021/3/8.
//

#import "ViewController.h"
#import "OnceManagerA.h"
#import "OnceManagerB.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import <OCStudy-Swift.h>
#import "Thread/ThreadDemo1.h"
#import "CBConditionDemo.h"
#import "CBBaseLockDemo.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [OnceManagerA sharedInstance];
//    [OnceManagerB sharedInstance];
    
//    [ThreadDemo1 startTest2];
    CBBaseLockDemo *demo = [[CBConditionDemo alloc] init];
    [demo lockTest];
    
    
}


@end
