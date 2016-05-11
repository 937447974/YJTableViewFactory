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

#pragma mark - setter
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

#pragma mark - 根据YJCellObject生成UITableViewCell
- (YJCellObject *)cellObjectWithIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"请不要使用YJTableViewDataSource抽象接口，请使用其子类YJTableViewDataSourceGrouped或YJTableViewDataSourcePlain");
    return [[YJCellObject alloc] init];
}

- (UITableViewCell *)dequeueReusableCellWithCellObject:(YJCellObject *)cellObject {
    
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
    [cell reloadCellWithCellObject:cellObject tableViewDelegate:self.tableViewDelegate];
    return cell;
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"请不要使用YJTableViewDataSource抽象接口，请使用其子类YJTableViewDataSourceGrouped或YJTableViewDataSourcePlain");
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YJCellObject *cellObject = [self cellObjectWithIndexPath:indexPath];
    cellObject.indexPath = indexPath;
    if (cellObject.suspension || cellObject.suspensionThroughout) { // 添加到悬浮cell层
        [self.tableViewDelegate.suspensionCellView addIndexPath:indexPath];
    }
    return [self dequeueReusableCellWithCellObject:cellObject];
}

@end
