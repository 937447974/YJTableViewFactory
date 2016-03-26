//
//  YJCellObject.h
//  YJTableViewFactory
//
//  Created by admin on 16/3/26.
//  Copyright © 2016年 YJFactory. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** cell模型协议*/
@protocol YJCellModelProtocol <NSObject>

@end

/** Cell对象*/
@interface YJCellObject : NSObject

@property (nonatomic) id<YJCellModelProtocol> cellModel;  ///< cell对应的VM
@property (nonatomic, strong, nullable) id userInfo;      ///< 携带的数据

@property (nonatomic, strong, nullable) NSIndexPath *indexPath; ///< cell所处位置，无须添加，自动填充

@property (nonatomic, readonly) Class cellClass;          ///< YJTableViewCell对应的类
@property (nonatomic, copy, readonly) NSString *cellName; ///< YJTableViewCell对应的类名

@end

NS_ASSUME_NONNULL_END
