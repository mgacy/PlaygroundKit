//
//  UIKit+Reusable.swift
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

// MARK: - Collection View

extension UICollectionReusableView: Reusable {}

extension UICollectionView {

    /// Registers a class for use in creating new collection view cells.
    public func register<T: UICollectionViewCell>(cellType: T.Type) {
        register(cellType.self, forCellWithReuseIdentifier: cellType.reuseID)
    }

    /// Dequeues a reusable cell object.
    /// - Returns: A valid `UICollectionReusableView` object.
    public func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseID, for: indexPath) as? T else {
            fatalError("Unable to dequeue reusable collection view cell: \(T.self)")
        }
        return cell
    }

    /// Dequeues a reusable supplementary view.
    /// - Returns: A valid `UICollectionReusableView` object.
    public func dequeueReusableSupplementaryView<T: UICollectionReusableView>(
        ofKind kind: String,
        for indexPath: IndexPath
    ) -> T {
        guard let section = dequeueReusableSupplementaryView(ofKind: kind,
                                                             withReuseIdentifier: T.reuseID,
                                                             for: indexPath) as? T else {
            fatalError("Unable to dequeue reusable supplementary view: \(T.self)")
        }
        return section
    }
}

extension UICollectionViewLayout {

    /// Registers a class for use in creating decoration views for a collection view.
    public func register<T: Reusable>(viewType: T.Type) {
        register(viewType, forDecorationViewOfKind: T.reuseID)
    }
}

extension NSCollectionLayoutDecorationItem {

    /// Creates a section background.
    public class func background<T: Reusable>(elementType: T.Type) -> Self {
        return background(elementKind: T.reuseID)
    }
}

// MARK: - Table View

extension UITableViewCell: Reusable {}

extension UITableView {

    /// Registers a class to use in creating new table cells.
    public func register<T: UITableViewCell>(cellType: T.Type) {
        self.register(cellType.self, forCellReuseIdentifier: cellType.reuseID)
    }

    /// Returns a reusable table-view cell object and adds it to the table.
    /// - Returns: A `UITableViewCell` object.
    public func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseID, for: indexPath) as? T else {
            fatalError("Unable to dequeue reusable table view cell: \(T.self)")
        }
        return cell
    }
}
