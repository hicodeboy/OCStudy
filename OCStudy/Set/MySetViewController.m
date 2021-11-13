//
//  MySetViewController.m
//  OCStudy
//
//  Created by dujia on 2021/6/8.
//

#import "MySetViewController.h"


@interface MySetObj : NSObject
@property (nonatomic, assign) long long myid;

@property (nonatomic, assign) long long time;
@property (nonatomic, assign) long long level;
@end

@implementation MySetObj
- (BOOL)isEqual:(MySetObj *)object {
    return self.myid == object.myid;
}

- (NSUInteger)hash {
    return self.myid;
}

@end

@interface MySetViewController ()
@property (nonatomic, strong) NSMutableOrderedSet <MySetObj *>* oSet;

@end

@implementation MySetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MySetObj *o1 = [[MySetObj alloc] init];
    o1.level = 1;
    o1.myid = 111;
    o1.time = 1111;
    
    MySetObj *o2 = [[MySetObj alloc] init];
    o2.level = 3;
    o2.myid = 222;
    o2.time = 1111;
    
    MySetObj *o3 = [[MySetObj alloc] init];
    o3.level = 3;
    o3.myid = 333;
    o3.time = 111;
    
    _oSet = [[NSMutableOrderedSet alloc] init];
    [_oSet addObject:o1];
    [_oSet addObject:o2];
    [_oSet addObject:o3];
    
    
    [_oSet sortUsingComparator:^NSComparisonResult(MySetObj *  _Nonnull obj1, MySetObj *  _Nonnull obj2) {
        if (obj1.level == obj2.level) {
            return obj1.time > obj2.time;
        }
        return obj1.level < obj2.level;
        
    }];
    for (int i = 0; i < _oSet.count; i++) {
        MySetObj *o = _oSet[i];
        NSLog(@"%d %d %d", o.myid, o.level, o.time);
    }
    
    
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
