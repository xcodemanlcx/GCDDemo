//
//  Semaphore.h
//  GCDDemo
//
//  Created by leichunxiang on 2019/4/14.
//  Copyright © 2019 lcx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Semaphore : NSObject
+ (void)syncTest;
+ (void)limitTest;
@end

NS_ASSUME_NONNULL_END
