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

YJTableViewFactory是一个关于UITableView的开源库，它能使我们的开发工作变得越来越简单。它能使我们的项目架构的可维护性越来越高。

##<a id="1.1">1.1 YJTableViewFactory的优点

YJTableViewFactory具有多重优点：

1. 支持iOS6.0和Swift开发。
2. 支持市面上百分之百的架构，无须修改原有框架结构。你可以把它作为插件，也可以把它作为TableView的控制中心使用。
3. 减压UIViewController，使其代码尽可能的精简，可阅读性更高。UIViewController不在关心UITableViewCell的相关显示，缓存。UIViewController与UITableViewCell完全隔离。
4. 自带存储数据源，支持UITableViewStylePlain和UITableViewStyleGrouped显示的数据源。
5. 自动将数据从UIViewController传输到UITableViewCell，支持任意数据类型的传输，如项目中常用的CellModel、Dictionary字典。
6. 自动register注册UITableViewCell，自动显示UITableViewCell，自动缓存UITableViewCell。多种缓存策略，可根据创建UITableViewCell的类名或UITableViewCell在UITableView的显示位置缓存cell。
7. 自动计算cell显示的高度或手动计算cell显示的高度，并缓存高度。多种缓存策略，可根据创建UITableViewCell的类名或UITableViewCell在UITableView的显示位置缓存高度。
8. 支持多种点击cell的监听方式，可使用protocol或block。
9. 支持多种创建UITableViewCell的方式，如纯代码、xib和storyboard。无须改变你写代码的习惯。

##<a id="1.2">1.2 YJTableViewFactory的缺点

1. 程序员将变的越来越懒！

##<a id="1.3">1.3 导入YJTableViewFactory

导入YJTableViewFactory可使用pod导入，相关命令：

```pod
platform :ios, '6.0'
pod 'YJTableViewFactory'
```

或

```pod
platform :ios, '6.0'
pod 'YJTableViewFactory', :git => 'https://github.com/937447974/YJTableViewFactory.git'
```

pod导入后即可在项目中看见相关文件。

![](https://raw.githubusercontent.com/937447974/Blog/master/Resources/2016041502.png)

#<a id="2">2 相关API

pod导入后重启Xcode即可在Xcode的Documentation And API Reference中查看相关文档，如图所示。

![](https://raw.githubusercontent.com/937447974/Blog/master/Resources/2016041501.png)

##<a id="2.1">2.1 核心[YJTableViewFactory](https://github.com/937447974/YJTableViewFactory/blob/master/Classes/YJTableViewFactory.h)

开发过程中只需导入YJTableViewFactory即可。

这里有个方法`NSString *YJStringFromClass(Class aClass)`兼容swift或oc，获取相同的类名。

##<a id="2.2">2.2 [UITableViewCell扩展](https://github.com/937447974/YJTableViewFactory/blob/master/Classes/Extend/UITableViewCell%2BYJTableViewFactory.h)

使用扩展的方式实现UITableViewCell，这样不用修改项目中已有基类。

`+ (CGFloat)tableView:(UITableView *)tableView heightForCellObject:(YJCellObject *)cellObject`是一个自动计算高的方法，只支持xib创建cell的模式。如果想定制高度，可实现此方法。

`- (void)reloadCellWithCellObject:(YJCellObject *)cellObject tableViewDelegate:(YJTableViewDelegate *)tableViewDelegate`在UITableViewCell将要显示的时候，框架会自动调用此方法通知Cell。

##<a id="2.3">2.3 UITableViewCell封装

###<a id="2.3.1">2.3.1 [YJCellObject](https://github.com/937447974/YJTableViewFactory/blob/master/Classes/CellObject/YJCellObject.h)

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

###<a id="2.4.1">2.4.1 [YJTableViewDataSource](https://github.com/937447974/YJTableViewFactory/blob/master/Classes/DataSource/YJTableViewDataSource.h)

YJTableViewDataSource是一个抽象接口，我们开发过程中不使用这个类，而是使用它的子类YJTableViewDataSourcePlain和YJTableViewDataSourceGrouped。

初始化时通过`[[YJTableViewDataSourcePlain alloc] initWithTableView:self.tableView]`完成初始化，它会自动完成关于tableview的相关配置。

这里可通过cacheCellStrategy修改缓存策略，通过tableViewDelegate修改其内部相关配置。

###<a id="2.4.2">2.4.2 [YJTableViewDataSourcePlain](https://github.com/937447974/YJTableViewFactory/blob/master/Classes/DataSource/YJTableViewDataSourcePlain.h)

YJTableViewDataSourcePlain支持UITableViewStylePlain的显示样式，自带数据源dataSource。


###<a id="2.4.3">2.4.3 [YJTableViewDataSourceGrouped](https://github.com/937447974/YJTableViewFactory/blob/master/Classes/DataSource/YJTableViewDataSourceGrouped.h)

YJTableViewDataSourceGrouped支持UITableViewStyleGrouped的显示样式，自带数据源dataSource。


##<a id="2.5">2.5 [UITableViewDelegate封装](https://github.com/937447974/YJTableViewFactory/blob/master/Classes/Delegate/YJTableViewDelegate.h)

YJTableViewCellProtocol是内部传输的一个数据协议，当我们想在UITableViewCell通知UIViewController就可以通过它，用户点击cell时，框架也会自动调用这个协议通知UIViewController。同时我们也可以是使用YJTableViewCellBlock监听点击cell。

YJTableViewDelegate已填充到YJTableViewDataSource抽象接口，无须再次赋值。这里会自动赋值缓存cell高度的策略，也可定制缓存高的策略。

cellDelegate和cellBlock主要用户监听点击cell。

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
#import "YJTableViewCell.h"

@interface YJFirstViewController () <YJTableViewCellProtocol>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

// 需要强引用
@property (nonatomic, strong) YJTableViewDataSourcePlain *dataSourcePlain;

@end

@implementation YJFirstViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self test1];
//    [self test2];
//    [self test3];
//    [self test4];
    
}

