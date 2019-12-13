//
//  TableViewController.h
//  LCXUIInit
//
//  Created by lcx on 2019/9/2.
//  Copyright © 2019 lcx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableViewController : UITableViewController

@property (nonatomic ,copy) NSArray <NSArray *>*exampleControllerNames;
@property (nonatomic ,copy) NSArray *sectionHeadTitles;

@end

NS_ASSUME_NONNULL_END
