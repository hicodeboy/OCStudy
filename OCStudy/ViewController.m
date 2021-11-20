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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [OnceManagerA sharedInstance];
//    [OnceManagerB sharedInstance];
    
    [ThreadDemo1 startTest2];
    
}


@end
