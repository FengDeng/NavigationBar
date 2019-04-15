//
//  Container.swift
//  BaseKit
//
//  Created by 邓锋 on 2019/3/1.
//  Copyright © 2019 yy. All rights reserved.
//

import Foundation
import UIKit

public class Container : UIView{
    let navBarView : NavigationBar
    let originView : UIView
    init(bar:NavigationBar,originView:UIView,frame:CGRect) {
        self.navBarView = bar
        self.originView = originView
        super.init(frame: frame)
        super.addSubview(originView)
        super.addSubview(navBarView)
        navBarView.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIApplication.shared.statusBarFrame.height + 44)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.originView.frame = self.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public var layer: CALayer{
        return self.originView.layer
    }
    
    ///在最上层添加视图，会遮住bar
    public func nb_addSubview(_ view: UIView) {
        super.addSubview(view)
    }
    
    ///不会遮住bar
    override public func addSubview(_ view: UIView) {
        self.originView.addSubview(view)
        if let scroll = view as? UIScrollView,let first = self.originView.subviews.first,first == scroll{
            if #available(iOS 11.0, *) {
                scroll.contentInsetAdjustmentBehavior = .never
            }
            if self.navBarView.transparency == 0 {return}
            var insetTom = scroll.contentInset
            insetTom.top = insetTom.top + UIApplication.shared.statusBarFrame.height + 44
            scroll.contentInset = insetTom
            
            var point = scroll.contentOffset
            point.y = point.y - (UIApplication.shared.statusBarFrame.height + 44)
            scroll.contentOffset = point
        }
    }
}
