//
//  MessageThrottle.h
//  OCStudy
//
//  Created by hicodeboy on 2021/3/16.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ThrottleMode) {
    ThrottleModeBefore,
    ThrottleModeLast
};

NS_ASSUME_NONNULL_BEGIN
typedef void(^DebounceBlock)(void);
typedef void(^ThrottleBlock)(void);
@interface MessageThrottle : NSObject
+ (void)startTest;
- (void)throttle:(ThrottleBlock)throttle;
@end

@interface MessageDebounce : NSObject
- (void)debounce:(DebounceBlock)debounce;
@end

NS_ASSUME_NONNULL_END
