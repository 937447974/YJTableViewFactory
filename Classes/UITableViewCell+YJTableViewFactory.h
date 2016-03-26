//
//  UITableViewCell+YJTableViewFactory.h
//  YJTableViewFactory
//
//  Created by admin on 16/3/26.
//  Copyright © 2016年 YJFactory. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJCellObject.h"

NS_ASSUME_NONNULL_BEGIN

/** UITableViewCell扩展*/
@interface UITableViewCell (YJTableViewFactory)

/**
 *  获取cell的显示高。子类不实行时，会根据xib设置的高度自动计算高
 *
 *  @param cellObject cell封装的对象
 *
 *  @return CGFloat
 */
+ (CGFloat)tableView:(UITableView *)tableView heightForCellObject:(YJCellObject *)cellObject;

/**
 *  根据模型刷新Cell
 *
 *  @param cellObject cell封装的对象
 *
 *  @return void
 */
- (void)reloadCellWithCellObject:(YJCellObject *)cellObject;

@end

NS_ASSUME_NONNULL_END
