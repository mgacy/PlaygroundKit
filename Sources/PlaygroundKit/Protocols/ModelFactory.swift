//
//  ModelFactory.swift
//  PlaygroundKit
//
//  Created by Mathew Gacy on 10/7/20.
//  Copyright © 2020 Mathew Gacy. All rights reserved.
//

import Foundation

public protocol ModelFactoryProtocol {
    associatedtype Item
    static func makeItems(count: Int) -> [Item]

    static func makeItems(withTitles titles: [String]) -> [Item]
}
