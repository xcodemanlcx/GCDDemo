//
//  Barrier.m
//  GCDDemo
//
//  Created by leichunxiang on 2019/4/15.
//  Copyright © 2019 lcx. All rights reserved.
//

#import "Barrier.h"

@implementation Barrier


//barrier作用效果：只有在用户队列中有效，在main或者global queue中与dispatch_(a)sync效果一样；先执行barrier前任务，再执行barrier任务，最后执行barrier后任务；

// 51并发, 再2,  后34并发
+ (void)barrierTest
{
    /*
     DISPATCH_QUEUE_CONCURRENT 并行队列
     DISPATCH_QUEUE_SERIAL 串行队列
     */
    dispatch_queue_t myQueue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(myQueue, ^{
        [self doSometing:@"1"];
    });
    
    dispatch_barrier_async(myQueue, ^{
        [self doSometing:@"2"];
    });
    
    dispatch_async(myQueue, ^{
        [self doSometing:@"3"];
    });
    dispatch_async(myQueue, ^{
        [self doSometing:@"4"];
    });
    
    [self doSometing:@"5"];
    
}

+ (void)doSometing:(NSString *)str
{
    [NSThread sleepForTimeInterval:1.0];// 线程休眠 1秒: 为了让并发、串行执行顺序体现更明显。
    NSLog(@"%@",str);
}
@end
