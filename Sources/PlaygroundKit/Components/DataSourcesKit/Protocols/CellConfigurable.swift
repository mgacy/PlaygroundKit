//
//  CellConfigurable.swift
//  PlaygroundKit
//
//  Created by Mathew Gacy on 10/7/20.
//  Copyright © 2020 Mathew Gacy. All rights reserved.
//

/// Use to configure a `UITableViewCell` or `UICollectionViewCell` with an instance of `ModelType`.
public protocol CellConfigurable {
    associatedtype ModelType

    /// Configure to display an instance of `ModelType`.
    /// - Parameter with: model
    func configure(with: ModelType)
}
