//
//  NB.swift
//  NavigationBar
//
//  Created by 邓锋 on 2019/3/8.
//  Copyright © 2019 raisechestnut. All rights reserved.
//

import Foundation
import UIKit
// NB
public class NBWrapper<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

/// Represents a type which is compatible with NB. You can use `rf` property to get a
/// value in the namespace of NB.
public protocol NBCompatible { }

public extension NBCompatible {
    
    /// Gets a namespace holder for NB compatible types.
    public var nb: NBWrapper<Self> {
        get { return NBWrapper(self) }
        set { }
    }
}
extension UIViewController : NBCompatible {}
