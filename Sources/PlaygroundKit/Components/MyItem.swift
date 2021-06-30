//
//  MyItem.swift
//  
//
//  Created by Mathew Gacy on 6/14/21.
//

import UIKit

public struct MyItem: Hashable {
    private let id: UUID
    public let color: UIColor

    public init(_ color: UIColor) {
        self.id = UUID()
        self.color = color
    }
}

// MARK: - Helpers
extension MyItem {

    public static func makeItems() -> [MyItem] {
        var colors: [UIColor] = [
            .blue, .cyan, .yellow, .brown, .green, .orange, .purple,
            .blue, .cyan, .yellow, .brown, .green, .orange, .purple,
            .blue, .cyan, .yellow, .brown, .green, .orange, .purple,
            .blue, .cyan, .yellow, .brown, .green, .orange, .purple,
        ]
        return colors.map { MyItem($0) }
    }
}
