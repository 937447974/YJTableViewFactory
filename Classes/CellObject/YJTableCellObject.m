//
//  YJTableCellObject.m
//  YJTableViewFactory
//
//  HomePage:https://github.com/937447974/YJTableViewFactory
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/13.
//  Copyright © 2016年 YJFactory. All rights reserved.
//

#import "YJTableCellObject.h"
#import <objc/runtime.h>

@implementation YJTableCellObject

- (instancetype)init {
    self = [super init];
    if (self) {
        _cellName = YJStringFromClass([self class]);
        NSRange range = [_cellName rangeOfString:@"Cell"];
        if (range.length && ![_cellName isEqualToString:YJStringFromClass([YJTableCellObject class])]) {
            _cellName = [_cellName substringWithRange:NSMakeRange(0, range.length + range.location)];// 获取类名
            const char *name = [_cellName cStringUsingEncoding:NSUTF8StringEncoding];
            _cellClass = objc_getClass(name);// 自动填充TableViewCell
        } else {
            NSLog(@"Cell非法命名。如使用YJCell，请以YJTableCellObject命名");
        }
    }
    return self;
}

- (instancetype)initWithTableViewCellClass:(Class)cellClass {
    self = [super init];
    if (self) {
        _cellClass = cellClass;
        _cellName = YJStringFromClass(_cellClass);
    }
    return self;
}

@end