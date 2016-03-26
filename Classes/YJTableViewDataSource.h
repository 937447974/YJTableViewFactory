//
//  YJTableViewDataSource.h
//  YJTableViewFactory
//
//  Created by admin on 16/3/26.
//  Copyright © 2016年 YJFactory. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YJCellObject.h"

NS_ASSUME_NONNULL_BEGIN

/** UITableViewDataSource抽象接口*/
@interface YJTableViewDataSource : NSObject

@property (nonatomic, weak) UITableView *tableView; ///< tableView

@end

NS_ASSUME_NONNULL_END
