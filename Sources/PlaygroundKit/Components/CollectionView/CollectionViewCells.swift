//
//  X.swift
//  PlaygroundKit
//
//  Created by Mathew Gacy on 10/7/20.
//  Copyright © 2020 Mathew Gacy. All rights reserved.
//

import UIKit

// MARK: - SimpleCollectionViewCell
public class SimpleCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .cyan
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
/*
public extension SimpleCollectionViewCell: CellConfigurable {
   public typealias ModelType = MyItem

   public func configure(with item: MyItem) {
       backgroundColor = item.color
   }
}
*/
