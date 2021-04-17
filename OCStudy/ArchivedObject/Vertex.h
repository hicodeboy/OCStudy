//
//  Vertex.h
//  OCStudy
//
//  Created by dujia on 2021/4/16.
//

#import <UIKit/UIKit.h>

@protocol Mark <NSObject, NSCopying, NSCoding>



@end

NS_ASSUME_NONNULL_BEGIN

@interface Vertex : NSObject <Mark>
@property (nonatomic, assign) CGPoint location;
@end

NS_ASSUME_NONNULL_END
