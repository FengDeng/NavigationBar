//
//  UIViewController+NavigationBar.swift
//  NB
//
//  Created by 邓锋 on 2019/3/1.
//  Copyright © 2019 yy. All rights reserved.
//

import Foundation
import UIKit

private var NavigationBarKey: Void?
extension UIViewController{
    
    fileprivate var bk_NavigationBar : NavigationBar{
        set{
            objc_setAssociatedObject(self, &NavigationBarKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
        get{
            if let bar = objc_getAssociatedObject(self, &NavigationBarKey) as? NavigationBar{
                return bar
            }else{
                let bar = NavigationBar()
                objc_setAssociatedObject(self, &NavigationBarKey, bar, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return bar
            }
        }
    }
    
    func observeNavigationItem(){
        
        self.bk_NavigationBar.title = self.navigationItem.title
        self.bk_NavigationBar.titleOb = self.navigationItem.observe(\UINavigationItem.title, changeHandler: {[weak self] (item, change) in
            self?.bk_NavigationBar.title = item.title
        })
        
        self.bk_NavigationBar.titleView = self.navigationItem.titleView
        self.bk_NavigationBar.titleViewOb = self.navigationItem.observe(\.titleView, changeHandler: {[weak self] (item, change) in
            self?.bk_NavigationBar.titleView = item.titleView
        })
        
        self.bk_NavigationBar.leftView = self.createOptionView(item: self.navigationItem.leftBarButtonItem)
        self.bk_NavigationBar.leftViewOb = self.navigationItem.observe(\.leftBarButtonItem, changeHandler: {[weak self] (item, change) in
            self?.bk_NavigationBar.leftView = self?.createOptionView(item: item.leftBarButtonItem)
        })
        
        self.bk_NavigationBar.leftViews = self.navigationItem.leftBarButtonItems?.map({ (item) -> UIView in
            return self.createView(item: item)
        })
        self.bk_NavigationBar.leftViewsOb = self.navigationItem.observe(\.leftBarButtonItems, changeHandler: {[weak self] (item, change) in
            guard let `self` = self else{return}
            let views = item.leftBarButtonItems?.map({ (item) -> UIView in
                return self.createView(item: item)
            })
            self.bk_NavigationBar.leftViews = views
        })
        
        self.bk_NavigationBar.rightView = self.createOptionView(item: self.navigationItem.rightBarButtonItem)
        self.bk_NavigationBar.rightViewOb = self.navigationItem.observe(\.rightBarButtonItem, changeHandler: {[weak self] (item, change) in
            self?.bk_NavigationBar.rightView = self?.createOptionView(item: item.rightBarButtonItem)
        })
        
        self.bk_NavigationBar.rightViews = self.navigationItem.rightBarButtonItems?.map({ (item) -> UIView in
            return self.createView(item: item)
        })
        self.bk_NavigationBar.rightViewsOb = self.navigationItem.observe(\.rightBarButtonItems, changeHandler: {[weak self] (item, change) in
            guard let `self` = self else{return}
            let views = item.rightBarButtonItems?.map({ (item) -> UIView in
                return self.createView(item: item)
            })
            self.bk_NavigationBar.rightViews = views
        })
        
    }
    
    func createView(item:UIBarButtonItem)->UIView{
        if let view = item.customView{
            return view
        }
        let b = UIButton.init(type: UIButton.ButtonType.custom)
        if let title = item.title{
            b.setAttributedTitle(NSAttributedString.init(string: title, attributes: self.bk_NavigationBar.viewAttribute), for: UIControl.State.normal)
        }
        b.setTitle(item.title, for: UIControl.State.normal)
        b.setImage(item.image, for: UIControl.State.normal)
        if let sel = item.action{
            b.addTarget(item.target, action: sel, for: UIControl.Event.touchUpInside)
        }
        return b
    }
    func createOptionView(item:UIBarButtonItem?)->UIView?{
        guard let item = item else{return nil}
        return createView(item: item)
    }
}


public extension NBWrapper where Base : UIViewController{
    public var navigationBar : NavigationBar{
        return base.bk_NavigationBar
    }
    public var navigationBarHeight : CGFloat{
        return UIApplication.shared.statusBarFrame.height + 44
    }
}

private var NavigationBarEnableKey: Void?
extension UINavigationController{
    fileprivate var _navigationBarEnable : Bool{
        set{
            objc_setAssociatedObject(self, &NavigationBarEnableKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
        get{
            return (objc_getAssociatedObject(self, &NavigationBarEnableKey) as? Bool) ?? false
        }
    }
}


public extension NBWrapper where Base : UINavigationController{
    public var navigationBarEnable : Bool{
        set{
            self.base.isNavigationBarHidden = newValue
            self.base._navigationBarEnable = newValue
        }
        get{
            return self.base._navigationBarEnable
        }
    }
}

//Hook VC 的loadView
extension UIViewController{
    //在ViewController+Load调用该方法
    @objc dynamic static func runInLoad() {
        UIViewController.runOnce
    }
    private static let runOnce : Void = {
        exchangeImplementations(cls: UIViewController.self, originSelector: #selector(UIViewController.loadView), swizzledSelector: #selector(UIViewController.swizzled_loadView))
    }()
    @objc func swizzled_loadView(){
        self.swizzled_loadView()
        if let nav = self.navigationController,nav._navigationBarEnable{
            let originView = self.view ?? UIView()
            let frame = self.view.frame
            let container = Container.init(bar: self.bk_NavigationBar, originView: originView)
            self.observeNavigationItem()
            self.automaticallyAdjustsScrollViewInsets = false
            self.view = container
            self.view.frame = frame
        }
    }
}
