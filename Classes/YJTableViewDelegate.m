//
//  YJTableViewDelegate.m
//  YJTableViewFactory
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by 阳君 on 16/3/26.
//  Copyright © 2016年 YJFactory. All rights reserved.
//

#import "YJTableViewDelegate.h"
#import "UITableViewCell+YJTableViewFactory.h"

@interface YJTableViewDelegate ()
{
    NSMutableDictionary<NSString *, NSNumber *> *_cacheHeightDict; ///< 缓存高
}

@property (nonatomic, weak) YJTableViewDataSourcePlain *dataSourcePlain;
@property (nonatomic, weak) YJTableViewDataSourceGrouped *dataSourceGrouped;

@end

@implementation YJTableViewDelegate

- (instancetype)initWithDataSource:(YJTableViewDataSource *)dataSource
{
    self = [super init];
    if (self) {
        _cacheHeightDict = [[NSMutableDictionary alloc] init];
        _isCacheHeight = YES;
        if ([dataSource isKindOfClass:[YJTableViewDataSourcePlain class]]) {
            self.dataSourcePlain = (YJTableViewDataSourcePlain *)dataSource;
        } else if([dataSource isKindOfClass:[YJTableViewDataSourceGrouped class]]) {
            self.dataSourceGrouped = (YJTableViewDataSourceGrouped *)dataSource;
        }
    }
    return self;
}

#pragma mark - 清楚缓存
- (void)clearCacheHeight
{
    [_cacheHeightDict removeAllObjects];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat rowHeight = 0;
    // 存放缓存高的key
    NSString *key = [NSString stringWithFormat:@"%ld-%ld", indexPath.section, indexPath.row];
    if (self.isCacheHeight) {
        rowHeight = [_cacheHeightDict objectForKey:key].floatValue;
    }
    if (rowHeight == 0) { //无缓存
        // 获取YJCellObject
        YJCellObject *cellObject;
        UITableView *tableView;
        if (self.dataSourcePlain) {
            cellObject = self.dataSourcePlain.dataSource[indexPath.row];
            tableView = self.dataSourcePlain.tableView;
        } else if (self.dataSourceGrouped) {
            cellObject = self.dataSourceGrouped.dataSource[indexPath.section][indexPath.row];
            tableView = self.dataSourceGrouped.tableView;
        }
        // 获取高
        if (cellObject && [cellObject.cellClass respondsToSelector:@selector(tableView:heightForCellObject:)] ) {
            rowHeight = [cellObject.cellClass tableView:tableView heightForCellObject:cellObject];
        }
    }
    // 获取失败时，使用默认高
    rowHeight = rowHeight ? rowHeight : tableView.rowHeight;
    // 添加缓存
    if (self.isCacheHeight) {
        [_cacheHeightDict setObject:[NSNumber numberWithFloat:rowHeight] forKey:key];
    }
    return rowHeight;
}

@end
