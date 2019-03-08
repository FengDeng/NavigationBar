//
//  NavigationBar.swift
//  BaseKit
//
//  Created by 邓锋 on 2019/2/16.
//  Copyright © 2019 yy. All rights reserved.
//

import Foundation
import UIKit

public class NavigationBarAppearance{
    
    public static let appearance = NavigationBarAppearance()
    private init(){}
    
    public var backgroundColor = UIColor.white
    public var titleAttribute : [NSAttributedString.Key : Any] = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 20),NSAttributedString.Key.foregroundColor:UIColor.black]
    public var viewAttribute : [NSAttributedString.Key : Any] = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14),NSAttributedString.Key.foregroundColor:UIColor.black]
    public var leftViewSpace : CGFloat = 10
    public var leftViewsSpace : CGFloat = 5
    public var rightViewSpace : CGFloat = 10
    public var rightViewsSpace : CGFloat = 5
    
    public var backgroundImage : UIImage?
    public var shadowImage : UIImage?
    public var shadowHeight : CGFloat = 1
}


public class NavigationBar : UIView{
    
    public var titleAttribute : [NSAttributedString.Key : Any] = NavigationBarAppearance.appearance.titleAttribute{
        didSet{
            if let text = title{
                self._titleView.attributedText = NSAttributedString.init(string: text, attributes: titleAttribute)
            }
        }
    }
    
    public var attributeTitle : NSAttributedString?{
        didSet{
            self._titleView.attributedText = attributeTitle
        }
    }
    
    public var title : String?{
        didSet{
            if let title = title{
                self._titleView.attributedText = NSAttributedString.init(string: title, attributes: titleAttribute)
            }else{
               self._titleView.attributedText = nil
            }
            
        }
    }
    
    public var titleView : UIView?{
        didSet{
            oldValue?.removeFromSuperview()
            guard let titleView = titleView else{
                self.titleView = _titleView
                self.container.addSubview(_titleView)
                _titleView.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
                _titleView.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
                return
            }
            titleView.updateFrameToAutoLayout()
            self.container.addSubview(titleView)
            titleView.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
            titleView.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        }
    }
    
    public var leftView : UIView?{
        didSet{
            if leftView != nil{
                self.leftViews = nil
            }
            
            oldValue?.removeFromSuperview()
            guard let leftView = leftView else{return}
            leftView.updateFrameToAutoLayout()
            self.container.addSubview(leftView)
            leftView.leftAnchor.constraint(equalTo: self.container.leftAnchor, constant: leftViewSpace).isActive = true
            leftView.centerYAnchor.constraint(equalTo: self.container.centerYAnchor).isActive = true
            
        }
    }
    
    public var leftViews : [UIView]?{
        didSet{
            if leftViews != nil{
                self.leftView = nil
            }
            
            if let oldValue = oldValue{
                for v in oldValue{
                    v.removeFromSuperview()
                }
            }
            guard let leftViews = leftViews else {return}
            var lastV : UIView? = nil
            for v in leftViews{
                self.container.addSubview(v)
                v.updateFrameToAutoLayout()
                if let lastV = lastV{
                    v.leftAnchor.constraint(equalTo: lastV.leftAnchor, constant: leftViewsSpace).isActive = true
                }else{
                    v.leftAnchor.constraint(equalTo: self.container.leftAnchor, constant: leftViewSpace).isActive = true
                }
                v.centerYAnchor.constraint(equalTo: self.container.centerYAnchor).isActive = true
                lastV = v
            }
            
        }
    }
    
    public var rightView : UIView?{
        didSet{
            if rightViews != nil{
                rightViews = nil
            }
            oldValue?.removeFromSuperview()
            guard let rightView = rightView else{return}
            rightView.updateFrameToAutoLayout()
            self.container.addSubview(rightView)
            rightView.rightAnchor.constraint(equalTo: self.container.rightAnchor, constant: -leftViewSpace).isActive = true
            rightView.centerYAnchor.constraint(equalTo: self.container.centerYAnchor).isActive = true
        }
    }
    
    public var rightViews : [UIView]?{
        didSet{
            if self.rightView != nil{
                self.rightView = nil
            }
            if let oldValue = oldValue{
                for v in oldValue{
                    v.removeFromSuperview()
                }
            }
            guard let rightViews = rightViews else {return}
            var lastV : UIView? = nil
            for v in rightViews{
                self.container.addSubview(v)
                v.updateFrameToAutoLayout()
                if let lastV = lastV{
                    v.rightAnchor.constraint(equalTo: lastV.leftAnchor, constant: -leftViewsSpace).isActive = true
                }else{
                    v.rightAnchor.constraint(equalTo: self.container.rightAnchor, constant: -leftViewSpace).isActive = true
                }
                v.centerYAnchor.constraint(equalTo: self.container.centerYAnchor).isActive = true
                lastV = v
            }
            
        }
    }
    
