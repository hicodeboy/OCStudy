//
//  OnceManagerC.m
//  OCStudy
//
//  Created by dujia on 2021/3/15.
//

#import "OnceManagerC.h"
#import "OnceManagerA.h"
@implementation OnceManagerC
+ (OnceManagerC *)sharedInstance {
    static OnceManagerC *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[OnceManagerC alloc] init];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [OnceManagerA sharedInstance];
    }
    return self;
}
@end
