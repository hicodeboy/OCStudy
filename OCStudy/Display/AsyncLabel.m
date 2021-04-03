//
//  AsyncLabel.m
//  OCStudy
//
//  Created by dujia on 2021/4/2.
//

#import "AsyncLabel.h"
#import <CoreText/CoreText.h>

@interface AsyncLabel()


@end

@implementation AsyncLabel
- (void)displayLayer:(CALayer *)layer {
    /**
         除了在drawRect方法中, 其他地方获取context需要自己创建[https://www.jianshu.com/p/86f025f06d62]
         coreText用法简介:[https://www.cnblogs.com/purple-sweet-pottoes/p/5109413.html]
         */

    CGSize size = self.bounds.size;;
          CGFloat scale = [UIScreen mainScreen].scale;
        ///异步绘制:切换至子线程
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            UIGraphicsBeginImageContextWithOptions(size, NO, scale);
            ///获取当前上下文
            CGContextRef context = UIGraphicsGetCurrentContext();
            ///将坐标系反转
            CGContextSetTextMatrix(context, CGAffineTransformIdentity);
            ///文本沿着Y轴移动
            CGContextTranslateCTM(context, 0, size.height);
            ///文本反转成context坐标系
            CGContextScaleCTM(context, 1.0, -1.0);
            ///创建绘制区域
            CGMutablePathRef path = CGPathCreateMutable();
            CGPathAddRect(path, NULL, CGRectMake(0, 0, size.width, size.height));
            ///创建需要绘制的文字
            NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:self.asynText];
            [attStr addAttribute:NSFontAttributeName value:self.asynFont range:NSMakeRange(0, self.asynText.length)];
            [attStr addAttribute:NSBackgroundColorAttributeName value:self.asynBGColor range:NSMakeRange(0, self.asynText.length)];
            ///根据attStr生成CTFramesetterRef
            CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attStr);
            CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, attStr.length), path, NULL);
            ///将frame的内容绘制到content中
            CTFrameDraw(frame, context);
            UIImage *getImg = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            ///子线程完成工作, 切换到主线程展示
            dispatch_async(dispatch_get_main_queue(), ^{
                self.layer.contents = (__bridge id)getImg.CGImage;
            });
        });
}

@end
