//
//  MDPointer.h
//  OCStudy
//
//  Created by dujia on 2021/3/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MDPointer : NSObject
- (void)mdTest1;

- (void)mdTest2;

- (void)mdTest3;

- (void)mdTest4;

- (void)mdTest5;

- (void)hookAllPropertiesSetter;

- (void)quest1;

- (void)test1:(MDPointer *)pointer queue:(dispatch_queue_t)queue;
@end

NS_ASSUME_NONNULL_END
