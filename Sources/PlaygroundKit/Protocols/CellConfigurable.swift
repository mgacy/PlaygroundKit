//
//  CellConfigurable.swift
//  PlaygroundKit
//
//  Created by Mathew Gacy on 10/7/20.
//  Copyright © 2020 Mathew Gacy. All rights reserved.
//

public protocol CellConfigurable {
    associatedtype ModelType

    func configure(with: ModelType)
}
