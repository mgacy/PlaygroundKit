//
//  X.swift
//  PlaygroundKit
//
//  Created by Mathew Gacy on 10/7/20.
//  Copyright © 2020 Mathew Gacy. All rights reserved.
//

import UIKit

let log = Logger.self

open class BaseCollectionViewFlowLayout: UICollectionViewFlowLayout {

    // MARK: Configuring the Item Spacing

    /// The minimum spacing to use between lines of items in the grid.
    //var minimumLineSpacing: CGFloat { get set }

    /// The minimum spacing to use between items in the same row.
    //var minimumInteritemSpacing: CGFloat { get set }

    /// The default size to use for cells.
    //var itemSize: CGSize { get set }

    /// The estimated size of cells in the collection view.
    //var estimatedItemSize: CGSize { get set }

    /// The margins used to lay out content in a section
    //var sectionInset: UIEdgeInsets { get set }

    /// Possible values: `.fromContentInset` / `.fromLayoutMargins` / `.fromSafeArea`
    //var sectionInsetReference: UICollectionViewFlowLayout.SectionInsetReference { get set }

    // Configuring the Supplementary Views

    /// The default sizes to use for section headers.
    //var headerReferenceSize: CGSize { get set }

    /// The default sizes to use for section footers.
    //var footerReferenceSize: CGSize { get set }

    /// Returns the width and height of the collection view’s contents.
    //var collectionViewContentSize: CGSize { get }

    // MARK: Pinning Headers and Footers

    /// A Boolean value indicating whether headers pin to the top of the collection view bounds during scrolling.
    //var sectionHeadersPinToVisibleBounds: Bool

    /// A Boolean value indicating whether footers pin to the bottom of the collection view bounds during scrolling.
    //var sectionFootersPinToVisibleBounds: Bool

    // MARK: Providing Layout Attributes

    /// Tells the layout object to update the current layout.
    override open func prepare() {
        log.debug("")
        super.prepare()
    }

    /// Returns the layout attributes for all of the cells and views in the specified rectangle.
    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let result = super.layoutAttributesForElements(in: rect)
        log.debug("\(rect) - \(String(describing: result))")
        return result
    }

    /// Returns the layout attributes for the item at the specified index path.
    override open func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let result = super.layoutAttributesForItem(at: indexPath)
        log.debug("\(indexPath): \(String(describing: result))")
        return result
    }

    /// Returns the layout attributes of an item when it is being moved interactively by the user.
    //override open func layoutAttributesForInteractivelyMovingItem(at indexPath: IndexPath, withTargetPosition position: CGPoint) -> UICollectionViewLayoutAttributes {}

    /// Returns the layout attributes for the specified supplementary view.
    //override open func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {}

    /// Returns the layout attributes for the specified decoration view.
    //override open func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {}

    /// Returns the content offset to use after an animated layout update or change.
    override open func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        log.debug("\(proposedContentOffset)")
        return proposedContentOffset
    }

    /// Returns the point at which to stop scrolling.
    override open func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        log.debug("offset: \(proposedContentOffset) - velocity: \(velocity)")
        return proposedContentOffset
    }

    // MARK: Responding to Collection View Updates

    /// Notifies the layout object that the contents of the collection view are about to change.
    override open func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem]) {
        log.debug("\(updateItems)")
        super.prepare(forCollectionViewUpdates: updateItems)
    }

    /// Performs any additional animations or clean up needed during a collection view update.
    override open func finalizeCollectionViewUpdates() {
        log.debug("")
        super.finalizeCollectionViewUpdates()
    }

    /// Returns an array of index paths for the supplementary views you want to add to the layout.
    //override open func indexPathsToInsertForSupplementaryView(ofKind elementKind: String) -> [IndexPath] {}

    /// Returns an array of index paths representing the decoration views to add.
    //override open func indexPathsToInsertForDecorationView(ofKind elementKind: String) -> [IndexPath] {}

    /// Returns the starting layout information for an item being inserted into the collection view.
    //override open func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {}

    /// Returns the starting layout information for a supplementary view being inserted into the collection view.
    //override open func initialLayoutAttributesForAppearingSupplementaryElement(ofKind elementKind: String, at elementIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {}

    // ...

    // MARK: Invalidating the Layout

    /// Invalidates the current layout and triggers a layout update.
    override open func invalidateLayout() {
        log.debug("")
        super.invalidateLayout()
    }

    /// Invalidates the current layout using the information in the provided context object.
    override open func invalidateLayout(with context: UICollectionViewLayoutInvalidationContext) {
        log.debug("\(context)")
        super.invalidateLayout(with: context)
    }

    /// Asks the layout object if the new bounds require a layout update.
    override open func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        let result = super.shouldInvalidateLayout(forBoundsChange: newBounds)
        log.debug("\(newBounds) - \(result)")
        return result
    }

    // ...

    /// Asks the layout object if changes to a self-sizing cell require a layout update.
    override open func shouldInvalidateLayout(forPreferredLayoutAttributes preferredAttributes: UICollectionViewLayoutAttributes, withOriginalAttributes originalAttributes: UICollectionViewLayoutAttributes) -> Bool {
        let result = super.shouldInvalidateLayout(forPreferredLayoutAttributes: preferredAttributes, withOriginalAttributes: originalAttributes)
        log.debug("preferred: \(preferredAttributes) - original: \(originalAttributes) - result: \(result)")
        return result
    }

    // ...

    // MARK: Coordinating Animated Changes

    /// Prepares the layout object for animated changes to the view’s bounds or the insertion or deletion of items.
    override open func prepare(forAnimatedBoundsChange oldBounds: CGRect) {
        log.debug("\(oldBounds)")
        super.prepare(forAnimatedBoundsChange: oldBounds)
    }

    /// Cleans up after any animated changes to the view’s bounds or after the insertion or deletion of items.
    override open func finalizeAnimatedBoundsChange() {
        log.debug("")
        super.finalizeAnimatedBoundsChange()
    }

    // MARK: Transitioning Between Layouts

    /// Tells the layout object to prepare to be installed as the layout for the collection view.
    override open func prepareForTransition(from oldLayout: UICollectionViewLayout) {
        log.debug("\(oldLayout)")
        super.prepareForTransition(from: oldLayout)
    }

    /// Tells the layout object that it is about to be removed as the layout for the collection view.
    override open func prepareForTransition(to newLayout: UICollectionViewLayout) {
        log.debug("\(newLayout)")
        super.prepareForTransition(to: newLayout)
    }

    /// Tells the layout object to perform any final steps before the transition animations occur.
    override open func finalizeLayoutTransition() {
        log.debug("")
        super.finalizeLayoutTransition()
    }
}
