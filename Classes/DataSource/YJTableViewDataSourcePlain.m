//
//  YJTableViewDataSourcePlain.m
//  YJTableViewFactory
//
//  HomePage:https://github.com/937447974/YJTableViewFactory
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/3/26.
//  Copyright © 2016年 YJFactory. All rights reserved.
//

#import "YJTableViewDataSourcePlain.h"

@implementation YJTableViewDataSourcePlain

#pragma mark - getter
- (NSMutableArray<YJCellObject *> *)dataSource {
    
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
    
}

#pragma mark - super
- (YJCellObject *)cellObjectWithIndexPath:(NSIndexPath *)indexPath {
    return [self.dataSource objectAtIndex:indexPath.row];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
    
}

@end
