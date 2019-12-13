//
//  TableViewController.m
//  LCXUIInit
//
//  Created by lcx on 2019/9/2.
//  Copyright © 2019 lcx. All rights reserved.
//

#import "TableViewController.h"

static NSString * const kCellReuseIdentifier = @"CellReuseIdentifier";

@interface TableViewController ()

@end

@implementation TableViewController

//- (instancetype)initWithStyle:(UITableViewStyle)style {
//    return [super initWithStyle:UITableViewStyleGrouped];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Examples";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:kCellReuseIdentifier];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _exampleControllerNames.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sectionArr = (NSArray *)_exampleControllerNames[section];
    return sectionArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseIdentifier forIndexPath:indexPath];
    NSArray *sectionArr = (NSArray *)_exampleControllerNames[indexPath.section];
    NSString *viewControllerName = sectionArr[indexPath.row];
    cell.backgroundColor = [UIColor orangeColor];
    cell.textLabel.text = viewControllerName;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *sectionArr = (NSArray *)_exampleControllerNames[indexPath.section];
    NSString *viewControllerName = sectionArr[indexPath.row];
    Class viewControllerClass = NSClassFromString(viewControllerName);
    [self.navigationController pushViewController:viewControllerClass.new  animated:YES];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
    label.text = _sectionHeadTitles[section];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
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
