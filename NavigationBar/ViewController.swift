//
//  ViewController.swift
//  NavigationBar
//
//  Created by 邓锋 on 2019/3/8.
//  Copyright © 2019 raisechestnut. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let bgColors = [UIColor.white,UIColor.red,UIColor.blue,UIColor.green,UIColor.yellow]
    
    let datas = ["改变背景色","隐藏或者显示","背景透明按钮标题不透明","跳转到无navigationBar的vc","滚动修改透明度"]
    
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
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        tableView.frame = self.view.bounds
        
        self.title = "我是第一个vc"
        self.nb.navigationBar.backgroundColor = UIColor.blue
    }


}

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = datas[indexPath.row]
        return cell
    }
    
    
}
extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            self.nb.navigationBar.backgroundColor = self.bgColors.randomElement()
        }
        if indexPath.row == 1{
            self.nb.navigationBar.isHidden = !self.nb.navigationBar.isHidden
        }
        if indexPath.row == 2{
            self.navigationController?.pushViewController(ViewController2(), animated: true)
        }
        if indexPath.row == 3{
            self.navigationController?.pushViewController(ViewController3(), animated: true)
            
        }
        if indexPath.row == 4{
            self.navigationController?.pushViewController(ViewController4(), animated: true)
            
        }
        
    }
}

