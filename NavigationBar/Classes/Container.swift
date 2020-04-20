//
//  Container.swift
//  BaseKit
//
//  Created by 邓锋 on 2019/3/1.
//  Copyright © 2019 yy. All rights reserved.
//

import Foundation
import UIKit

var safeTopHeight : CGFloat{
    if UIDevice.current.userInterfaceIdiom != .phone{
        return UIApplication.shared.statusBarFrame.height
    }
    if #available(iOS 11.0, *) {
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0 ? 44 : UIApplication.shared.statusBarFrame.height
    } else {
        return UIApplication.shared.statusBarFrame.height
    }
}

public class Container : UIView{
    let navBarView : NavigationBar
    weak var originView : UIView?
    weak var viewController : UIViewController?
    var scrollViews = [UIScrollView]()
    init(bar:NavigationBar,originView:UIView,frame:CGRect,viewController:UIViewController) {
        self.viewController = viewController
        self.navBarView = bar
        self.originView = originView
        super.init(frame: frame)
        super.addSubview(originView)
        super.addSubview(navBarView)
        navBarView.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: safeTopHeight + 44)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.originView?.frame = self.bounds
        self.adjustsScrollViewInsets()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public var layer: CALayer{
        return self.originView?.layer ?? CALayer()
    }
    
    ///在最上层添加视图，会遮住bar
    public func nb_addSubview(_ view: UIView) {
        super.addSubview(view)
    }
    
    ///不会遮住bar
    override public func addSubview(_ view: UIView) {
        self.originView?.addSubview(view)
    }
    
    /// 适配UIScrollView contentInset
    fileprivate func adjustsScrollViewInsets(){
        guard let originView = self.originView,!self.navBarView.isHidden else{return}
        
        self.scrollViews = [UIScrollView]()
        self.viewHierarchy(view: originView)
        for scroll in scrollViews{
            if #available(iOS 11.0, *){
                if scroll.contentInsetAdjustmentBehavior == .never{continue}
            }else{
                if let vc = self.viewController,!vc.automaticallyAdjustsScrollViewInsets{continue}
            }
            if scroll.frame.origin.y >= safeTopHeight + 44{continue}
            var insetTom = scroll.contentInset
            insetTom.top = 44 - scroll.frame.origin.y
            scroll.contentInset = insetTom
        }
    }
    
    fileprivate func viewHierarchy(view : UIView){
        if view.isKind(of: UIControl.self){return}
        if let scroll = view as? UIScrollView{
            scrollViews.append(scroll)
        }else{
            for v in view.subviews{
                self.viewHierarchy(view: v)
            }
        }
        
    }
}
