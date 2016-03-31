1 [YJTableViewFactory](#1)

1. [YJTableViewFactory的优点](#1.1)
2. [YJTableViewFactory的缺点](#1.2)
3. [导入YJTableViewFactory](#1.3)

2 [相关API](#2)

1. [核心YJTableViewFactory](#2.1)
2. [UITableViewCell扩展](#2.2)
3. [UITableViewCell封装](#2.3)
	1. [YJCellObject](#2.3.1)
	2. [YJCellObject的子类化](#2.3.2)
4. [UITableViewDataSource封装](#2.4)
	1. [YJTableViewDataSource](#2.4.1)
	2. [YJTableViewDataSourcePlain](#2.4.2)
	3. [YJTableViewDataSourceGrouped](#2.4.3)
5. [UITableViewDelegate封装](#2.5)

3 [实战演练](#3)

[Appendix](#Appendix)

----

#<a id="1">1 YJTableViewFactory

没有最牛逼，只有更牛逼！

YJTableViewFactory就是一个非常牛逼的开源库，它能使我们的开发工作变得越来越简单。它能使我们的项目越来越具有可维护性。

不要不相信，看完就知道它有多牛逼！！！

##<a id="1.1">1.1 YJTableViewFactory的优点

YJTableViewFactory具有多重优点：

1. 减压UIViewController，使其代码尽可能的精简，可阅读性更高。UIViewController不在关心UITableView的相关显示，缓存。UIViewController与UITableViewCell完全隔离。
2. 自动register注册UITableViewCell，自动显示UITableViewCell，自动缓存UITableViewCell。多种缓存策略，可根据创建UITableViewCell的类名或UITableViewCell在UITableView的显示位置缓存cell。
3. 自带存储数据源，支持UITableViewStylePlain和UITableViewStyleGrouped显示的数据源。
4. 自动将数据从UIViewController传输到UITableViewCell，支持任意数据类型的传输，如项目中常用的CellModel、Dictionary字典。
5. 自动计算cell显示的高度或手动计算cell显示的高度，并缓存高度。多种缓存策略，可根据创建UITableViewCell的类名或UITableViewCell在UITableView的显示位置缓存高度。
6. 支持多种创建UITableViewCell的方式，如纯代码、xib和storyboard。无须改变你写代码的习惯。
7. 支持市面上百分之百的架构，无须修改原有框架结构。你可以把它作为插件，也可以把它作为TableView的控制中心使用。

##<a id="1.2">1.2 YJTableViewFactory的缺点

1. 程序员将变的越来越懒！

##<a id="1.3">1.3 导入YJTableViewFactory

导入YJTableViewFactory可使用pod导入，相关命令：

```pod
pod 'YJTableViewFactory'
```

#<a id="2">2 相关API

##<a id="2.1">2.1 核心YJTableViewFactory

开发过程中只需导入YJTableViewFactory即可。

```objc
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
```

这里有个方法`NSString *YJStringFromClass(Class aClass)`兼容swift或oc，获取相同的类名。

##<a id="2.2">2.2 UITableViewCell扩展

使用扩展的方式实现UITableViewCell，这样不用修改项目中已有基类。

```objc
//
//  UITableViewCell+YJTableViewFactory.h
//  YJTableViewFactory
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by 阳君 on 16/3/26.
//  Copyright © 2016年 YJFactory. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJCellObject.h"

NS_ASSUME_NONNULL_BEGIN

@protocol YJTableViewCellProtocol <NSObject>

/**
 *  用户点击Cell
 *
 *  @param cellObject    用户点击的cell数据
 *  @param tableViewCell 用户点击的Cell
 *
 *  @return void
 */
- (void)tableViewDidSelectCellWithCellObject:(YJCellObject *)cellObject tableViewCell:(nullable UITableViewCell *)cell;

@end


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
 *  @param cellProtocol YJTableViewCellProtocol
 *
 *  @return void
 */
- (void)reloadCellWithCellObject:(YJCellObject *)cellObject cellProtocol:(nullable id<YJTableViewCellProtocol>)cellProtocol;

@end

NS_ASSUME_NONNULL_END
```

YJTableViewCellProtocol是内部传输的一个数据协议，当我们想在UITableViewCell通知UIViewController就可以通过它，用户点击cell时，框架也会自动调用这个协议通知UIViewController。


`+ (CGFloat)tableView:(UITableView *)tableView heightForCellObject:(YJCellObject *)cellObject`是一个自动计算高的方法，只支持xib创建cell的模式。如果想定制高度，可实现此方法。

`- (void)reloadCellWithCellObject:(YJCellObject *)cellObject cellProtocol:(nullable id<YJTableViewCellProtocol>)cellProtocol`在UITableViewCell将要显示的时候，框架会自动调用此方法通知Cell。

##<a id="2.3">2.3 UITableViewCell封装

###<a id="2.3.1">2.3.1 YJCellObject

```objc
//
//  YJCellObject.h
//  YJTableViewFactory
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
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
    YJTableViewCellCreateSoryboard, ///< 使用soryboard创建cell时，请使用类名作为标识符。
    YJTableViewCellCreateClass      ///< 使用Class创建cell,即使用[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:className]，可自行修改实现
    
};


/** Cell对象*/
@interface YJCellObject : NSObject

@property (nonatomic) id<YJCellModelProtocol> cellModel; ///< cell对应的VM
@property (nonatomic) YJTableViewCellCreate createCell;  ///< 创建cell的方式
@property (nonatomic, strong, nullable) id userInfo;     ///< 携带的数据

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
```

YJCellObject为UITableViewCell关于模型的封装。

可携带模型，模型实现YJCellModelProtocol协议即可，这是一个空协议；可传输字典，使用userInfo即可；还可定制生成cell的方式createCell。

>这里推荐使用xib创建cell，可重用可维护性非常高。

YJCellObject已支持大多数的功能，当然，我们也可以子类化YJCellObject。如果不子类化，可通过`initWithTableViewCellClass `创建cellObject，如：

```objc
YJCellObject *cellObject = [[YJCellObject alloc] initWithTableViewCellClass:[YJTableViewCell class]];
```

###<a id="2.3.2">2.3.2 YJCellObject的子类化

YJCellObject子类化后，我们可携带更多的参数了。

此时命名规范会有点要求，如创建的Cell为YJTableViewCell，则其对应的CellObject为YJTableViewCellObject。这样可通过

```
YJTableViewCellObject *cellObject = [[YJTableViewCellObject alloc] init];
```

创建。框架会自动通过YJTableViewCellObject类抓取YJTableViewCell类名。

##<a id="2.4">2.4 UITableViewDataSource封装

###<a id="2.4.1">2.4.1 YJTableViewDataSource

```objc
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
#import "UITableViewCell+YJTableViewFactory.h"

NS_ASSUME_NONNULL_BEGIN

@class YJTableViewDelegate;

/** 缓存Cell的策略*/
typedef NS_ENUM(NSInteger, YJTableViewCacheCell) {
    
    YJTableViewCacheCellDefault,  ///< 根据相同的UITableViewCell类名缓存Cell
    YJTableViewCacheCellIndexPath ///< 根据NSIndexPath对应的位置缓存Cell
    
};


/** UITableViewDataSource抽象接口*/
@interface YJTableViewDataSource : NSObject <UITableViewDataSource>

@property (nonatomic) YJTableViewCacheCell cacheCellStrategy;                   ///< 缓存Cell的策略
@property (nonatomic, weak) UITableView *tableView;                             ///< tableView
@property (nonatomic, strong, readonly) YJTableViewDelegate *tableViewDelegate; ///< YJTableViewDelegate,无须赋值，自动化创建

/**
 *  抽象的初始化接口,会自动填充设置tableView.dataSource = self;tableView.delegate = self.tableViewDelegate;
 *
 *  @param tableView UITableView
 *
 *  @return YJTableViewDataSourceGrouped 或 YJTableViewDataSourcePlain
 */
- (instancetype)initWithTableView:(UITableView *)tableView;

/**
 *  根据cellObject创建UITableViewCell
 *
 *  @param cellObject YJCellObject
 *
 *  @return UITableViewCell
 */
- (UITableViewCell *)dequeueReusableCellWithCellObject:(YJCellObject *)cellObject;

@end

NS_ASSUME_NONNULL_END
```

YJTableViewDataSource是一个抽象接口，我们开发过程中不使用这个类，而是使用它的子类YJTableViewDataSourcePlain和YJTableViewDataSourceGrouped。

初始化时通过`[[YJTableViewDataSourcePlain alloc] initWithTableView:self.tableView]`完成初始化，它会自动完成关于tableview的相关配置。

这里可通过cacheCellStrategy修改缓存策略，通过tableViewDelegate修改其内部相关配置。

###<a id="2.4.2">2.4.2 YJTableViewDataSourcePlain

YJTableViewDataSourcePlain支持UITableViewStylePlain的显示样式，自带数据源dataSource。

```objc
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
```

###<a id="2.4.3">2.4.3 YJTableViewDataSourceGrouped

YJTableViewDataSourceGrouped支持UITableViewStyleGrouped的显示样式，自带数据源dataSource。

```objc
//
//  YJTableViewDataSourceGrouped.h
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

/** UITableViewStyleGrouped样式*/
@interface YJTableViewDataSourceGrouped : YJTableViewDataSource

@property (nonatomic, strong) NSMutableArray<NSMutableArray<YJCellObject *> *> *dataSource; ///< 数据源

@end

NS_ASSUME_NONNULL_END
```

##<a id="2.5">2.5 UITableViewDelegate封装

```objc
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
#import "UITableViewCell+YJTableViewFactory.h"

NS_ASSUME_NONNULL_BEGIN

@class YJTableViewDataSource;

/** 缓存高的策略*/
typedef NS_ENUM(NSInteger, YJTableViewCacheHeight) {
    
    YJTableViewCacheHeightDefault,  ///< 根据相同的UITableViewCell类缓存高度
    YJTableViewCacheHeightIndexPath ///< 根据NSIndexPath对应的位置缓存高度
    
};

/** UITableViewDelegate抽象接口*/
@interface YJTableViewDelegate : NSObject <UITableViewDelegate>

@property (nonatomic) BOOL isCacheHeight;                                    ///< 是否缓存高，默认YES缓存，NO不缓存
@property (nonatomic) YJTableViewCacheHeight cacheHeightStrategy;            ///< 缓存高的策略。无须赋值，YJTableViewDataSource抽象接口会根据cacheCellStrategy自动赋值
@property (nonatomic, weak, nullable) id <YJTableViewCellProtocol> delegate; ///< 解耦式使用,点击cell

/**
 *  初始化
 *
 *  @param dataSource YJTableViewDataSource数据源
 *
 *  @return YJTableViewDelegate
 */
- (instancetype)initWithDataSource:(YJTableViewDataSource *)dataSource;

/**
 *  清除所有缓存高
 *
 *  @return void
 */
- (void)clearAllCacheHeight;

/**
 *  根据cell的类清楚缓存高，cacheHeightStrategy = YJTableViewCacheHeightDefault
 *
 *  @param cellClass UITableViewCell类
 *
 *  @return void
 */
- (void)clearCacheHeightWithCellClass:(Class)cellClass;

/**
 *  根据NSIndexPath位置清除缓存高，cacheHeightStrategy = YJTableViewCacheHeightIndexPath
 *
 *  @param indexPath NSIndexPath
 *
 *  @return void
 */
- (void)clearCacheHeightWithIndexPath:(NSIndexPath *)indexPath;

/**
 *  根据NSIndexPath集合清除对应的缓存高，cacheHeightStrategy = YJTableViewCacheHeightIndexPath
 *
 *  @param indexPaths NSIndexPath集合
 *
 *  @return void
 */
- (void)clearCacheHeightWithIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

/**
 *  清除[startIndexPath,endIndexPath]的缓存高，cacheHeightStrategy = YJTableViewCacheHeightIndexPath
 *
 *  @param cellClass UITableViewCell类
 *
 *  @return void
 */
- (void)clearCacheHeightWithFromIndexPath:(NSIndexPath *)startIndexPath toIndexPath:(NSIndexPath *)endIndexPath;

@end

NS_ASSUME_NONNULL_END
```

YJTableViewDelegate已填充到YJTableViewDataSource抽象接口，无须再次赋值。这里会自动赋值缓存cell高度的策略，也可定制缓存高的策略。

还有大量清除缓存高的方法，让cell的高度缓存更灵活。

#<a id="3">3 实战演练

相关详细代码可查看demo，这里为大家展示一个极简的UIViewController。

```objc
//
//  YJFirstViewController.m
//  YJTableViewFactory
//
//  Created by admin on 16/3/26.
//  Copyright © 2016年 YJFactory. All rights reserved.
//

#import "YJFirstViewController.h"
#import "YJTableViewFactory.h"
#import "YJTableViewCell.h"

@interface YJFirstViewController () <YJTableViewCellProtocol>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

// 需要强引用
@property (nonatomic, strong) YJTableViewDataSourcePlain *dataSourcePlain;

@end

@implementation YJFirstViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.dataSourcePlain = [[YJTableViewDataSourcePlain alloc] initWithTableView:self.tableView];
    self.dataSourcePlain.tableViewDelegate.delegate = self;
    
    // 测试数据
    for (int i=0; i<20; i++) {
        // 封装模型
        YJTableViewCellModel *cellModel = [[YJTableViewCellModel alloc] init];
        cellModel.userName = [NSString stringWithFormat:@"阳君-%d", i];
        // 封装CellObject
        YJCellObject *cellObject = [[YJCellObject alloc] initWithTableViewCellClass:[YJTableViewCell class]];
        cellObject.cellModel = cellModel;
        // 填充数据源
        [self.dataSourcePlain.dataSource addObject:cellObject];
    }
    
}

#pragma mark - YJTableViewDelegateProtocol
- (void)tableViewDidSelectCellWithCellObject:(YJCellObject *)cellObject tableViewCell:(UITableViewCell *)cell {
    
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
}

@end
```

看完之后是不是感觉UIViewController很简洁，酸爽。

&#160;

----------

#<a id="Appendix">Appendix

##Author

姓名：阳君

QQ：937447974

职位：聚美优品iOS攻城师

如果你觉得这个框架很赞，请点击右上角的Star按钮；如果你对我的框架感兴趣，并想持续获得本人最新的框架源文件，欢迎点击右上角的Fork按钮。

如果你也想来和我们一起在聚美优品(北京)从事iOS研发工作，欢迎投递简历到937447974@qq.com。

##Revision History

| 时间 | 描述 |
| ---- | ---- |
| 2016-03-29 | 1.1.0 相关功能开发完毕，正式上线运行 |
| 2016-03-29 | 1.1.1 添加相关说明文档 |
| 2016-03-30 | 1.2.0 支持swift开发 |
| 2016-03-31 | 1.2.1 支持iOS6开发 |
| 2016-03-31 | 1.2.2 修复class模式下无法创建cell的问题 |

##Copyright

CSDN：http://blog.csdn.net/y550918116j

GitHub：https://github.com/937447974/Blog