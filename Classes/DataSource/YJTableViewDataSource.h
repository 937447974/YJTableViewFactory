//
//  YJTableViewDataSource.h
//  YJTableViewFactory
//
//  HomePage:https://github.com/937447974/YJTableViewFactory
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/3/26.
//  Copyright © 2016年 YJFactory. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YJTableCellObject.h"
#import "UITableViewCell+YJTableViewFactory.h"

NS_ASSUME_NONNULL_BEGIN

@class YJTableViewDelegate;

/** 缓存Cell的策略*/
typedef NS_ENUM(NSInteger, YJTableViewCacheCell) {
    YJTableViewCacheCellDefault,          ///< 根据相同的UITableViewCell类名缓存Cell
    YJTableViewCacheCellIndexPath,        ///< 根据NSIndexPath对应的位置缓存Cell
    YJTableViewCacheCellClassAndIndexPath ///< 根据类名和NSIndexPath双重绑定缓存Cell
};


/** UITableViewDataSource抽象接口*/
@interface YJTableViewDataSource : NSObject <UITableViewDataSource>

@property (nonatomic) YJTableViewCacheCell cacheCellStrategy; ///< 缓存Cell的策略

@property (nonatomic, strong, readonly) NSMutableArray<YJTableCellObject *> *dataSource; ///< 数据源UITableViewStylePlain
@property (nonatomic, strong, readonly) NSMutableArray<NSMutableArray<YJTableCellObject *> *> *dataSourceGrouped; ///< 数据源UITableViewStyleGrouped

@property (nonatomic, weak) UITableView *tableView;                             ///< tableView
@property (nonatomic, strong, readonly) YJTableViewDelegate *tableViewDelegate; ///< YJTableViewDelegate,无须赋值，自动化创建

/**
 *  抽象的初始化接口,会自动填充设置tableView.dataSource = self;tableView.delegate = self.tableViewDelegate;
 *
 *  @param tableView UITableView
 *
 *  @return YJTableViewDataSourceGrouped 或 YJTableViewDataSourcePlain
 */
- (instancetype)initWithTableView:(UITableView *)tableView;

/**
 *  根据cellObject创建UITableViewCell
 *
 *  @param cellObject YJTableCellObject
 *
 *  @return UITableViewCell
 */
- (UITableViewCell *)dequeueReusableCellWithCellObject:(YJTableCellObject *)cellObject;

@end

NS_ASSUME_NONNULL_END
