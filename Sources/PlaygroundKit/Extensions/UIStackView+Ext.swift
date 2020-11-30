//
//  UIStackView+Ext.swift
//  
//
//  Created by Mathew Gacy on 10/21/20.
//

import UIKit

extension UIStackView {

    // TODO: rename
    // FIXME: this fails when a subview is another `UIStackView`
    public var intrinsicDimensionAlongAxis: CGFloat {
        let x: CGFloat
        switch axis {
        case .horizontal:
            x = subviews.reduce(0) { $0 + $1.intrinsicContentSize.width }
        case .vertical:
            x = subviews.reduce(0) { $0 + $1.intrinsicContentSize.height }
        @unknown default:
            fatalError("Unrecognized NSLayoutConstraint.Axis for UIStackView: \(axis)")
        }
        return x + spacing * CGFloat((subviews.count - 1))
    }
}
