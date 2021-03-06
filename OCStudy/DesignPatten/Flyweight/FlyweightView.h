//
//  FlyweightView.h
//  Flyweight
//
//  Created by Carlo Chung on 11/29/10.
//  Copyright 2010 Carlo Chung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExFlowerState : NSObject
@property (nonatomic, strong) UIView *flowerView;
@property (nonatomic, assign) CGRect area;

@end

@interface FlyweightView : UIView 
{
  @private
  NSArray *flowerList_;
}

@property (nonatomic, retain) NSArray *flowerList;

@end
