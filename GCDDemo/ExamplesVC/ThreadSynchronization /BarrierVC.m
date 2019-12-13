//
//  BarrierVC.m
//  GCDDemo
//
//  Created by lcx on 2019/12/12.
//  Copyright © 2019 lcx. All rights reserved.
//

#import "BarrierVC.h"

@interface BarrierVC ()

@end

@implementation BarrierVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self barrierTest];
}

/**barrier作用效果：
 1.只有在用户队列中有效，在main或者global queue中与dispatch_(a)sync效果一样；
 2.用于异步并发任务，不阻塞主线程：先执行barrier前任务，再执行barrier任务，最后执行barrier后任务；
*/

// 执行顺序：51并发, 再2,  后34并发
- (void)barrierTest
{
    /*
     DISPATCH_QUEUE_CONCURRENT 并行队列
     DISPATCH_QUEUE_SERIAL 串行队列
     */
    dispatch_queue_t myQueue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(myQueue, ^{
        NSLog(@"1");
        sleep(2);
    });
    dispatch_barrier_async(myQueue, ^{
        NSLog(@"2");
        sleep(2);
    });
    
    dispatch_async(myQueue, ^{
        NSLog(@"3");
        sleep(2);
    });
    NSLog(@"4");
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
