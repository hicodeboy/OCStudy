//
//  OnceManagerA.m
//  OCStudy
//
//  Created by dujia on 2021/3/15.
//

#import "OnceManagerA.h"
#import "OnceManagerB.h"

@implementation OnceManagerA

+ (OnceManagerA *)sharedInstance {
    static OnceManagerA *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[OnceManagerA alloc] init];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [OnceManagerB sharedInstance];
    }
    return self;
}

@end
