//
//  ApplyVC.m
//  GCDDemo
//
//  Created by lcx on 2019/12/12.
//  Copyright © 2019 lcx. All rights reserved.
//

#import "ApplyVC.h"

@interface ApplyVC ()

@end

@implementation ApplyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self applyTest];
}

//用于多个类似异步任务，并发执行完后，再执行apply后面任务，会阻塞主线程；
-(void)applyTest{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //10:执行10次，index：执行编号
    dispatch_apply(10, queue, ^(size_t index) {
        NSLog(@"%zu", index);
        sleep(2);
    });
    NSLog(@"game over");
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
