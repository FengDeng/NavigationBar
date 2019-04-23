//
//  NavigationBar.swift
//  BaseKit
//
//  Created by 邓锋 on 2019/2/16.
//  Copyright © 2019 yy. All rights reserved.
//

import Foundation
import UIKit

extension UIStackView{
    func removeAllArrangedView(){
        for view in self.arrangedSubviews{
            self.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
}

public class NavigationBarAppearance{
    
    public static let appearance = NavigationBarAppearance()
    private init(){}
    
    public var backgroundColor = UIColor.white
    public var titleAttribute : [NSAttributedString.Key : Any] = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 20),NSAttributedString.Key.foregroundColor:UIColor.black]
    public var itemAttribute : [NSAttributedString.Key : Any] = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14),NSAttributedString.Key.foregroundColor:UIColor.black]
    public var leftViewSpace : CGFloat = 10
    public var leftViewsSpace : CGFloat = 5
    public var rightViewSpace : CGFloat = 10
    public var rightViewsSpace : CGFloat = 5
    
    public var backgroundImage : UIImage?
    public var shadowColor : UIColor?
    public var shadowImage : UIImage?
    public var shadowHeight : CGFloat = 1
}


public class NavigationBar : UIView{
    
    public var titleAttribute : [NSAttributedString.Key : Any] = NavigationBarAppearance.appearance.titleAttribute{
        didSet{
            if let text = title{
                self._titleView.attributedText = NSAttributedString.init(string: text, attributes: titleAttribute)
            }
            if let color = titleAttribute[.foregroundColor] as? UIColor{
                self._titleView.textColor = color
            }
            if let font = titleAttribute[.font] as? UIFont{
                self._titleView.font = font
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
    
    public lazy var leftItemRightAnchor : NSLayoutXAxisAnchor = {
        return self.leftStackView.rightAnchor
    }()
    private lazy var leftStackView : UIStackView = {
        let s = UIStackView()
        s.axis = NSLayoutConstraint.Axis.horizontal
        s.alignment = UIStackView.Alignment.center
        s.spacing = self.leftViewsSpace
        s.distribution = .equalSpacing
        s.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: NSLayoutConstraint.Axis.horizontal)
        return s
    }()
    public var leftView : UIView?{
        didSet{
            self.leftStackView.removeAllArrangedView()
            guard let leftView = leftView else{return}
            leftView.updateFrameToAutoLayout()
            self.leftStackView.addArrangedSubview(leftView)
        }
    }

    public var leftViews : [UIView]?{
        didSet{
            self.leftStackView.removeAllArrangedView()
            guard let leftViews = leftViews else{return}
            for view in leftViews{
                view.updateFrameToAutoLayout()
                self.leftStackView.addArrangedSubview(view)
            }
        }
    }
    
    public lazy var rightItemLeftAnchor : NSLayoutXAxisAnchor = {
        return self.rightStackView.leftAnchor
    }()
    private lazy var rightStackView : UIStackView = {
        let s = UIStackView()
        s.axis = NSLayoutConstraint.Axis.horizontal
        s.alignment = UIStackView.Alignment.center
        s.spacing = self.rightViewsSpace
        s.distribution = .equalSpacing
        s.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: NSLayoutConstraint.Axis.horizontal)
        return s
    }()
    public var rightView : UIView?{
        didSet{
            self.rightStackView.removeAllArrangedView()
            guard let rightView = rightView else{return}
            rightView.updateFrameToAutoLayout()
            self.rightStackView.addArrangedSubview(rightView)
        }
    }
    
    public var rightViews : [UIView]?{
        didSet{
            self.rightStackView.removeAllArrangedView()
            guard let rightViews = rightViews else{return}
            for view in rightViews{
                view.updateFrameToAutoLayout()
                self.rightStackView.addArrangedSubview(view)
            }
        }
    }
    
    public var backgroundImage : UIImage?{
        didSet{
            self.backgroundImageView.image = backgroundImage
        }
    }
    public var shadowColor : UIColor?{
        didSet{
            self.shadowImageView.backgroundColor = shadowColor
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
    
    public var itemAttribute : [NSAttributedString.Key : Any] = NavigationBarAppearance.appearance.itemAttribute
    
    public var leftViewSpace : CGFloat = NavigationBarAppearance.appearance.leftViewSpace{
        didSet{
            leftStackView.leftAnchor.constraint(equalTo: self.container.leftAnchor, constant: leftViewSpace).isActive = true
        }
    }
    public var leftViewsSpace : CGFloat = NavigationBarAppearance.appearance.leftViewsSpace{
        didSet{
            self.leftStackView.spacing = leftViewsSpace
        }
    }
    public var rightViewSpace : CGFloat = NavigationBarAppearance.appearance.rightViewSpace{
        didSet{
            rightStackView.rightAnchor.constraint(equalTo: self.container.rightAnchor, constant: -rightViewSpace).isActive = true
        }
    }
    public var rightViewsSpace : CGFloat = NavigationBarAppearance.appearance.rightViewsSpace{
        didSet{
            self.rightStackView.spacing = rightViewsSpace
        }
    }
    
    
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
        shadowImageView.backgroundColor = appearance.shadowColor
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
        
        if let color = titleAttribute[.foregroundColor] as? UIColor{
            self._titleView.textColor = color
        }
        if let font = titleAttribute[.font] as? UIFont{
            self._titleView.font = font
        }
        self.titleView = _titleView
        _titleView.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(_titleView)
        _titleView.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        _titleView.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        
        leftStackView.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(leftStackView)
        leftStackView.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        leftStackView.topAnchor.constraint(equalTo: self.container.topAnchor)
        leftStackView.bottomAnchor.constraint(equalTo: self.container.bottomAnchor)
        leftStackView.leftAnchor.constraint(equalTo: self.container.leftAnchor, constant: leftViewSpace).isActive = true
        //leftStackView.widthAnchor.constraint(equalToConstant: 200)
        
        rightStackView.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(rightStackView)
        rightStackView.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        rightStackView.topAnchor.constraint(equalTo: self.container.topAnchor)
        rightStackView.bottomAnchor.constraint(equalTo: self.container.bottomAnchor)
        rightStackView.rightAnchor.constraint(equalTo: self.container.rightAnchor, constant: -rightViewSpace).isActive = true
        //rightStackView.widthAnchor.constraint(equalToConstant: 200)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
//        print("deinit navigationBar")
        
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




