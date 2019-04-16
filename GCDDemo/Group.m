//
//  Group.m
//  GCDDemo
//
//  Created by leichunxiang on 2019/4/15.
//  Copyright © 2019 lcx. All rights reserved.
//

#import "Group.h"

@implementation Group

//dispatch_group_enter:与leave成对出现，通知group下个任务要放z入group中执行；
//dispatch_group_leave：/通知group，任务完成要移除；
//dispatch_group_notify：全部任务完成，就会调用；enter+1,leave减1，为0时才会通知group任务完成；
//
//dispatch_group_wait：任务完成时（enter与leavee的综合计数为0时），或者超时时，调用；
//dispatch_after:延迟执行

+ (void)enterAndleaveTest {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        dispatch_group_t group = dispatch_group_create();
        dispatch_group_enter(group);
        dispatch_group_enter(group);
        NSLog(@"加入");
        NSLog(@"加入");
        
        // 异步2秒后离开
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), queue, ^{ NSLog(@"即将离开 - 1");
            dispatch_group_leave(group);
            NSLog(@"已经离开 - 1");    });
        
        // 异步3秒后离开
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), queue, ^{ NSLog(@"即将离开 - 2");
            dispatch_group_leave(group);
            NSLog(@"已经离开 - 2"); });
        
        dispatch_group_notify(group, queue, ^{ NSLog(@"都完成了"); });
        
        NSLog(@"开始等待");
        dispatch_group_wait(group, dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)));
        NSLog(@"等待结束");
    });
}

@end
