//
//  Apply.m
//  GCDDemo
//
//  Created by leichunxiang on 2019/4/15.
//  Copyright © 2019 lcx. All rights reserved.
//

#import "Apply.h"

@implementation Apply

//多个任务并发执行完后，再执行apply后面任务
+(void)applyTest{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //10:执行10次，index：执行编号
    dispatch_apply(10, queue, ^(size_t index) {
        NSLog(@"%zu", index);
    });
    NSLog(@"game over");
}
@end
