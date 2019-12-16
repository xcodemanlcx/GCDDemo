//
//  SyncLockVC.m
//  GCDDemo
//
//  Created by lcx on 2019/12/13.
//  Copyright © 2019 lcx. All rights reserved.
//  参考：https://www.jianshu.com/p/97ed78a6f9b8

#import "SyncLockVC.h"

@interface SyncLockVC ()

@end

@implementation SyncLockVC
{
  NSInteger _ticketSurplusCount;
  dispatch_semaphore_t _semaphoreLock;
  NSLock *_lock;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self initTicketStatusSave];
}

#pragma mark - 多窗口售火车票，使用锁使线程同步
/**
 * 线程安全：使用 semaphore 加锁
 * 初始化火车票数量、卖票窗口(线程安全)、并开始卖票
 */
- (void)initTicketStatusSave {
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"semaphore---begin");
    
    _semaphoreLock = dispatch_semaphore_create(1);
    
    _ticketSurplusCount = 10;
    
    // queue1 代表北京火车票售卖窗口
    dispatch_queue_t queue1 = dispatch_queue_create("net.bujige.testQueue1.beijing", DISPATCH_QUEUE_SERIAL);
    // queue2 代表上海火车票售卖窗口
    dispatch_queue_t queue2 = dispatch_queue_create("net.bujige.testQueue2.shanghai", DISPATCH_QUEUE_SERIAL);
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(queue1, ^{
        [weakSelf saleTicketSafe_semaphore];
    });
    
    dispatch_async(queue2, ^{
        [weakSelf saleTicketSafe_semaphore];
    });
}

/**
 * 1 售卖火车票(线程安全)
 */
- (void)saleTicketSafe_semaphore{
    while (1) {
        // 相当于加锁:
        dispatch_semaphore_wait(_semaphoreLock, DISPATCH_TIME_FOREVER);
        
        if (_ticketSurplusCount > 0) {  //如果还有票，继续售卖
            _ticketSurplusCount--;
            NSLog(@"%@", [NSString stringWithFormat:@"剩余票数：%ld 窗口：%@", (long)_ticketSurplusCount, [NSThread currentThread]]);
            [NSThread sleepForTimeInterval:0.2];
        } else { //如果已卖完，关闭售票窗口
            NSLog(@"所有火车票均已售完");
            
            // 相当于解锁
            dispatch_semaphore_signal(_semaphoreLock);
            break;
        }
        
        // 相当于解锁
        dispatch_semaphore_signal(_semaphoreLock);
    }
}

/**
 * 2 售卖火车票(线程安全)
 */
- (void)saleTicketSafe_synchronized{
    while (1) {
        // 相当于加锁
        @synchronized(self) {
            if (_ticketSurplusCount > 0) {  //如果还有票，继续售卖
                _ticketSurplusCount--;
                NSLog(@"%@", [NSString stringWithFormat:@"剩余票数：%ld 窗口：%@", (long)_ticketSurplusCount, [NSThread currentThread]]);
                [NSThread sleepForTimeInterval:0.2];
            } else { //如果已卖完，关闭售票窗口
                NSLog(@"所有火车票均已售完");
                break;
            }
        }
    }
}

/**
 * 售卖火车票(线程安全)
 */
- (void)saleTicketSafe_lock{
    while (1) {
        // 相当于加锁
        [_lock lock];
        if (_ticketSurplusCount > 0) {  //如果还有票，继续售卖
            _ticketSurplusCount--;
            NSLog(@"%@", [NSString stringWithFormat:@"剩余票数：%ld 窗口：%@", (long)_ticketSurplusCount, [NSThread currentThread]]);
            [NSThread sleepForTimeInterval:0.2];
        } else { //如果已卖完，关闭售票窗口
            NSLog(@"所有火车票均已售完");
            break;
        }
        [_lock unlock];
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
