//
//  ThrottleAndDebounce.h
//  OCStudy
//
//  Created by hicodeboy on 2021/11/13.
//  Copyright © 2021 Location. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, ThrottleMode) {
    ThrottleModeBefore,
    ThrottleModeLast
};

NS_ASSUME_NONNULL_BEGIN
typedef void(^DebounceBlock)(void);
typedef void(^ThrottleBlock)(void);


@interface ThrottleAndDebounce : NSObject

@end

@interface Debounce : NSObject
- (void)debounce:(DebounceBlock)debounce;
@end

@interface Throttle : NSObject
- (void)throttle:(ThrottleBlock)throttle mode:(ThrottleMode)mode;
@end

NS_ASSUME_NONNULL_END
