//
//  DeadlockVC.m
//  GCDDemo
//
//  Created by lcx on 2019/12/13.
//  Copyright © 2019 lcx. All rights reserved.
//

#import "DeadlockVC.h"

@interface DeadlockVC ()

@end

@implementation DeadlockVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    int deadLockType = 3;
    NSLog(@"———deadlockTest %d———",deadLockType);

    switch (deadLockType) {
            case 1:
                    [self deadlockTest1];
                break;
            case 2:
                    [self deadlockTest2];
                break;
            case 3:
                    [self deadlockTest3];
                break;
            case 4:
                    [self deadlockTest4];
                break;
            default:
                break;
    }
    
}

#pragma mark - 死锁情形：在串行队列q中，同步调度任务，也是在串行队列q中；
/**
 (q,^{
    dispatch_sync(q, ^{
 });
 */

//1 只输出1，死锁
- (void)deadlockTest1{
    NSLog(@"1");
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"2");
    });
    NSLog(@"3");
}

//2 顺序输出1 4 2 ，然后死锁
- (void)deadlockTest2{
    NSLog(@"1");
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"2");
            dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"3");
        });
    });
    NSLog(@"4");
}


//3 自定义
- (void)deadlockTest3{
    dispatch_queue_t serialQueue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_SERIAL);
    ;

    dispatch_sync(serialQueue, ^{
        NSLog(@"1,%@",[NSThread currentThread]);sleep(1);
        
        dispatch_sync(serialQueue, ^{
        NSLog(@"2,%@",[NSThread currentThread]);sleep(1);
        });
        
        /**同样死锁
        dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"2,%@",[NSThread currentThread]);sleep(1);
        });
        */
    });
    NSLog(@"3");
}

//4
- (void)deadlockTest4{
    dispatch_queue_t serialQueue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_SERIAL);
    ;

    dispatch_async(serialQueue, ^{
        NSLog(@"1,%@",[NSThread currentThread]);sleep(1);

        dispatch_sync(serialQueue, ^{
        NSLog(@"2,%@",[NSThread currentThread]);sleep(1);
        });
        
    });
    NSLog(@"3");
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
