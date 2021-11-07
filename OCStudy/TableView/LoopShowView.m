//
//  LoopShowView.m
//  OCStudy
//
//  Created by dujia on 2021/6/4.
//

#import "LoopShowView.h"

@interface LoopShowView()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation LoopShowView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        _scrollView.backgroundColor = [UIColor redColor];
        _scrollView.contentSize = CGSizeMake(CGRectGetWidth(frame), CGRectGetHeight(frame) * 3);
        [self addSubview:_scrollView];
    }
    return self;
}





@end
