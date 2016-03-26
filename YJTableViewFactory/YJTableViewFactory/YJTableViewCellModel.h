//
//  YJTableViewCellModel.h
//  YJTableViewFactory
//
//  Created by admin on 16/3/26.
//  Copyright © 2016年 YJFactory. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJTableViewFactory.h"

@interface YJTableViewCellModel : NSObject <YJCellModelProtocol>

@property (nonatomic, copy) NSString *userName; ///< 用户名

@end
