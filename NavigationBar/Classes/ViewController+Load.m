//
//  ViewController.m
//  BaseKit
//
//  Created by 邓锋 on 2019/3/5.
//  Copyright © 2019 yy. All rights reserved.
//

#import <UIKit/UIKit.h>

@implementation UIViewController (Load)
+ (void)load{
    [NSClassFromString(@"UIViewController") performSelector:@selector(runInLoad)];
}
@end
