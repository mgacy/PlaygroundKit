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

    public func register<T: UICollectionViewCell>(cellType: T.Type) {
        register(cellType.self, forCellWithReuseIdentifier: cellType.reuseID)
    }

    public func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseID, for: indexPath) as? T else {
            fatalError("Unable to dequeue reusable collection view cell: \(T.self)")
        }
        return cell
    }

    public func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind kind: String, for indexPath: IndexPath) -> T {
        guard let section = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.reuseID, for: indexPath) as? T else {
            fatalError("Unable to dequeue reusable supplementary view: \(T.self)")
        }
        return section
    }
}

extension UICollectionViewLayout {

    public func register<T: Reusable>(viewType: T.Type) {
        register(viewType, forDecorationViewOfKind: T.reuseID)
    }
}

extension NSCollectionLayoutDecorationItem {

    public class func background<T: Reusable>(elementType: T.Type) -> Self {
        return background(elementKind: T.reuseID)
    }
}

// MARK: - Table View

extension UITableViewCell: Reusable {}

extension UITableView {

    public func register<T: UITableViewCell>(cellType: T.Type) {
        self.register(cellType.self, forCellReuseIdentifier: cellType.reuseID)
    }

    public func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseID, for: indexPath) as? T else {
            fatalError("Unable to dequeue reusable table view cell: \(T.self)")
        }
        return cell
    }
}
