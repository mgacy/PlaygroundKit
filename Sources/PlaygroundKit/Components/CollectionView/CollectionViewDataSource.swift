//
//  CollectionViewDataSource.swift
//  PlaygroundKit
//
//  Created by Mathew Gacy on 10/7/20.
//  Copyright © 2020 Mathew Gacy. All rights reserved.
//

import UIKit

// Cell Protocol

// CellFactory Protocol
public protocol CellFactory {
    associatedtype ViewType // `ContainerView`?
    associatedtype CellType: CellConfigurable

    func cell(for model: CellType.ModelType, in view: ViewType, at indexPath: IndexPath) -> CellType
}


public struct CollectionViewCellFactory<CellType>: CellFactory where CellType: CellConfigurable & UICollectionViewCell {
    public typealias ViewType = UICollectionView

    public init() {}

    public func cell(for item: CellType.ModelType, in view: UICollectionView, at indexPath: IndexPath) -> CellType {
        let cell: CellType = view.dequeueReusableCell(for: indexPath)
        cell.configure(with: item)
        return cell
    }
}


public class CollectionViewDataSource<T: CellFactory>: NSObject, UICollectionViewDataSource where T.ViewType == UICollectionView, T.CellType: UICollectionViewCell {
    public typealias Model = T.CellType.ModelType
    public typealias Cell = T.CellType

    public var models: [T.CellType.ModelType] = []

    var cellFactory: T

    public init(models: [Model], cellFactory: T) {
        self.models = models
        self.cellFactory = cellFactory
    }

    // MARK: - A

    open func model(for indexPath: IndexPath) -> T.CellType.ModelType {
        return models[indexPath.row]
    }

    // MARK: - UICollectionViewDataSource

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = models[indexPath.row]
        return cellFactory.cell(for: model, in: collectionView, at: indexPath)
    }
}


// MARK: - More? (Not Sure About This)
protocol DataSourceType {
    associatedtype Factory: CellFactory
    var models: [Factory.CellType.ModelType] { get }
    var cellFactory: Factory { get }
    func model(for indexPath: IndexPath) -> Factory.CellType.ModelType
}

extension DataSourceType where Factory.ViewType == UICollectionView, Factory.CellType: UICollectionViewCell {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = models[indexPath.row]
        return cellFactory.cell(for: model, in: collectionView, at: indexPath)
    }
}

// MARK: - Older Work
//public class GenericCollectionViewDataSouce<CellType> where CellType: CellConfigurable & UICollectionViewCell {
//
//    public var models: [CellType.ModelType] = []
//
//    var cellFactory: CollectionViewCellFactory<CellType>
//
//    init(models: [CellType.ModelType], cellFactory: CollectionViewCellFactory<CellType>) {
//        self.models = models
//        self.cellFactory = cellFactory
//    }
//
//    // MARK: - A
//
//    //open func objectAtIndexPath(_ indexPath: IndexPath) -> T {
//    //    return models[indexPath.row]
//    //}
//
//    // MARK: - UICollectionViewDataSource
//
//    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return models.count
//    }
//
//    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let model = models[indexPath.row]
//        return cellFactory.cell(for: model, in: collectionView, at: indexPath)
//    }
//}
