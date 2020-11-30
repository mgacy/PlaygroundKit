//
//  UIView+Ext.swift
//  
//
//  Created by Mathew Gacy on 10/21/20.
//

import UIKit

extension UIView {

    /// Return subview with name containing `withName`.
    /// - Parameter substring: Partial name of the subview
    /// - Returns: Subview with name containing `withName` if one exists
    ///
    /// Example:
    ///
    ///     let navBar = UINavigationBar()
    ///     let contentView = navBar.subview(withName: "ContentView")
    ///
    public func subview(withName substring: String) -> UIView? {
        for subview in subviews {
            let stringFromClass = NSStringFromClass(subview.classForCoder)
            if stringFromClass.contains(substring) {
                return subview
            }
        }
        return nil
    }

    /// Return layout guide with name containing `withName`.
    /// - Parameter substring: Name of layout guide
    /// - Returns: Layout guide with name containing `withName` if one exists
    ///
    /// Example:
    ///
    ///     let navBar = UINavigationBar()
    ///     let contentView = navBar.subview(withName: "ContentView")
    ///     let titleLayoutGuide = contentView.layoutGuide(withName: "TitleView")
    ///
    public func layoutGuide(withName substring: String) -> UILayoutGuide? {
        for layoutGuide in layoutGuides {
            if layoutGuide.identifier.contains(substring) {
                return layoutGuide
            }
        }
        return nil
    }
}
