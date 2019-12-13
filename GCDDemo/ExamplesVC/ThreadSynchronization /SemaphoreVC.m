//
//  SemaphoreVC.m
//  GCDDemo
//
//  Created by lcx on 2019/12/12.
//  Copyright © 2019 lcx. All rights reserved.
//

#import "SemaphoreVC.h"

@interface SemaphoreVC ()

@end

@implementation SemaphoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    BOOL isLimitThreadNumber = NO;
    if (isLimitThreadNumber) {
        [self limitTest];
    }else{
        [self syncTest];
    }
}

//参考：https://www.jianshu.com/p/2dd2433e2d4a
#pragma - 解决同步问题:任务1、2、3按顺序执行,

- (void)syncTest{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_semaphore_t semaphore1 = dispatch_semaphore_create(1);
    dispatch_semaphore_t semaphore2 = dispatch_semaphore_create(0);
   
    // 异步任务一
    dispatch_async(queue, ^{
        //若semaphore计数为0则等待，大于0则使其减1。
        dispatch_semaphore_wait(semaphore1, DISPATCH_TIME_FOREVER);
        NSLog(@"1\n");
        sleep(2);
        // 使semaphore计数加1。
        dispatch_semaphore_signal(semaphore2);
        dispatch_semaphore_signal(semaphore1);
        
    });
  
  // 异步任务二
  dispatch_async(queue, ^{
      dispatch_semaphore_wait(semaphore2,DISPATCH_TIME_FOREVER);
      NSLog(@"2\n");
      dispatch_semaphore_signal(semaphore2);
  });

}

#pragma - 解决有限资源问题:限制最大并发数

- (void)limitTest{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //限制最大并发数为3
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(3);
    for (int i = 0; i < 20; i ++) {
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_async(queue, ^{
        // 任务...
        NSLog(@"%d",i);
            sleep(2);
        dispatch_semaphore_signal(semaphore);});
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
