//
//  MixVC.m
//  GCDDemo
//
//  Created by lcx on 2019/12/16.
//  Copyright © 2019 lcx. All rights reserved.
//

#import "MixVC.h"

@interface MixVC ()

@end

@implementation MixVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    int testType = 1;
    
    switch (testType) {
            case 1:
                [self test1];
                break;
            case 2:
                [self test2];
                break;
            case 3:
                [self test3];
                break;

                break;
        default:
                break;
    }
}

//无嵌套
- (void)test1{
    /**输出：123 45；
     说明：123 无序并发，然后45无序并发；
     */
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    NSLog(@"1,%@",[NSThread currentThread]);sleep(1);
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    NSLog(@"2,%@",[NSThread currentThread]);sleep(1);
    });
        
    NSLog(@"3");sleep(1);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    NSLog(@"4,%@",[NSThread currentThread]);sleep(1);
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    NSLog(@"5,%@",[NSThread currentThread]);sleep(1);
    });
}

//双层嵌套
- (void)test2{
   /**输出：31 42 5
    说明：31无序并发，然后42无序并发，最后执行5；
    */
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"1,%@",[NSThread currentThread]);sleep(1);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"2,%@",[NSThread currentThread]);sleep(1);

        });
    });
    
    NSLog(@"3");sleep(1);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"4,%@",[NSThread currentThread]);sleep(1);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"5,%@",[NSThread currentThread]);sleep(1);

        });
    });
}

//三层嵌套
- (void)test3{
    /**输出：1 2 3；
     说明：按顺序输出1 2 3；
     */
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"1,%@",[NSThread currentThread]);sleep(1);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"2,%@",[NSThread currentThread]);sleep(1);
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSLog(@"3,%@",[NSThread currentThread]);sleep(1);
                
            });
        });
    });
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
