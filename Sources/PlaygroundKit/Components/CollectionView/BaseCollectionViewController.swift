//
//  BaseCollectionViewController.swift
//  
//
//  Created by Mathew Gacy on 6/8/21.
//

import UIKit

open class BaseCollectionViewController<
    Item: Hashable,
    Cell: CollectionCellConfigurable
>: BaseViewController, UICollectionViewDelegate, CollectionViewDiffableDataSourceProvider where
    Cell.ModelType == Item
{
    private let layoutBuilder: CollectionViewLayoutBuilder
    public var wasRefreshedManually = false
    public lazy var dataSource = makeDataSource(for: collectionView)

    // MARK: - Subviews

    public lazy var collectionView: UICollectionView = {
        let layout = layoutBuilder.build()
        let view = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        view.backgroundColor = .systemBackground
        view.delegate = self
        view.refreshControl = refreshControl
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return view
    }()

    public lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refreshControlDidChange(_:)), for: .valueChanged)
        return control
    }()

    // MARK: - Lifecycle

    public init(
        layoutBuilder: CollectionViewLayoutBuilder = LayoutBuilder()
    ) {
        self.layoutBuilder = layoutBuilder
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        getItems()
    }

    // MARK: - View Methods

    open override func setupView() {
        super.setupView()

        // Try to fix UIRefreshControl issues
        edgesForExtendedLayout = [.all] // [.top]?
        extendedLayoutIncludesOpaqueBars = true

        view.addSubview(collectionView)
        collectionView.register(cellType: Cell.self)
        collectionView.dataSource = dataSource
    }

    // MARK: - Actions

    @objc open func refreshControlDidChange(_ sender: UIRefreshControl) {
        wasRefreshedManually = true
        getItems()
    }

    open func getItems() {
        if !wasRefreshedManually {
            refreshControl.beginRefreshing()
        }
    }

    open func update(items: [Item]) {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.dataSource.apply(SingleSection.makeSnapshot(for: items))
        }
    }

    // MARK: - UICollectionViewDelegate

    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let model = dataSource.itemIdentifier(for: indexPath) else {
           return
        }
        print("Selected: \(model)")
    }

    open func configureCell(_ cell: Cell, with model: Item) -> Cell {
        cell.configure(with: model)
        return cell
    }

    // MARK: - TableViewDataSourceConfigurable
    public typealias CellType = Cell

    open func makeDataSource(
        for collectionView: UICollectionView
    ) -> UICollectionViewDiffableDataSource<SingleSection, Item> {
        return UICollectionViewDiffableDataSource(
            collectionView: collectionView,
            cellProvider: { [weak self] collectionView, indexPath, model in
                let cell: CellType = collectionView.dequeueReusableCell(for: indexPath)
                return self?.configureCell(cell, with: model)
            })
    }
}

