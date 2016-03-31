//
//  YJTableViewDataSource.m
//  YJTableViewFactory
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by 阳君 on 16/3/26.
//  Copyright © 2016年 YJFactory. All rights reserved.
//

#import "YJTableViewDataSource.h"
#import "YJTableViewDelegate.h"

@implementation YJTableViewDataSource

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
            self.tableViewDelegate.cacheHeightStrategy = YJTableViewCacheCellDefault;
            break;
        case YJTableViewCacheCellIndexPath: ///< 根据NSIndexPath对应的位置缓存Cell
            self.tableViewDelegate.cacheHeightStrategy = YJTableViewCacheCellIndexPath;
            break;
    }
    
}


#pragma mark - 根据YJCellObject生成UITableViewCell
- (UITableViewCell *)dequeueReusableCellWithCellObject:(YJCellObject *)cellObject{
    
    NSString *identifier = self.cacheCellStrategy == YJTableViewCacheCellDefault ? cellObject.cellName : [NSString stringWithFormat:@"%ld-%ld", cellObject.indexPath.section, cellObject.indexPath.row];
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        // 未找到时，重新注入，再寻找
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
    [cell reloadCellWithCellObject:cellObject cellProtocol:self.tableViewDelegate.delegate];
    return cell;
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSLog(@"请不要使用YJTableViewDataSource抽象接口，请使用其子类YJTableViewDataSourceGrouped或YJTableViewDataSourcePlain");
    return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifier"];
    
}

@end
