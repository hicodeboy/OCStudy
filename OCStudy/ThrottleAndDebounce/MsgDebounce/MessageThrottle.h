//
//  MessageThrottle.h
//  OCStudy
//
//  Created by dujia on 2021/3/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^DebounceBlock)(void);
@interface MessageThrottle : NSObject
+ (void)startTest;
@end

@interface MessageDebounce : NSObject
- (void)debounce:(DebounceBlock)debounce;
@end

NS_ASSUME_NONNULL_END
