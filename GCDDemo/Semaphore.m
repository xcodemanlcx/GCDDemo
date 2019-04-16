//
//  Semaphore.m
//  GCDDemo
//
//  Created by leichunxiang on 2019/4/14.
//  Copyright © 2019 lcx. All rights reserved.
//

#import "Semaphore.h"

@implementation Semaphore

//参考：https://www.jianshu.com/p/2dd2433e2d4a
#pragma - 解决同步问题:任务1、2、3按顺序执行

+ (void)syncTest{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_semaphore_t semaphore1 = dispatch_semaphore_create(1);
    dispatch_semaphore_t semaphore2 = dispatch_semaphore_create(0);
   
    dispatch_async(queue, ^{
        // 任务1
//      若semaphore计数为0则等待，大于0则使其减1。
        dispatch_semaphore_wait(semaphore1, DISPATCH_TIME_FOREVER);
        NSLog(@"1\n");
//        使semaphore计数加1。
        dispatch_semaphore_signal(semaphore2);
        dispatch_semaphore_signal(semaphore1);});
  
        dispatch_async(queue, ^{
        // 任务2
        dispatch_semaphore_wait(semaphore2,DISPATCH_TIME_FOREVER);
        NSLog(@"2\n");
        dispatch_semaphore_signal(semaphore2);});

}

#pragma - 解决有限资源问题:最多创建10个异步任务

+ (void)limitTest{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(10);
    for (int i = 0; i < 100; i ++) {
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_async(queue, ^{
        // 任务...
        NSLog(@"%d",i);
        dispatch_semaphore_signal(semaphore);});
    }
}
@end
