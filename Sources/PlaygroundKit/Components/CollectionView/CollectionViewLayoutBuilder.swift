//
//  CollectionViewLayoutBuilder.swift
//  
//
//  Created by Mathew Gacy on 6/14/21.
//

import UIKit

// MARK: - NSCollectionLayoutSize + Item Size Provider
public extension NSCollectionLayoutSize {

    static var defaultItemSizeProvider: (NSCollectionLayoutEnvironment) -> NSCollectionLayoutSize {
        { layoutEnvironment in
            let fractionalItemWidth: CGFloat
            switch layoutEnvironment.traitCollection.horizontalSizeClass {
            case .unspecified:
                fractionalItemWidth = 1/2
            case .compact:
                fractionalItemWidth = 1/2
            case .regular:
                fractionalItemWidth = 1/3
            @unknown default:
                fractionalItemWidth = 1/2
            }
            return NSCollectionLayoutSize(widthDimension: .fractionalWidth(fractionalItemWidth),
                                          heightDimension: .fractionalHeight(1))
        }
    }

    static var defaultGroupSizeProvider: (NSCollectionLayoutEnvironment) -> NSCollectionLayoutSize {
        { layoutEnvironment in
            NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                   heightDimension: .fractionalHeight(1/3))
        }
    }
}

// MARK: - NSCollectionLayoutItem + Factory
public extension NSCollectionLayoutItem {

    static func makeItemsProviderFactory(
        sizeProvider: @escaping (NSCollectionLayoutEnvironment) -> NSCollectionLayoutSize
    ) -> (NSCollectionLayoutEnvironment) -> [NSCollectionLayoutItem] {
        { layoutEnvironment in
            let itemSize = sizeProvider(layoutEnvironment)
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            //item.contentInsets = ...
            return [item]
        }
    }
}

// MARK: - NSCollectionLayoutGroup + Factory
public extension NSCollectionLayoutGroup {

    static func makeGroupProviderFactory(
        sizeProvider: @escaping (NSCollectionLayoutEnvironment) -> NSCollectionLayoutSize,
        itemsProvider: @escaping (NSCollectionLayoutEnvironment) -> [NSCollectionLayoutItem]
    ) -> (NSCollectionLayoutEnvironment) -> NSCollectionLayoutGroup {
        { layoutEnvironment in
            let items = itemsProvider(layoutEnvironment)
            let groupSize = sizeProvider(layoutEnvironment)
            return NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: items)
        }
    }
}

// MARK: - UICollectionViewCompositionalLayoutConfiguration + Defaults
public extension UICollectionViewCompositionalLayoutConfiguration {

    static var defaultVertical: UICollectionViewCompositionalLayoutConfiguration {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .vertical
        return configuration
    }

    static var defaultHorizontal: UICollectionViewCompositionalLayoutConfiguration {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .horizontal
        return configuration
    }
}

// MARK: - LayoutBuilder

public protocol CollectionViewLayoutBuilder {
    func build() -> UICollectionViewLayout
}

public struct LayoutBuilder: CollectionViewLayoutBuilder {

    public typealias Environment = NSCollectionLayoutEnvironment
    public typealias Size = NSCollectionLayoutSize
    public typealias Item = NSCollectionLayoutItem
    public typealias Group = NSCollectionLayoutGroup
    public typealias Section = NSCollectionLayoutSection
    public typealias SectionProvider = UICollectionViewCompositionalLayoutSectionProvider
    public typealias Configuration = UICollectionViewCompositionalLayoutConfiguration

    public typealias SizeProvider = (Environment) -> Size
    public typealias ItemsProvider = (Environment) -> [Item]
    public typealias GroupProvider = (Environment) -> Group

    // MARK: - A

    public let itemSizeProvider: SizeProvider
    public let itemsProviderFactory: (@escaping SizeProvider) -> ItemsProvider
    public let groupSizeProvider: SizeProvider
    public let groupProviderFactory: (@escaping SizeProvider, @escaping ItemsProvider) -> GroupProvider
    public let configuration: Configuration

    public init(
        itemSizeProvider: @escaping SizeProvider = Size.defaultItemSizeProvider,
        itemsProvider: @escaping (@escaping SizeProvider) -> ItemsProvider = Item.makeItemsProviderFactory,
        groupSizeProvider: @escaping SizeProvider = Size.defaultGroupSizeProvider,
        groupProviderFactory: @escaping (
            @escaping SizeProvider,
            @escaping ItemsProvider
        ) -> GroupProvider = Group.makeGroupProviderFactory,
        configuration: Configuration = Configuration.defaultVertical
    ) {
        self.itemSizeProvider = itemSizeProvider
        self.itemsProviderFactory = itemsProvider
        self.groupSizeProvider = groupSizeProvider
        self.groupProviderFactory = groupProviderFactory
        self.configuration = configuration
    }

    public func build() -> UICollectionViewLayout {
        let provider: SectionProvider = { _, layoutEnvironment in
            let itemsProvider = itemsProviderFactory(itemSizeProvider)
            let groupProvider = groupProviderFactory(groupSizeProvider, itemsProvider)
            let group = groupProvider(layoutEnvironment)
            return NSCollectionLayoutSection(group: group)
        }
        return UICollectionViewCompositionalLayout(sectionProvider: provider, configuration: configuration)
    }
}
