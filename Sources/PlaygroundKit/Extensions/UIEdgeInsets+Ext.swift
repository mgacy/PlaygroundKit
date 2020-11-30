//
//  UIEdgeInsets+Ext.swift
//  
//
//  Created by Mathew Gacy on 10/21/20.
//

import UIKit

// MARK: - Properties
extension UIEdgeInsets {

    public var width: CGFloat {
        get {
            return left + right
        }
        set {
            left = newValue * 0.5
            right = newValue * 0.5
        }
    }

    public var height: CGFloat {
        get {
            return top + bottom
        }
        set {
            top = newValue * 0.5
            bottom = newValue * 0.5
        }
    }
}

// MARK: - Initializers
extension UIEdgeInsets {

    public init(width: CGFloat, height: CGFloat) {
        self.init(top: height * 0.5, left: width * 0.5,
                  bottom: height * 0.5, right: width * 0.5)
    }
}
