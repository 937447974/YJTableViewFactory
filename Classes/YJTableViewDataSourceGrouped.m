//
//  YJTableViewDataSourceGrouped.m
//  YJTableViewFactory
//
//  Created by admin on 16/3/26.
//  Copyright © 2016年 YJFactory. All rights reserved.
//

#import "YJTableViewDataSourceGrouped.h"
#import "UITableViewCell+YJTableViewFactory.h"

@implementation YJTableViewDataSourceGrouped

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource objectAtIndex:section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YJCellObject *cellObject = [[self.dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellObject.cellName];
    if (cell == nil) {
        // 未找到时，重新注入，再寻找
        [tableView registerNib:[UINib nibWithNibName:cellObject.cellName bundle:nil] forCellReuseIdentifier:cellObject.cellName];
        cell = [tableView dequeueReusableCellWithIdentifier:cellObject.cellName];
    }
    [cell reloadCellWithCellObject:cellObject];
    return cell;
}

@end
