//
//  NSObject+Throttle.h
//  OCStudy
//
//  Created by dujia on 2021/3/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Throttle)
- (void)wz_performSelector:(SEL)aSelector withThrottle:(NSTimeInterval)inteval;

@end

NS_ASSUME_NONNULL_END
