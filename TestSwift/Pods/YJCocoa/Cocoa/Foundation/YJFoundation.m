//
//  YJFoundation.m
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/11.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJFoundation.h"

#pragma mark 获取类名
NSString *YJStringFromClass(Class aClass) {
    
    NSString *className = NSStringFromClass(aClass);
    NSArray<NSString *> *array = [className componentsSeparatedByString:@"."];
    return array.lastObject;
    
}

@implementation YJFoundation

@end