    public var backgroundImage : UIImage?{
        didSet{
            self.backgroundImageView.image = backgroundImage
        }
    }
    public var shadowImage : UIImage?{
        didSet{
            self.shadowImageView.image = shadowImage
        }
    }
    public var shadowHeight : CGFloat = NavigationBarAppearance.appearance.shadowHeight{
        didSet{
            shadowImageView.heightAnchor.constraint(equalToConstant: shadowHeight).isActive = true
        }
    }
    
    public override var backgroundColor: UIColor?{
        set{
            self.backgroundImageView.backgroundColor = newValue
        }get{
            return self.backgroundImageView.backgroundColor
        }
    }
    
    public var transparency : CGFloat = 1{
        didSet{
            self.backgroundImageView.alpha = transparency
        }
    }
    
    public var viewAttribute : [NSAttributedString.Key : Any] = NavigationBarAppearance.appearance.viewAttribute
    
    public var leftViewSpace : CGFloat = NavigationBarAppearance.appearance.leftViewSpace
    public var leftViewsSpace : CGFloat = NavigationBarAppearance.appearance.leftViewsSpace
    public var rightViewSpace : CGFloat = NavigationBarAppearance.appearance.rightViewSpace
    public var rightViewsSpace : CGFloat = NavigationBarAppearance.appearance.rightViewsSpace
    
    
    //不包含statusbar 外部addview都在这个view上面
    private let container = UIView()
    private let _titleView = UILabel()
    private let backgroundImageView = UIImageView()
    private let shadowImageView = UIImageView()
    
    //用来监听navigationItem上元素的变化，这里引用下，不然要为vc写好多Associated 属性
    var titleOb : NSKeyValueObservation?
    var titleViewOb : NSKeyValueObservation?
    var leftViewOb : NSKeyValueObservation?
    var leftViewsOb : NSKeyValueObservation?
    var rightViewOb : NSKeyValueObservation?
    var rightViewsOb : NSKeyValueObservation?
    
    //禁止设置自己的alpha
    public override var alpha: CGFloat{
        set{
            
        }
        get{
            return 1
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let appearance = NavigationBarAppearance.appearance
        
        backgroundImageView.layer.masksToBounds = true
        backgroundImageView.contentMode = .scaleAspectFill
        self.backgroundImageView.backgroundColor = appearance.backgroundColor
        backgroundImageView.image = appearance.backgroundImage
        super.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: super.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: super.bottomAnchor).isActive = true
        backgroundImageView.leftAnchor.constraint(equalTo: super.leftAnchor).isActive = true
        backgroundImageView.rightAnchor.constraint(equalTo: super.rightAnchor).isActive = true
        
        shadowImageView.layer.masksToBounds = true
        shadowImageView.contentMode = .scaleAspectFill
        shadowImageView.image = appearance.shadowImage
        super.addSubview(shadowImageView)
        shadowImageView.translatesAutoresizingMaskIntoConstraints = false
        shadowImageView.heightAnchor.constraint(equalToConstant: self.shadowHeight).isActive = true
        shadowImageView.bottomAnchor.constraint(equalTo: super.bottomAnchor).isActive = true
        shadowImageView.leftAnchor.constraint(equalTo: super.leftAnchor).isActive = true
        shadowImageView.rightAnchor.constraint(equalTo: super.rightAnchor).isActive = true
        
        container.backgroundColor = UIColor.clear
        super.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.topAnchor.constraint(equalTo: super.topAnchor, constant: UIApplication.shared.statusBarFrame.height).isActive = true
        container.bottomAnchor.constraint(equalTo: super.bottomAnchor).isActive = true
        container.leftAnchor.constraint(equalTo: super.leftAnchor).isActive = true
        container.rightAnchor.constraint(equalTo: super.rightAnchor).isActive = true
        
        self.titleView = _titleView
        _titleView.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(_titleView)
        _titleView.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        _titleView.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        print("deinit navigationBar")
    }
    
    public override func addSubview(_ view: UIView) {
        container.addSubview(view)
    }

    
}

extension UIView{
    func updateFrameToAutoLayout(){
        self.translatesAutoresizingMaskIntoConstraints = false
        if self.bounds.width > 0 && self.bounds.height > 0{
            self.widthAnchor.constraint(equalToConstant: self.bounds.width).isActive = true
            self.heightAnchor.constraint(equalToConstant: self.bounds.height).isActive = true
        }
    }
}




