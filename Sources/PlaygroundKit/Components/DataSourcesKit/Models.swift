//
//  Models.swift
//  PlaygroundKit
//
//  Created by Mathew Gacy on 6/6/21.
//

import UIKit

/// Model for diffable data sources with a single section.
public enum SingleSection: CaseIterable {
    case main

    public static func makeSnapshot<T: Hashable>(for updated: [T]) -> NSDiffableDataSourceSnapshot<Self, T> {
        var snapshot = NSDiffableDataSourceSnapshot<Self, T>()
        snapshot.appendSections([.main])
        snapshot.appendItems(updated, toSection: .main)
        return snapshot
    }
}
