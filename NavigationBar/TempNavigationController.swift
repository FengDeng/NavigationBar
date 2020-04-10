//
//  TempNavigationController.swift
//  NavigationBar
//
//  Created by 邓锋 on 2020/4/10.
//  Copyright © 2020 raisechestnut. All rights reserved.
//

import Foundation
import UIKit

class TempNavigationController : UINavigationController{
    
    override var childForStatusBarHidden: UIViewController?{
        return self.topViewController
    }
}
