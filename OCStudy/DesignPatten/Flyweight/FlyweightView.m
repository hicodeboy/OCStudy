//
//  FlyweightView.m
//  Flyweight
//
//  Created by Carlo Chung on 11/29/10.
//  Copyright 2010 Carlo Chung. All rights reserved.
//

#import "FlyweightView.h"
#import "ExtrinsicFlowerState.h"


@implementation ExFlowerState


@end
@implementation FlyweightView

@synthesize flowerList=flowerList_;

extern NSString *FlowerObjectKey, *FlowerLocationKey;

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect 
{
  // Drawing code
    [super drawRect:rect];
  for (ExFlowerState *stateValue in flowerList_)
  {
    
    
    UIView *flowerView = stateValue.flowerView;
    CGRect area = stateValue.area;
    
    [flowerView drawRect:area];
  }
}


@end
