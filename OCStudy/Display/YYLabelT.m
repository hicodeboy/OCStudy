//
//  YYLabelT.m
//  OCStudy
//
//  Created by dujia on 2021/4/2.
//

#import "YYLabelT.h"
#import <YYAsyncLayer/YYAsyncLayer.h>
#import <CoreText/CoreText.h>
@implementation YYLabelT

- (void)setText:(NSString *)text {
    _text = text;
    [[YYTransaction transactionWithTarget:self selector:@selector(contentsNeedUpdated)] commit];
}

- (void)setFont:(UIFont *)font {
    _font = font;
    [[YYTransaction transactionWithTarget:self selector:@selector(contentsNeedUpdated)] commit];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [[YYTransaction transactionWithTarget:self selector:@selector(contentsNeedUpdated)] commit];
}

- (void)contentsNeedUpdated {
    [self.layer setNeedsDisplay];
}

+ (Class)layerClass {
    return YYAsyncLayer.class;
}

- (YYAsyncLayerDisplayTask *)newAsyncDisplayTask {
    NSString *text = _text;
    UIFont *font = _font;
    YYAsyncLayerDisplayTask *task = [YYAsyncLayerDisplayTask new];
    task.willDisplay = ^(CALayer * _Nonnull layer) {
        
    };
    
    task.display = ^(CGContextRef  _Nonnull context, CGSize size, BOOL (^ _Nonnull isCancelled)(void)) {
        if (isCancelled()) return;
        //在这里由于绘制文字会颠倒
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            CGContextSetTextMatrix(context, CGAffineTransformIdentity);
            CGContextTranslateCTM(context, 0, self.bounds.size.height);
            CGContextScaleCTM(context, 1.0, -1.0);
        }];
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, NULL, CGRectMake(0, 0, size.width, size.height));
        NSAttributedString* str = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:_font}];
        CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)str);
        CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, str.length), path, NULL);
        CTFrameDraw(frame, context);
        
    };
    
    task.didDisplay = ^(CALayer * _Nonnull layer, BOOL finished) {
        
    };
    return task;
}


@end