#pragma mark - 测试数据
- (void)initTestData {
    
    // 测试数据
    for (int i=0; i<20; i++) {
        // 封装模型
        YJTableViewCellModel *cellModel = [[YJTableViewCellModel alloc] init];
        cellModel.userName = [NSString stringWithFormat:@"阳君-%d", i];
        // 封装CellObject
        YJCellObject *cellObject = [YJTableViewCell cellObjectWithCellModel:cellModel];
        // 填充数据源
        [self.dataSourcePlain.dataSource addObject:cellObject];
    }
    
}

#pragma mark - 使用默认的YJCellObject
- (void)test1 {
    
    self.dataSourcePlain = [[YJTableViewDataSourcePlain alloc] initWithTableView:self.tableView];
    [self initTestData];
   
}

#pragma mark - 使用自定义的YJTableViewCellObject
- (void)test2 {
    
    self.dataSourcePlain = [[YJTableViewDataSourcePlain alloc] initWithTableView:self.tableView];
    
    // 测试数据
    for (int i=0; i<20; i++) {
        // 封装模型
        YJTableViewCellModel *cellModel = [[YJTableViewCellModel alloc] init];
        cellModel.userName = [NSString stringWithFormat:@"阳君-%d", i];
        // 封装CellObject
        YJTableViewCellObject *cellObject = [[YJTableViewCellObject alloc] init];
        cellObject.cellModel = cellModel;
        // 填充数据源
        [self.dataSourcePlain.dataSource addObject:cellObject];
    }
    
}

#pragma mark - 通过协议监听点击dell
- (void)test3 {
    
    self.dataSourcePlain = [[YJTableViewDataSourcePlain alloc] initWithTableView:self.tableView];
    self.dataSourcePlain.tableViewDelegate.cellDelegate = self;
    [self initTestData];
    
}

#pragma mark YJTableViewDelegateProtocol
- (void)tableViewDidSelectCellWithCellObject:(YJCellObject *)cellObject tableViewCell:(UITableViewCell *)cell {
    
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
}

#pragma mark - 通过block监听点击dell
- (void)test4 {
    
    self.dataSourcePlain = [[YJTableViewDataSourcePlain alloc] initWithTableView:self.tableView];
    self.dataSourcePlain.tableViewDelegate.cellBlock = ^(YJCellObject *cellObject, UITableViewCell *tableViewCell) {
        NSLog(@"%@", cellObject.indexPath);
    };
    [self initTestData];
    
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

YJ技术支持群：557445088

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
| 2016-04-05 | 1.3.0 更新协议UITableViewCell (YJTableViewFactory)可传输YJTableViewDelegate、增加YJTableViewCellBlock可替代YJTableViewCellProtocol使用 |
| 2016-04-07 | 1.3.1 UITableViewCell+YJTableViewFactory 增加生成YJCellObject的方法`+ (id)cellObject`，外部无需初始化YJCellObject |
| 2016-04-07 | 1.3.2 UITableViewCell+YJTableViewFactory 增加方法`+ (id)cellObjectWithCellModel:(id<YJCellModelProtocol>)cellModel;`，自动生成YJCellObject的同时并填充模型。|
| 2016-04-08 | 1.3.3 更新pod导入方式,YJTableViewDelegate增加UITableViewCell向VC发送数据的通用方法`- (void)sendVCWithCellObject:(YJCellObject *)cellObject tableViewCell:(nullable UITableViewCell *)cell;` |
| 2016-04-11 | 1.3.4 pod导入YJTableViewFactory时，会导入文件夹,测试失效 |
| 2016-04-12 | 1.4 YJTableViewDataSource中cacheCellStrategy支持高级需求位置类名双重绑定缓存cell |
| 2016-04-15 | 2.0 YJTableViewFactory重大升级：1.架构调整，YJTableViewCellProtocol和YJTableViewCellBlock从UITableViewCell+YJTableViewFactory.h移动到YJTableViewDelegate.h；2.pod导入后，会在项目中生成相关文件夹，便于查看；3.pod导入后重启Xcode即可在Xcode的Documentation And API Reference中查看相关开发文档。|
| 2016-04-19 | 2.0.1 修复YJTableViewCacheHeightClassAndIndexPath引起的缓存高问题 |
| 2016-05-09 | 2.0.2 架构优化，减少代码量 |
| 2016-05-12 | 2.1.0 使用YJCocoa替代YJTableViewFactory/Utils |
| 2016-05-13 | 3.0.0 因上线YJCollectionView库，YJTableViewFactory架构优化，删除YJTableViewDataSourceGrouped和YJTableViewDataSourcePlain，YJCellObject改为YJTableCellObject |

##Copyright

CSDN：http://blog.csdn.net/y550918116j

GitHub：https://github.com/937447974/Blog