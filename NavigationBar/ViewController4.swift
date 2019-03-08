//
//  ViewController4.swift
//  NavigationBar
//
//  Created by 邓锋 on 2019/3/8.
//  Copyright © 2019 raisechestnut. All rights reserved.
//

import Foundation
import UIKit

class ViewController4: UIViewController {
 
    
    lazy var tableView : UITableView = {
        let t = UITableView()
        t.dataSource = self
        t.delegate = self
        t.rowHeight = 40
        return t
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.gray
        self.view.addSubview(tableView)
        tableView.frame = self.view.bounds
        
        self.nb.navigationBar.titleAttribute[.foregroundColor] = UIColor.red
        self.nb.navigationBar.viewAttribute[.foregroundColor] = UIColor.red
        
        self.title = "滚动透明度"
        self.nb.navigationBar.backgroundColor = UIColor.black
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItem.Style.done, target: self, action: #selector(back))
    }
    
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension ViewController4 : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 300
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
    
}

extension ViewController4 : UITableViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        if scrollView.contentOffset.y <= -88{
            self.nb.navigationBar.transparency = 0
            return
        }
        if scrollView.contentOffset.y >= 0{
            self.nb.navigationBar.transparency = 1
            return
        }
        self.nb.navigationBar.transparency = (88 + scrollView.contentOffset.y) / 88
    }
}


