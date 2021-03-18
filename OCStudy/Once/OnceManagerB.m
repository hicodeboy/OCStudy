//
//  OnceManagerB.m
//  OCStudy
//
//  Created by dujia on 2021/3/15.
//

#import "OnceManagerB.h"
#import "OnceManagerC.h"
@implementation OnceManagerB
+ (OnceManagerB *)sharedInstance {
    static OnceManagerB *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[OnceManagerB alloc] init];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [OnceManagerC sharedInstance];
    }
    return self;
}
@end
