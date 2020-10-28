//
//  BaseScrollViewController.swift
//  PlaygroundKit
//
//  Created by Mathew Gacy on 10/7/20.
//  Copyright © 2020 Mathew Gacy. All rights reserved.
//

import UIKit

open class BaseScrollViewController: BaseViewController {

    // MARK: - Subviews

    public let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.contentInsetAdjustmentBehavior = .always
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    }()

    open var contentView: UIView

    // MARK: - Lifecycle

    public init(contentView: UIView = UIView()) {
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func loadView() {
        let view = UIView()
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        self.view = view
        setupConstraints()
    }

    // MARK: - View Methods

    open func setupConstraints() {
        //let guide = view.safeAreaLayoutGuide
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            // scrollView
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            // contentView
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }

    // MARK: - Configuration

    open func addContentView(_ newContentView: UIView) {
        contentView.removeFromSuperview()

        contentView = newContentView
        newContentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(newContentView)
        NSLayoutConstraint.activate([
            newContentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            newContentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            newContentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            newContentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            newContentView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
}
