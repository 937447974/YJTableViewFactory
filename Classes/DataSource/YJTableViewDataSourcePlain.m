//
//  YJTableViewDataSourcePlain.m
//  YJTableViewFactory
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by 阳君 on 16/3/26.
//  Copyright © 2016年 YJFactory. All rights reserved.
//

#import "YJTableViewDataSourcePlain.h"
#import "UITableViewCell+YJTableViewFactory.h"

@implementation YJTableViewDataSourcePlain

#pragma mark - getter
- (NSMutableArray<YJCellObject *> *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YJCellObject *cellObject = [self.dataSource objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellObject.cellName];
    if (cell == nil) {
        // 未找到时，重新注入，再寻找
        [tableView registerNib:[UINib nibWithNibName:cellObject.cellName bundle:nil] forCellReuseIdentifier:cellObject.cellName];
        cell = [tableView dequeueReusableCellWithIdentifier:cellObject.cellName];
    }
    cellObject.indexPath = indexPath;
    [cell reloadCellWithCellObject:cellObject];
    return cell;    
}

@end
