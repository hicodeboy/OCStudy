//
//  FlyweightViewController.m
//  OCStudy
//
//  Created by hello on 2021/4/3.
//

#import "FlyweightViewController.h"
#import "FlowerFactory.h"
#import "ExtrinsicFlowerState.h"
#import "FlyweightView.h"
@interface FlyweightViewController ()

@end

@implementation FlyweightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // construct a flower list
    self.view = [[FlyweightView alloc] init];
    FlowerFactory *factory = [[FlowerFactory alloc] init] ;
    NSMutableArray *flowerList = [[NSMutableArray alloc]
                                   initWithCapacity:500] ;
    
    for (int i = 0; i < 500; ++i)
    {
      // retrieve a shared instance
      // of a flower flyweight object
      // from a flower factory with a
      // random flower type
      FlowerType flowerType = arc4random() % kTotalNumberOfFlowerTypes;
      UIView *flowerView = [factory flowerViewWithType:flowerType];
      
      // set up a location and an area for the flower
      // to display onscreen
      CGRect screenBounds = [[UIScreen mainScreen] bounds];
      CGFloat x = (arc4random() % (NSInteger)screenBounds.size.width);
      CGFloat y = (arc4random() % (NSInteger)screenBounds.size.height);
      NSInteger minSize = 10;
      NSInteger maxSize = 50;
      CGFloat size = (arc4random() % (maxSize - minSize + 1)) + minSize;

      // assign attributes for a flower
      // to an extrinsic state object
      ExtrinsicFlowerState extrinsicState;
      extrinsicState.flowerView = flowerView;
      extrinsicState.area = CGRectMake(x, y, size, size);
        
        ExFlowerState *f = [[ExFlowerState alloc] init];
        f.flowerView = flowerView;
        f.area = CGRectMake(x, y, size, size);
      
      // add an extrinsic flower state
      // to the flower list
      [flowerList addObject:f];
    }
    [(FlyweightView *)self.view setFlowerList:flowerList];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
