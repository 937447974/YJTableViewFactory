//
//  YJTableViewDataSource.h
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
#import "YJCellObject.h"

NS_ASSUME_NONNULL_BEGIN

/** UITableViewDataSource抽象接口*/
@interface YJTableViewDataSource : NSObject

@property (nonatomic, weak) UITableView *tableView; ///< tableView

/**
 *  抽象的初始化接口
 *
 *  @param tableView UITableView
 *
 *  @return void
 */
- (instancetype)initWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
