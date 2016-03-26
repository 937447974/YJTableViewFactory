//
//  YJTableViewDelegate.h
//  YJTableViewFactory
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by 阳君 on 16/3/26.
//  Copyright © 2016年 YJFactory. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YJTableViewDataSourcePlain.h"
#import "YJTableViewDataSourceGrouped.h"
#import "YJCellObject.h"

NS_ASSUME_NONNULL_BEGIN

@class YJTableViewDelegate;

@protocol YJTableViewDelegateProtocol <NSObject>

/**
 *  用户点击Cell
 *
 *  @param delegate YJTableViewDelegate
 *  @param cellObject 用户点击的cell
 *
 *  @return void
 */
- (void)tableViewDelegate:(YJTableViewDelegate *)delegate didSelectCellObject:(YJCellObject *)cellObject;

@end



/** UITableViewDelegate抽象接口*/
@interface YJTableViewDelegate : NSObject <UITableViewDelegate>

@property (nonatomic) BOOL isCacheHeight; ///< 是否缓存高，默认YES缓存，NO不缓存
@property (nonatomic, weak, nullable) id <YJTableViewDelegateProtocol> delegate; ///< 解耦式使用

/**
 *  初始化
 *
 *  @param dataSource YJTableViewDataSource数据源
 *
 *  @return YJTableViewDelegate
 */
- (instancetype)initWithDataSource:(YJTableViewDataSource *)dataSource;

/**
 *  当dataSource中的数据顺序发生变化时，可清楚缓存高
 *
 *  @return void
 */
- (void)clearCacheHeight;



@end

NS_ASSUME_NONNULL_END
