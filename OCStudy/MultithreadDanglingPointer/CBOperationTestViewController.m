//
//  CBOperationTestViewController.m
//  OCStudy
//
//  Created by dujia on 2021/3/26.
//

#import "CBOperationTestViewController.h"
#import "PPOperation.h"
#import <SDWebImage/SDWebImage.h>
@interface CBOperationTestViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation CBOperationTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self downloadImageDemo1];
}

// 这种创建Operation(NSBlockOperation/NSInvocationOperation), 然后直接调用start(), 会在当前线程中执行task.(类似于创建一个block,然后直接调用block()).

- (void)operationStartDemo2 {
    NSLog(@"start ---- %@", [NSThread currentThread]);
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task2) object:nil];
    [op start];
    NSLog(@"end--- %@", [NSThread currentThread]);
}

- (void)task2 {
    for (int i = 0; i < 2; i++) {
        [NSThread sleepForTimeInterval:2];// 模拟耗时操作
        NSLog(@"%d --- %@", i, [NSThread currentThread]);
    }
}

- (void)operationStartDemo3 {
    NSLog(@"start --- %@", [NSThread currentThread]);
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];// 模拟耗时操作
            NSLog(@"%d --- %@", i, [NSThread currentThread]);
        }
    }];
    [op start];
    NSLog(@"end--- %@", [NSThread currentThread]);
}

- (void)blockOperationAndOperationDemo {
    NSLog(@"start--- %@", [NSThread currentThread]);
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];// 模拟耗时操作
            NSLog(@"%d --- %@", i, [NSThread currentThread]);
        }
    }];
    
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];// 模拟耗时操作
            NSLog(@"2--- %@", [NSThread currentThread]);
        }
    }];
    
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];// 模拟耗时操作
            NSLog(@"3--- %@", [NSThread currentThread]);
        }
    }];
    
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];// 模拟耗时操作
            NSLog(@"3--- %@", [NSThread currentThread]);
        }
    }];
    [op start];
    NSLog(@"end--- %@", [NSThread currentThread]);
    
}

- (void)NSOperationCompletion1 {
    NSLog(@"start--- %@", [NSThread currentThread]);
    NSOperationQueue *oq = [NSOperationQueue new];
    NSBlockOperation *op =[NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];// 模拟耗时操作
            NSLog(@"%d --- %@", i, [NSThread currentThread]);
        }
    }];
    [op setCompletionBlock:^{
        NSLog(@"operation end --- %@",[NSThread currentThread]); // 打印当前线程
    }];
    
    [oq addOperation:op];
    NSLog(@"end--- %@", [NSThread currentThread]);
}

- (void)NSOperationCompletion2 {
    NSLog(@"start--- %@", [NSThread currentThread]);
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];// 模拟耗时操作
            NSLog(@"%d --- %@", i, [NSThread currentThread]);
        }
    }];
    
    [op setCompletionBlock:^{
        NSLog(@"operation end --- %@",[NSThread currentThread]); // 打印当前线程
    }];
    [op start];
    NSLog(@"end--- %@", [NSThread currentThread]);
}

// OperationQueue 会异步执行添加的Operation.
- (void)operationQueueDemo1 {
    NSOperationQueue *oq = [[NSOperationQueue alloc] init];
    NSLog(@"start---%@", [NSThread currentThread]);
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];// 模拟耗时操作
            NSLog(@"1 --- %@", [NSThread currentThread]);
        }
    }];
    
    NSInvocationOperation *op2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task1) object:nil];
    PPOperation *op3 = [[PPOperation alloc] init];
    [oq addOperation:op1];
    [oq addOperation:op2];
    [oq addOperation:op3];
    [oq addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];// 模拟耗时操作
            NSLog(@"4 --- %@", [NSThread currentThread]);
        }
    }];
    
    NSLog(@"end--- %@", [NSThread currentThread]);
    
}

- (void)task1 {
    NSLog(@"task1 --- %@", [NSThread currentThread]);
}

