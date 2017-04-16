已弃用，请使用总库YJCocoa。

&#160;

----------

# <a id="Appendix">Appendix

## Author

姓名：阳君

QQ：937447974

YJ技术支持群：557445088

职位：聚美优品iOS攻城师

如果你觉得这个框架很赞，请点击右上角的Star按钮；如果你对我的框架感兴趣，并想持续获得本人最新的框架源文件，欢迎点击右上角的Fork按钮。

如果你也想来和我们一起在聚美优品(北京)从事iOS研发工作，欢迎投递简历到937447974@qq.com。

## Revision History

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
| 2016-05-13 | 3.0.0 因上线YJCollectionView库，YJTableViewFactory架构优化。删除YJTableViewDataSourceGrouped和YJTableViewDataSourcePlain、YJCellObject改为YJTableCellObject、UITableView加速滑动。 |
| 2016-05-13 | 3.0.1 YJTableViewFactory.h增加引用#import "YJTableViewDataSource.h" |
| 2016-05-16 | 3.0.2 YJCocoa架构更新 |
| 2016-05-17 | 3.0.3 修复 NSIndexPath (YJSuspensionCellView)引起的和系统方法冲突 |
| 2016-05-21 | 3.1.0 YJTableViewFactory转入'YJCocoa/CocoaTouchLayer/UIKit/TableView' |
| 2016-10-20 | 3.1.1 YJTableViewFactory转入'YJCocoa' |

## Copyright

CSDN：http://blog.csdn.net/y550918116j

GitHub：https://github.com/937447974/Blog