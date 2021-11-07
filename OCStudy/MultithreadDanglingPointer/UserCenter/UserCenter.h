//
//  UserCenter.h
//  OCStudy
//
//  Created by hicodeboy on 2021/6/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserCenter : NSObject
//@property (nonatomic, strong) NSString *test;
- (void)setObject:(id)obj forKey:(NSString *)key;
- (id)objectForKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
