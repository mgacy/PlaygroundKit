//
//  BaseTableViewController.swift
//  PlaygroundKit
//
//  Created by Mathew Gacy on 10/7/20.
//  Copyright © 2020 Mathew Gacy. All rights reserved.
//

import UIKit

open class BaseTableViewController<T>: UITableViewController {

    // Navigation bar actions
    open var button1Action: (() -> Void)?
    open var button2Action: (() -> Void)?
    open var button3Action: (() -> Void)?
    open var button4Action: (() -> Void)?

    open lazy var dataSource = MyDataSource<T>()

    // MARK: Subviews

    private lazy var barButton1: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(didPressButton1(_:)))
        return button
    }()

    private lazy var barButton2: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didPressButton2(_:)))
        return button
    }()

    private lazy var barButton3: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(didPressButton3(_:)))
        return button
    }()

    private lazy var barButton4: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didPressButton4(_:)))
        return button
    }()

    /*
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlDidChange(_:)), for: .valueChanged)
        return refreshControl
    }()
     */

    // TODO: remove?
    private lazy var tableHeaderView: UIView = {
        return UIView()
    }()

    // MARK: Lifecycle

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: View Configuration

    open func setupView() {
        view.backgroundColor = .systemBackground
        navigationItem.leftBarButtonItems = [barButton1, barButton2]
        navigationItem.rightBarButtonItems = [barButton4, barButton3]

        setupNavBarActions()
        setupTableView()
    }

    open func setupNavBarActions() {
        button1Action = { print("Did press button 1") }
        button2Action = { print("Did press button 2") }
        button3Action = { print("Did press button 3") }
        button4Action = { print("Did press button 4") }
    }

    open func setupTableView() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshControlDidChange(_:)), for: .valueChanged)
        tableView.delegate = self

        // TODO: implement all of the following in subclasses?
        tableView.dataSource = dataSource
        tableView.estimatedRowHeight = 83.0
        tableView.tableFooterView = UIView() // Prevent empty rows
        tableView.separatorStyle = .none
        tableView.register(cellType: UITableViewCell.self)

        //dataSource.setup()
        //dataSource.setup2()
    }

    // MARK: - Actions

    @objc private func didPressButton1(_ sender: UIBarButtonItem) {
        button1Action?()
    }

    @objc private func didPressButton2(_ sender: UIBarButtonItem) {
        button2Action?()
    }

    @objc private func didPressButton3(_ sender: UIBarButtonItem) {
        button3Action?()
    }

    @objc private func didPressButton4(_ sender: UIBarButtonItem) {
        button4Action?()
    }

    @objc func refreshControlDidChange(_ sender: UIRefreshControl) {
        print("\(#function) - \(sender)")
        dataSource.refresh {
            self.tableView.reloadData()
            DispatchQueue.main.async {
                self.refreshControl?.endRefreshing()
                //self.tableView.restore()
            }
        }
    }

    // MARK: UITableViewDelegate

    override open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = dataSource.objectAtIndexPath(indexPath)
        print("Selected item: \(item)")

        // ...

        //tableView.deselectRow(at: indexPath, animated: true)
    }

    override open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 4.0
    }

    override open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableHeaderView
    }

    // MARK: Fix Refresh Control
    /*
    override func scrollViewDidEndDragging(
        _ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // Allowing refresh control to finish animating.
        DispatchQueue.main.async {
            guard let rc = scrollView.refreshControl, rc.isRefreshing else {
                return
            }

            rc.endRefreshing()
        }
    }
 */
}

// MARK: - DataSource
//open class MyDataSource<Cell: TableCellConfigurable>: NSObject, UITableViewDataSource {
open class MyDataSource<T>: NSObject, UITableViewDataSource {
    //public typealias Item = Cell.ModelType

    // TODO: initialize with ItemFactory / ItemLoader
    private var items: [T] = []

    //public var state: Observable<ViewState<Item>>

    // MARK: Lifecycle

    override init() {
        //self.state = Observable(value: .empty)
        super.init()
    }

    // MARK: A

    open func objectAtIndexPath(_ indexPath: IndexPath) -> T {
        items[indexPath.row]
    }

    // MARK: Configuration

    open func setup() {
        //items = ItemFactory.makeItems(count: 5)
    }

    open func setup2() {
        let titles = [
            "This is a test",
            "This is another item",
            "This is another item with a very long title which should wrap around",
            "This is another item",
            "And finally, this is the last item"
        ]
        //items = ItemFactory.makeItems(withTitles: titles)
    }

    // MARK: Refresh

    public var refreshDelay: TimeInterval = 2.0
    public var refreshFromCacheDelay: TimeInterval = 0.5

    open func refresh(closure: @escaping () -> Void) {
        let newTitles = ["This is addition 1", "This is also new"]
        //let newItems = ItemFactory.makeItems(withTitles: newTitles)

        DispatchQueue.main.asyncAfter(deadline: .now() + refreshDelay) {
            //var newItems = self.items
            //newItems.insert("This is addition 1", at: 1)
            //newItems.insert("This is also new" at: 3)
            //self.items = newItems + self.items
            closure()
        }
    }

    open func refreshFromCache(closure: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + refreshFromCacheDelay) {
            closure()
        }
    }

    // MARK: - UITableViewDataSouce

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(for: indexPath)
        //let cell: BasicCell = tableView.dequeueReusableCell(for: indexPath)

        let item = objectAtIndexPath(indexPath)

        //cell.configure(with: item)
        return cell
    }
}
