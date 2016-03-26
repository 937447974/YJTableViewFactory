//
//  YJTableViewDataSourceGrouped.h
//  YJTableViewFactory
//
//  Created by admin on 16/3/26.
//  Copyright © 2016年 YJFactory. All rights reserved.
//

#import "YJTableViewDataSource.h"

NS_ASSUME_NONNULL_BEGIN

/** UITableViewStyleGrouped样式*/
@interface YJTableViewDataSourceGrouped : YJTableViewDataSource <UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray<NSMutableArray<YJCellObject *> *> *dataSource; ///< 数据源

@end

NS_ASSUME_NONNULL_END
