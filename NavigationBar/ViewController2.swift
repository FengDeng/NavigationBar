//
//  ViewController2.swift
//  NavigationBar
//
//  Created by 邓锋 on 2019/3/8.
//  Copyright © 2019 raisechestnut. All rights reserved.
//

import Foundation
import UIKit

class ViewController2 : UIViewController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray
        
        self.title = "我是第二个vc"
        self.nb.navigationBar.backgroundColor = UIColor.green
        self.nb.navigationBar.transparency = 0
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItem.Style.done, target: self, action: #selector(back))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "有bar", style: UIBarButtonItem.Style.done, target: self, action: #selector(hasbar))
        
        
    }

    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func hasbar(){
        self.navigationController?.pushViewController(ViewController4(), animated: true)
    }
}
