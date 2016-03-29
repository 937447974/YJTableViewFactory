//
//  YJTableViewDataSourcePlain.h
//  YJTableViewFactory
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by 阳君 on 16/3/26.
//  Copyright © 2016年 YJFactory. All rights reserved.
//

#import "YJTableViewDataSource.h"

NS_ASSUME_NONNULL_BEGIN

/** UITableViewStylePlain样式使用*/
@interface YJTableViewDataSourcePlain : YJTableViewDataSource

@property (nonatomic, strong) NSMutableArray<YJCellObject *> *dataSource; ///< 数据源

@end

NS_ASSUME_NONNULL_END
