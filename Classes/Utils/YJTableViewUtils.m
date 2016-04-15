//
//  YJTableViewUtils.m
//  YJTableViewFactory
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by 阳君 on 16/4/15.
//  Copyright © 2016年 YJFactory. All rights reserved.
//

#import "YJTableViewUtils.h"

#pragma mark 获取类名
NSString *YJStringFromClass(Class aClass) {
    
    NSString *className = NSStringFromClass(aClass);
    NSArray<NSString *> *array = [className componentsSeparatedByString:@"."];
    return array.lastObject;
    
}

@implementation YJTableViewUtils

@end
