//
//  ASRotationPageView.m
//  HeJiaKang
//
//  Created by OneForAll on 2017/12/15.
//  Copyright © 2017年 OneForAll. All rights reserved.
//

#import "ASRotationPageView.h"
#import <UIImageView+WebCache.h>
#import <QuartzCore/QuartzCore.h>


@interface ASRotationPageView () <UIScrollViewDelegate>

/** 滑动视图 */
@property (nonatomic, strong) UIScrollView *scrollView;

/**  图片地址   可是网络地址也可以是本地地址 */
@property (nonatomic, copy) NSArray *imagesArr;

/**  变化后的图片地址数组  */
@property (nonatomic, strong) NSMutableArray * showImagesArr;

/** 自动轮播时间器 */
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation ASRotationPageView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeData];
    }
    return self;
}
- (void)updateContentDatas:(NSArray *)datas {
    self.imagesArr = datas;
    [self.timer invalidate];
    for (UIView *item in self.scrollView.subviews) {
        [item removeFromSuperview];
    }
    [self showStart];
}
- (void)showStart {
    //不是无限轮播，不能自动播
    if (self.infiniteSliding == NO) {
        self.autoSliding = NO;
    }
    [self initializeView];
}
- (void)initializeData {
    self.infiniteSliding = YES;
    self.scrollDirection = ASRotationScrollDirectionHorizontal;
    self.autoSliding = YES;
    self.scrollEnabled = YES;
    self.scrollTimeInterval = 1;
}
- (void)initializeView {
    //无限轮播前后添加图片
    if (self.imagesArr.count == 1) self.infiniteSliding = NO;
    self.showImagesArr = [NSMutableArray arrayWithArray:self.imagesArr];
    self.scrollView.scrollEnabled = self.scrollEnabled;
    //创建imageView
    for (int i = 0; i<self.showImagesArr.count; i++) {
        UIView *imageView = self.showImagesArr[i];
        imageView.tag = 100 + i;
        imageView.userInteractionEnabled = YES;
        
        switch (self.scrollDirection) {
            case ASRotationScrollDirectionHorizontal:
                imageView.frame = CGRectMake(self.frame.size.width * i, 0, self.frame.size.width, self.frame.size.height);
                break;
            default:
                imageView.frame = CGRectMake(0, i * self.frame.size.height, self.frame.size.width, self.frame.size.height);

                break;
        }
        [self.scrollView addSubview:imageView];

    }
    [self addSubview:self.scrollView];
    //计时器
    if (self.autoSliding) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.scrollTimeInterval target:self selector:@selector(rotationScrollView) userInfo:nil repeats:YES];

    }
    
}

#pragma mark ------------  timer方法  -------------------
- (void)rotationScrollView {
    switch (self.scrollDirection) {
        case ASRotationScrollDirectionHorizontal:{
            float offset_X = self.scrollView.contentOffset.x;
            //每次切换一个屏幕
            [self.scrollView setContentOffset:CGPointMake(offset_X+self.frame.size.width, 0) animated:YES];
        }
            break;
        default:{
            float offset_Y = self.scrollView.contentOffset.y;
            //每次切换一个屏幕
            [self.scrollView setContentOffset:CGPointMake(0, offset_Y+self.frame.size.height) animated:YES];
        }
            break;
    }
   
}
#pragma mark -----------   懒加载 -----------------------

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        switch (self.scrollDirection) {
            case ASRotationScrollDirectionHorizontal:
                _scrollView.contentSize = CGSizeMake(self.frame.size.width * self.showImagesArr.count, self.frame.size.height);
                if (self.infiniteSliding) {
                    [_scrollView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
                }else {//关闭弹簧效果
                    _scrollView.bounces = NO;

                }
                break;
            default:
                _scrollView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height * self.showImagesArr.count);
                if (self.infiniteSliding) {
                    [_scrollView setContentOffset:CGPointMake(0, self.frame.size.height) animated:NO];
                } else {
                    _scrollView.bounces = NO;
                }
                break;
        }
        
        if (@available(iOS 11.0, *)) {
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        self.currentPage = 0;
    }
    return _scrollView;
}


#pragma mark ----------------  setter ----------------------

