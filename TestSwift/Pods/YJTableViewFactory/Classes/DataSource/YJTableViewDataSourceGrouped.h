//
//  HomePage:https://github.com/937447974/YJTableViewFactory
//  YJ技术支持群:557445088
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by 阳君 on 16/3/26.
//  Copyright © 2016年 YJFactory. All rights reserved.
//

#import "YJTableViewDataSource.h"

NS_ASSUME_NONNULL_BEGIN

/** UITableViewStyleGrouped样式*/
@interface YJTableViewDataSourceGrouped : YJTableViewDataSource

@property (nonatomic, strong) NSMutableArray<NSMutableArray<YJCellObject *> *> *dataSource; ///< 数据源

@end

NS_ASSUME_NONNULL_END
