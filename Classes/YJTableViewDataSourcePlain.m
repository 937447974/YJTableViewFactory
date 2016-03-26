//
//  YJTableViewDataSourcePlain.m
//  YJTableViewFactory
//
//  Created by admin on 16/3/26.
//  Copyright © 2016年 YJFactory. All rights reserved.
//

#import "YJTableViewDataSourcePlain.h"
#import "UITableViewCell+YJTableViewFactory.h"

@implementation YJTableViewDataSourcePlain

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = [[NSMutableArray alloc] init];
    }
    return self;
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
    [cell reloadCellWithCellObject:cellObject];
    return cell;    
}

@end
