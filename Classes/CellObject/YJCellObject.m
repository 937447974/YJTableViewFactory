//
//  YJCellObject.m
//  YJTableViewFactory
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by 阳君 on 16/3/26.
//  Copyright © 2016年 YJFactory. All rights reserved.
//

#import "YJCellObject.h"
#import <objc/runtime.h>
#import "YJTableViewFactory.h"

@interface YJCellObject ()

@end

@implementation YJCellObject

- (instancetype)init {
    
    self = [super init];
    if (self) {
        _cellName = YJStringFromClass([self class]);
        NSRange range = [_cellName rangeOfString:@"Cell"];
        if (range.length && ![_cellName isEqualToString:YJStringFromClass([YJCellObject class])]) {
            _cellName = [_cellName substringWithRange:NSMakeRange(0, range.length + range.location)];// 获取类名
            const char *name = [_cellName cStringUsingEncoding:NSUTF8StringEncoding];
            _cellClass = objc_getClass(name);// 自动填充TableViewCell            
        } else {
            NSLog(@"Cell非法命名。如使用YJCell，请以YJCellObject命名");
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
