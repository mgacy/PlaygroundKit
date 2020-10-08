//
//  X.swift
//  PlaygroundKit
//
//  Created by Mathew Gacy on 10/7/20.
//  Copyright © 2020 Mathew Gacy. All rights reserved.
//

import UIKit

public enum WindowSize {
    case iPhone8
    case iPhoneX
    case iPhoneMax
    case iPad
    case iPadPortraint

    // See:
    // https://developer.apple.com/library/archive/documentation/DeviceInformation/Reference/iOSDeviceCompatibility/Displays/Displays.html
    public var size: CGSize {
        switch self {
        case .iPhone8: return CGSize(width: 375, height: 667)
        case .iPhoneX: return CGSize(width: 375, height: 812)
        case .iPhoneMax: return CGSize(width: 414, height: 896)
        case .iPad: return CGSize(width: 768, height: 1024)
        case .iPadPortraint: return CGSize(width: 1024, height: 768)
        }
    }
}

// UIWindow Factory Method
extension UIWindow {

    /// Return `UIWindow`.
    /// - Parameters:
    ///   - viewController: `UIViewController` instance to embed in `UIWindow`
    ///   - windowSize: Size for window
    ///   - parent: If `true`, will embed `viewController` in parent `UINavigationController`
    /// - Returns: `UIWindow`
    ///
    /// Usage:
    ///
    ///     let viewController = MyViewController()
    ///
    ///     // Present the view controller in the Live View window
    ///     PlaygroundPage.current.liveView = UIWindow.makeWindow(for: viewController)
    ///
    public static func makeWindow(for viewController: UIViewController,
                                  ofSize windowSize: WindowSize = .iPhoneX,
                                  parent: Bool = true) -> UIWindow {
        let frame = CGRect(origin: .zero, size: windowSize.size)
        let window = UIWindow(frame: frame)

        if parent {
            let navController = UINavigationController(rootViewController: viewController)
            window.rootViewController = navController
        } else {
            window.rootViewController = viewController
        }
        window.makeKeyAndVisible()
        return window
    }
}