- (void)setContentOffsetPage:(NSUInteger)contentOffsetPage{
    if ((self.showImagesArr.count - 2) <= contentOffsetPage)  return;
    if (self.infiniteSliding) {
        switch (self.scrollDirection) {
            case ASRotationScrollDirectionHorizontal:{
                [self.scrollView setContentOffset:CGPointMake(self.frame.size.width*contentOffsetPage+1, 0)animated:YES];
                self.currentPage = contentOffsetPage;
            }
                break;
            default:
                [self.scrollView setContentOffset:CGPointMake(0, self.frame.size.height*contentOffsetPage+1)animated:YES];
                self.currentPage = contentOffsetPage;
                break;
        }
        //视图静止之后，过2秒在开启定时器
        if(self.timer) [self.timer setFireDate:[NSDate dateWithTimeInterval:2 sinceDate:[NSDate date]]];
    } else {
        switch (self.scrollDirection) {
            case ASRotationScrollDirectionHorizontal:{
                [self.scrollView setContentOffset:CGPointMake(self.frame.size.width*contentOffsetPage, 0)animated:YES];
                self.currentPage = contentOffsetPage;
                
            }
                break;
                
            default:{
                [self.scrollView setContentOffset:CGPointMake(0, self.frame.size.height*contentOffsetPage)animated:YES];
                self.currentPage = contentOffsetPage;
                
            }
                break;
        }
    }
}
#pragma mark --------------- scrollViewDelegate ----------------

//减速停止了时执行，手触摸时执行执行
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.infiniteSliding) {
        switch (self.scrollDirection) {
            case ASRotationScrollDirectionHorizontal:{
                //滑动到第一个切换到最后一个
                if (scrollView.contentOffset.x >= self.frame.size.width*(self.showImagesArr.count-1)) {
                    [scrollView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
                }else if (scrollView.contentOffset.x <= 0) {//滑动到最后个切换到第一个
                    [scrollView setContentOffset:CGPointMake(self.frame.size.width*(self.showImagesArr.count-2), 0) animated:NO];
                }
                int page =  scrollView.contentOffset.x/self.frame.size.width;
                self.currentPage = page-1;
            }
                break;
            default:
                //滑动到第一个切换到最后一个
                if (scrollView.contentOffset.y >= self.frame.size.height*(self.showImagesArr.count-1)) {
                    [scrollView setContentOffset:CGPointMake(0, self.frame.size.height) animated:NO];
                }else if (scrollView.contentOffset.y <= 0) {//滑动到最后个切换到第一个
                    [scrollView setContentOffset:CGPointMake(0, self.frame.size.height*(self.showImagesArr.count-2)) animated:NO];
                }
                int page =  scrollView.contentOffset.y/self.frame.size.height;
                self.currentPage = page-1;
                break;
        }
        //视图静止之后，过2秒在开启定时器
        if(self.timer) [self.timer setFireDate:[NSDate dateWithTimeInterval:2 sinceDate:[NSDate date]]];
    } else {
        switch (self.scrollDirection) {
            case ASRotationScrollDirectionHorizontal:{
                int page =  scrollView.contentOffset.x/self.frame.size.width;
                self.currentPage = page;
                
            }
                break;
                
            default:{
                int page =  scrollView.contentOffset.x/self.frame.size.height;
                self.currentPage = page;
                
            }
                break;
        }
    }
    if (self.ScrollDidEnd) self.ScrollDidEnd(self.currentPage);
}

//开始拖拽的代理方法，在此方法中暂停定时器。
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //关闭定时器
    if(self.timer) [self.timer setFireDate:[NSDate distantFuture]];
}

//滚动动画停止时执行,代码改变时出发,也就是setContentOffset改变时
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (self.infiniteSliding) {
        switch (self.scrollDirection) {
            case ASRotationScrollDirectionHorizontal:{
                //滑动到第一个切换到最后一个
                if (scrollView.contentOffset.x >= self.frame.size.width*(self.showImagesArr.count-1)) {
                    [scrollView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
                }else if (scrollView.contentOffset.x <= 0) {//滑动到最后个切换到第一个
                    [scrollView setContentOffset:CGPointMake(self.frame.size.width*(self.showImagesArr.count-2), 0) animated:NO];
                }
                int page =  scrollView.contentOffset.x/self.frame.size.width;
                self.currentPage = page-1;
            }
                break;
            default:
                //滑动到第一个切换到最后一个
                if (scrollView.contentOffset.y >= self.frame.size.height*(self.showImagesArr.count-1)) {
                    [scrollView setContentOffset:CGPointMake(0, self.frame.size.height) animated:NO];
                }else if (scrollView.contentOffset.y <= 0) {//滑动到最后个切换到第一个
                    [scrollView setContentOffset:CGPointMake(0, self.frame.size.height*(self.showImagesArr.count-2)) animated:NO];
                }
                int page =  scrollView.contentOffset.y/self.frame.size.height;
                self.currentPage = page-1;
                break;
        }
    } else {
        switch (self.scrollDirection) {
            case ASRotationScrollDirectionHorizontal:{
                int page =  scrollView.contentOffset.x/self.frame.size.width;
                self.currentPage = page;
                
            }
                break;
                
            default:{
                int page =  scrollView.contentOffset.y/self.frame.size.height;
                self.currentPage = page;
                
            }
                break;
        }
       
    }
    if (self.ScrollDidEnd) self.ScrollDidEnd(self.currentPage);

    
}
- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
}
@end
