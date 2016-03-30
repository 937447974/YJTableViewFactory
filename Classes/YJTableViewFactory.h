//
//  YJTableViewFactory.h
//  YJTableViewFactory
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by 阳君 on 16/3/26.
//  Copyright © 2016年 YJFactory. All rights reserved.
//

/**
 * UITableViewCell相关关系。YJTableViewCell、YJTableViewCellModel、YJTableViewCellObject。
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UITableViewCell+YJTableViewFactory.h"
#import "YJTableViewDataSourcePlain.h"
#import "YJTableViewDataSourceGrouped.h"
#import "YJCellObject.h"
#import "YJTableViewDelegate.h"

NS_ASSUME_NONNULL_BEGIN

/** 获取类名，兼容OC和Swift*/
NSString *YJStringFromClass(Class aClass);

@interface YJTableViewFactory : NSObject

@end

NS_ASSUME_NONNULL_END