- (void)operationQueueDemo2 {
    NSOperationQueue *oq = [[NSOperationQueue alloc] init];
    NSLog(@"start---%@", [NSThread currentThread]);
    [oq addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"4---%@",[NSThread currentThread]); // 打印当前线程
        }
    }];
    NSLog(@"end--- %@", [NSThread currentThread]);
}

// 串行队列 + 异步调用.
- (void)operationQueueDemo3 {
    NSOperationQueue *oq = [[NSOperationQueue alloc] init];
    NSLog(@"start---%@", [NSThread currentThread]);
    
    // 设置Queue是串行队列
    [oq setMaxConcurrentOperationCount:1];
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"1---%@",[NSThread currentThread]); // 打印当前线程
        }
    }];
    
    [oq addOperation:op1];
    [oq addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"2---%@",[NSThread currentThread]); // 打印当前线程
        }
    }];
    NSLog(@"end---%@", [NSThread currentThread]);
}

- (void)operationDependency2 {
    NSOperationQueue *oq = [[NSOperationQueue alloc] init];
    NSLog(@"start---%@", [NSThread currentThread]);
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"1---%@",[NSThread currentThread]); // 打印当前线程
        }
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"2---%@",[NSThread currentThread]); // 打印当前线程
        }
    }];
    
    [op2 addDependency:op1];
    [oq addOperation:op2];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [oq addOperation:op1];
    });
    NSLog(@"end---%@", [NSThread currentThread]);
}

- (void)operationPrioripty1 {
    NSOperationQueue *oq = [[NSOperationQueue alloc] init];
    oq.maxConcurrentOperationCount = 2;
    NSLog(@"start---%@", [NSThread currentThread]);
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"1 ---%@",[NSThread currentThread]); // 打印当前线程
        }
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"2 ---%@",[NSThread currentThread]); // 打印当前线程
        }
    }];
    
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"3 ---%@",[NSThread currentThread]); // 打印当前线程
        }
    }];
    
    op1.queuePriority = NSOperationQueuePriorityVeryLow;
    op2.queuePriority = NSOperationQueuePriorityVeryHigh;
    op3.queuePriority = NSOperationQueuePriorityVeryHigh;
    [oq addOperation:op1];
    [oq addOperation:op2];
    [oq addOperation:op3];
    
    NSLog(@"end---%@", [NSThread currentThread]);
}


- (void)downloadImageDemo1 {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    __block UIImage *image1 = NULL;
    
    NSBlockOperation *download1 = [NSBlockOperation blockOperationWithBlock:^{
        NSURL *url = [NSURL URLWithString:@"http://img.pconline.com.cn/images/photoblog/9/9/8/1/9981681/200910/11/1255259355826.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        image1 = [UIImage imageWithData:data];
    }];
    
    __block UIImage *image2 = NULL;
    //3. 创建第2个下载Operation
    NSBlockOperation *download2 = [NSBlockOperation blockOperationWithBlock:^{
        NSURL *url = [NSURL URLWithString:@"http://pic38.nipic.com/20140228/5571398_215900721128_2.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        image2 = [UIImage imageWithData:data];
    }];
    
    // 4. 创建下载完成以后的绘图操作
    NSBlockOperation *combine = [NSBlockOperation blockOperationWithBlock:^{
        UIGraphicsBeginImageContext(CGSizeMake(100, 100));
        [image1 drawInRect:CGRectMake(0, 0, 50, 50)];
        image1 = nil;
        
        [image2 drawInRect:CGRectMake(50, 0, 50, 100)];
        image2 = nil;
        
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.imageView.image = image;
        }];
    }];
    
    // 5. 设置绘图操作依赖两个下载操作
    [combine addDependency:download1];
    [combine addDependency:download2];
    
    
    // 6. 开始执行任务
    [queue addOperation:download1];
    [queue addOperation:download2];
    [queue addOperation:combine];
    
}
- (void)groupCrashDemo1 {
    
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
