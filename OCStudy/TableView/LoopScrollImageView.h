//
//  LoopScrollImageView.h
//  OCStudy
//
//  Created by dujia on 2021/6/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoopScrollImageView : UIView <UIScrollViewDelegate>
@property (nonatomic, retain) NSTimer * timer;  //设置定时器

@property (nonatomic, retain) UIScrollView * scrollView;
@property (nonatomic, retain) UIPageControl * pageControl;
@property (nonatomic, retain) UILabel * currentPageLabel;

@property (nonatomic, retain) NSArray * dataSource;


- (id) initWithFrame:(CGRect)frame images:(NSArray *)images;

- (void) startTimer;
- (void) stopTimer;


@end

NS_ASSUME_NONNULL_END
