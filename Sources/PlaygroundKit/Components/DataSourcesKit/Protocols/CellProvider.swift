//
//  CellProvider.swift
//  PlaygroundKit
//
//  Created by Mathew Gacy on 6/6/21.
//

import UIKit

public protocol CellFactory {
    associatedtype ViewType // `ContainerView`?
    associatedtype CellType: CellConfigurable

    func cell(for model: CellType.ModelType, in view: ViewType, at indexPath: IndexPath) -> CellType
}

// TODO: add `AsyncCellFactory: CellFactory` with alternate method for cells using asynchronously configured cells
