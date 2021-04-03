//
//  AsyncLabel.h
//  OCStudy
//
//  Created by dujia on 2021/4/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AsyncLabel : UIView
@property (nonatomic, copy)     NSString    *asynText;
@property (nonatomic, strong)   UIFont      *asynFont;
@property (nonatomic, strong)   UIColor     *asynBGColor;
@end

NS_ASSUME_NONNULL_END
