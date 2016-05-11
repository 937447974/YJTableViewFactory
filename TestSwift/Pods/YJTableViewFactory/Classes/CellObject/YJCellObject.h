//
//  YJCellObject.h
//  YJTableViewFactory
//
//  HomePage:https://github.com/937447974/YJTableViewFactory
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/3/26.
//  Copyright © 2016年 YJFactory. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** cell模型协议*/
@protocol YJCellModelProtocol <NSObject>

@end


/** 创建cell的方式*/
typedef NS_ENUM(NSInteger, YJTableViewCellCreate) {
    
    YJTableViewCellCreateDefault,   ///< 默认使用xib创建cell，推荐此方式
    YJTableViewCellCreateSoryboard, ///< 使用soryboard创建cell时，请使用类名作为标识符
    YJTableViewCellCreateClass      ///< 使用Class创建cell,即使用[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:className]创建cell
    
};


/** Cell对象*/
@interface YJCellObject : NSObject

@property (nonatomic) id<YJCellModelProtocol> cellModel; ///< cell对应的VM
@property (nonatomic) YJTableViewCellCreate createCell;  ///< 创建cell的方式
@property (nonatomic, strong, nullable) id userInfo;     ///< 携带的数据

@property (nonatomic) BOOL suspension;           ///< 是否悬浮
@property (nonatomic) BOOL suspensionThroughout; ///< 是否始终悬浮

@property (nonatomic, strong, nullable) NSIndexPath *indexPath; ///< cell所处位置，无须添加，自动填充

@property (nonatomic, readonly) Class cellClass;          ///< UITableViewCell对应的类
@property (nonatomic, copy, readonly) NSString *cellName; ///< UITableViewCell对应的类名

/**
 *  初始化YJCellObject，当不想创建子类时，可使用此方法创建对象
 *
 *  @param cellClass YJTableViewCell对应的类
 *
 *  @return void
 */
- (instancetype)initWithTableViewCellClass:(Class)cellClass;

@end

NS_ASSUME_NONNULL_END
