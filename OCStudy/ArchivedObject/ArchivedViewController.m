//
//  ArchivedViewController.m
//  OCStudy
//
//  Created by dujia on 2021/4/6.
//

#import "ArchivedViewController.h"
#import "Vertex.h"

@interface ArchivedViewController ()

@end

@implementation ArchivedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSData *data = [self archiveData];
    NSLog(@"data = %@", data);
    id dic = [self unarchiveData:data];
    NSLog(@"dic = %@", dic);
    
}


- (NSData *)archiveData {
    NSDictionary *dic = @{@"name": @"xiaoming"};
    Vertex* v = [[Vertex alloc] init];
    v.location = CGPointMake(100, 100);
    return [NSKeyedArchiver archivedDataWithRootObject:v requiringSecureCoding:NO error:nil];
}

- (id)unarchiveData:(NSData *)data {
    id dic = [NSKeyedUnarchiver unarchivedObjectOfClass:[Vertex class] fromData:data error:nil];
    return dic;
    
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
