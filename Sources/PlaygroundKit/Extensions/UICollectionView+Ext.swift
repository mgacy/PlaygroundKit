//
//  UICollectionView+Ext.swift
//  
//
//  Created by Mathew Gacy on 6/8/21.
//

import UIKit

extension UICollectionView {

    /// Programmatically pull-to-refresh a collection view with an attached `UIRefreshControl`.
    public func pullToRefresh() {
        guard let refreshControl = refreshControl, !refreshControl.isRefreshing else {
            return
        }
        setContentOffset(CGPoint(x: 0, y: contentOffset.y - refreshControl.frame.size.height), animated: true)
    }
}
