//
//  Reusable.swift
//  PlaygroundKit
//
//  Created by Mathew Gacy on 10/7/20.
//  Copyright © 2020 Mathew Gacy. All rights reserved.
//
//  Based on code from:
//  https://cocoacasts.com/dequeueing-reusable-views-with-generics-and-protocols
//  https://github.com/sergdort/CleanArchitectureRxSwift
//

import UIKit

public protocol Reusable: AnyObject {
    static var reuseID: String {get}
}

public extension Reusable {
    static var reuseID: String {
        return String(describing: self)
    }
}
