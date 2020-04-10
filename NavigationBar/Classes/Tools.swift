//
//  Tools.swift
//  BaseKit
//
//  Created by 邓锋 on 2019/3/8.
//  Copyright © 2019 yy. All rights reserved.
//

import Foundation

func exchangeImplementations(cls:AnyClass,originSelector:Selector,swizzledSelector:Selector){
    let originMethod = class_getInstanceMethod(cls, originSelector)
    let swizzledMethod = class_getInstanceMethod(cls, swizzledSelector)
    let isAdd = class_addMethod(cls, originSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))
    if isAdd{
        class_replaceMethod(cls, swizzledSelector, method_getImplementation(originMethod!), method_getTypeEncoding(originMethod!))
    }else{
        method_exchangeImplementations(originMethod!, swizzledMethod!)
    }
}


