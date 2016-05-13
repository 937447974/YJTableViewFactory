//
//  YJTableViewDelegate.m
//  YJTableViewFactory
//
//  HomePage:https://github.com/937447974/YJTableViewFactory
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/3/26.
//  Copyright © 2016年 YJFactory. All rights reserved.
//

#import "YJTableViewDelegate.h"
#import "YJTableViewDataSource.h"
#import "YJTableCellObject.h"

@interface YJTableViewDelegate () {
    NSMutableDictionary<NSString *, NSNumber *> *_cacheHeightDict; ///< 缓存高
    YJSuspensionCellView *_suspensionCellView;
}
@end

@implementation YJTableViewDelegate

#pragma mark - init
- (instancetype)initWithDataSource:(YJTableViewDataSource *)dataSource {
    self = [super init];
    if (self) {
        _cacheHeightDict = [[NSMutableDictionary alloc] init];
        _isCacheHeight = YES;
        _dataSource = dataSource;
    }
    return self;
}

#pragma mark - getter and setter
- (YJSuspensionCellView *)suspensionCellView {
    if (!_suspensionCellView) {
        self.suspensionCellView = [[YJSuspensionCellView alloc] initWithFrame:CGRectMake(0, 0, self.dataSource.tableView.frame.size.width, 0)];
        [self.dataSource.tableView.superview addSubview:_suspensionCellView];
    }
    return _suspensionCellView;
}

- (void)setSuspensionCellView:(YJSuspensionCellView *)suspensionCellView {
    _suspensionCellView = suspensionCellView;
    _suspensionCellView.tableViewDelegate = self;
}

#pragma mark - UITableViewCell向VC发送数据
- (void)sendVCWithCellObject:(YJTableCellObject *)cellObject tableViewCell:(UITableViewCell *)cell {
    if (self.cellBlock) { // block回调
        self.cellBlock(cellObject, cell);
    } else if (self.cellDelegate) { // 协议回调
        [self.cellDelegate tableViewDidSelectCellWithCellObject:cellObject tableViewCell:cell];
    }
}

#pragma mark - 清除缓存
- (void)clearAllCacheHeight {
    if ([self validateCacheHeight]) {
       [_cacheHeightDict removeAllObjects];
    }
}

- (void)clearCacheHeightWithCellClass:(Class)cellClass {
    if (![self validateCacheHeight]) {
        return;
    }
    if (self.cacheHeightStrategy != YJTableViewCacheHeightDefault) {
        NSLog(@"请设置YJTableViewCacheHeightDefault缓存高策略");
        return;
    }
    [_cacheHeightDict removeObjectForKey:YJStringFromClass(cellClass)];
}

- (void)clearCacheHeightWithIndexPath:(NSIndexPath *)indexPath {
    if ([self validateCacheHeightWithIndexPath]) {
        [_cacheHeightDict removeObjectForKey:[self getKeyFromIndexPath:indexPath]];
    }
}

- (void)clearCacheHeightWithIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    if ([self validateCacheHeightWithIndexPath]) {
        for (NSIndexPath *indexPath in indexPaths) {
            [_cacheHeightDict removeObjectForKey:[self getKeyFromIndexPath:indexPath]];
        }
    }
}

- (void)clearCacheHeightWithFromIndexPath:(NSIndexPath *)startIndexPath toIndexPath:(NSIndexPath *)endIndexPath {
    if (startIndexPath.section > endIndexPath.section) {
        return;
    }
    // 清理缓存
    NSArray *rows;
    NSIndexPath *indexPath;
    if ([self validateCacheHeightWithIndexPath]) {
        for (NSInteger section = startIndexPath.section; section <= endIndexPath.section; section++) {
            rows = self.dataSource.dataSourceGrouped[section];
            NSInteger startRow = section == startIndexPath.section ? startIndexPath.row : 0;
            NSInteger endRow = section == endIndexPath.section ? endIndexPath.row : rows.count-1;
            for (NSInteger row = startRow; row <= endRow; row++) {
                indexPath = [NSIndexPath indexPathForRow:row inSection:section];
                [_cacheHeightDict removeObjectForKey:[self getKeyFromIndexPath:indexPath]];
            }
        }
    }
}

#pragma mark - 校验是否开启缓存高
- (BOOL)validateCacheHeight {
    if (!self.isCacheHeight) {
        NSLog(@"请开启缓存高");
    }
    return self.isCacheHeight;
}

#pragma mark 校验是否使用YJTableViewCacheHeightIndexPath缓存高策略
- (BOOL)validateCacheHeightWithIndexPath {
    if (![self validateCacheHeight]) {
        return NO;
    }
    if (self.cacheHeightStrategy != YJTableViewCacheHeightIndexPath) {
        NSLog(@"请设置YJTableViewCacheHeightIndexPath缓存高策略");
        return NO;
    }
    return YES;
}

#pragma mark - 获取NSIndexPath对应的缓存key
- (NSString *)getKeyFromIndexPath:(NSIndexPath *)indexPath {
    return [NSString stringWithFormat:@"%@-%@", @(indexPath.section), @(indexPath.row)];
}

#pragma mark 获取cellObject对应的缓存key
- (NSString *)getKeyFromCellObject:(YJTableCellObject *)cellObject {
    switch (self.cacheHeightStrategy) {
        case YJTableViewCacheHeightDefault: // 根据相同的UITableViewCell类缓存高度
            return cellObject.cellName;
        case YJTableViewCacheHeightIndexPath: // 根据NSIndexPath对应的位置缓存高度
            return [NSString stringWithFormat:@"%ld-%ld", cellObject.indexPath.section, cellObject.indexPath.row];
        case YJTableViewCacheHeightClassAndIndexPath: // 根据类名和NSIndexPath双重绑定缓存高度
            return [NSString stringWithFormat:@"%@(%ld-%ld)", cellObject.cellName, cellObject.indexPath.section, cellObject.indexPath.row];
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 获取YJTableCellObject
    YJTableCellObject *cellObject = self.dataSource.dataSourceGrouped[indexPath.section][indexPath.row];
    cellObject.indexPath = indexPath;
    // 存放缓存高的key
    NSString *key = [self getKeyFromCellObject:cellObject];
    CGFloat rowHeight = 0;
    if (self.isCacheHeight) {
        rowHeight = [_cacheHeightDict objectForKey:key].floatValue;
    }
    if (rowHeight == 0) { //无缓存
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YJTableCellObject *cellObject = self.dataSource.dataSourceGrouped[indexPath.section][indexPath.row];
    [self sendVCWithCellObject:cellObject tableViewCell:nil];
}

#pragma mark - UIScrollViewDelegate
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    self.suspensionCellView.contentOffsetY = self.dataSource.tableView.contentOffset.y;
//}

@end
