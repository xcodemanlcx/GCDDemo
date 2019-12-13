//
//  Dispatch_syncVC.m
//  GCDDemo
//
//  Created by lcx on 2019/12/13.
//  Copyright © 2019 lcx. All rights reserved.
//

#import "Dispatch_syncVC.h"

@interface Dispatch_syncVC ()

@end

@implementation Dispatch_syncVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

#pragma mark - dispatch_sync：同步调度：1 不会开辟子线程， 任务在当前线程有序执行；2 会阻塞当前线程；

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    int queueType = 2;
    NSLog(@"--queueType %d--",queueType);
    
    NSLog(@"1");sleep(1);
    dispatch_sync([self chooseQueue:queueType], ^{
        NSLog(@"2,%@",[NSThread currentThread]);sleep(1);
    });
    NSLog(@"3");sleep(1);
}

- (dispatch_queue_t )chooseQueue:(int)queueType{
    dispatch_queue_t queue = dispatch_get_main_queue();

    switch (queueType) {
        case 1:
            //主队列（串行队列）：只输出1，死锁
            queue = dispatch_get_main_queue();
                break;
        case 2:
            //全局队列（并行队列）:按顺序输出1 2 3
            queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            break;
        case 3:
            //自定义串行队列：结果同case 2
            queue = dispatch_queue_create("myQueue_serial", DISPATCH_QUEUE_SERIAL);
            break;
        case 4:
            //自定义并行队列：结果同case 2
            queue = dispatch_queue_create("myQueue_concurrent", DISPATCH_QUEUE_CONCURRENT);
            break;
            
        default:
            break;
    }
    return queue;
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
