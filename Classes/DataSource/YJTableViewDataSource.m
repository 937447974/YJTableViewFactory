//
//  YJTableViewDataSource.m
//  YJTableViewFactory
//
//  HomePage:https://github.com/937447974/YJTableViewFactory
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/3/26.
//  Copyright © 2016年 YJFactory. All rights reserved.
//

#import "YJTableViewDataSource.h"
#import "YJTableViewDelegate.h"

@interface YJTableViewDataSource () {
    NSMutableArray<YJTableCellObject *> *_dataSource;
    NSMutableArray<NSMutableArray<YJTableCellObject *> *> *_dataSourceGrouped;
}
@end


@implementation YJTableViewDataSource

#pragma mark - init
- (instancetype)initWithTableView:(UITableView *)tableView {
    
    self = [super init];
    if (self) {
        self.tableView = tableView;
        _tableViewDelegate = [[YJTableViewDelegate alloc] initWithDataSource:self];
        // 默认设置代理
        self.tableView.dataSource = self;
        self.tableView.delegate = self.tableViewDelegate;
    }
    return self;
}

#pragma mark - getter and setter
- (NSMutableArray<YJTableCellObject *> *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        [self.dataSourceGrouped addObject:_dataSource];
    }
    return _dataSource;
}

- (NSMutableArray<NSMutableArray<YJTableCellObject *> *> *)dataSourceGrouped {
    if (!_dataSourceGrouped) {
        _dataSourceGrouped = [NSMutableArray array];
    }
    return _dataSourceGrouped;
}

- (void)setCacheCellStrategy:(YJTableViewCacheCell)cacheCellStrategy {
    _cacheCellStrategy = cacheCellStrategy;
    switch (cacheCellStrategy) {
        case YJTableViewCacheCellDefault:  ///< 根据相同的UITableViewCell类名缓存Cell
            self.tableViewDelegate.cacheHeightStrategy = YJTableViewCacheHeightDefault;
            break;
        case YJTableViewCacheCellIndexPath: ///< 根据NSIndexPath对应的位置缓存Cell
            self.tableViewDelegate.cacheHeightStrategy = YJTableViewCacheHeightIndexPath;
            break;
        case YJTableViewCacheCellClassAndIndexPath:
            self.tableViewDelegate.cacheHeightStrategy = YJTableViewCacheHeightClassAndIndexPath;
            break;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSourceGrouped.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSourceGrouped objectAtIndex:section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YJTableCellObject *cellObject = self.dataSourceGrouped[indexPath.section][indexPath.row];
    cellObject.indexPath = indexPath;
    __weak YJTableViewDataSource *weakSelf = self;
    dispatch_async_background(^{// 添加到悬浮cell层
        [weakSelf.tableViewDelegate.suspensionCellView addIndexPath:indexPath];
    });
    return [self dequeueReusableCellWithCellObject:cellObject];
}

#pragma mark 根据YJTableCellObject生成UITableViewCell
- (UITableViewCell *)dequeueReusableCellWithCellObject:(YJTableCellObject *)cellObject {
    
    NSString *identifier = @"identifier";
    switch (self.cacheCellStrategy) {
        case YJTableViewCacheCellDefault:
            identifier = cellObject.cellName;
            break;
        case YJTableViewCacheCellIndexPath:
            identifier = [NSString stringWithFormat:@"%ld-%ld", cellObject.indexPath.section, cellObject.indexPath.row];
            break;
        case YJTableViewCacheCellClassAndIndexPath:
            identifier = [NSString stringWithFormat:@"%@(%ld-%ld)", cellObject.cellName, cellObject.indexPath.section, cellObject.indexPath.row];
            break;
    }
    // 读取缓存
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    // 未找到时，重新注入，再寻找
    if (cell == nil) {
        switch (cellObject.createCell) {
            case YJTableViewCellCreateDefault:
                [self.tableView registerNib:[UINib nibWithNibName:cellObject.cellName bundle:nil] forCellReuseIdentifier:identifier];
                cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
                break;
            case YJTableViewCellCreateSoryboard:
                NSLog(@"Soryboard中请使用%@设置cell的Identifier属性", cellObject.cellName);
                break;
            case YJTableViewCellCreateClass:
                cell = [[cellObject.cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                break;
        }
    }
    __weak YJTableViewDataSource *weakSelf = self;
    dispatch_async_background(^{// UI加速
        [cell reloadCellWithCellObject:cellObject tableViewDelegate:weakSelf.tableViewDelegate];
    });
    return cell;
}

@end
