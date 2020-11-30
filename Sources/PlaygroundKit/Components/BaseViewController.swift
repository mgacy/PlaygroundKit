//
//  BaseViewController.swift
//  PlaygroundKit
//
//  Created by Mathew Gacy on 10/7/20.
//  Copyright © 2020 Mathew Gacy. All rights reserved.
//

import UIKit

open class BaseViewController : UIViewController {

    // Navigation bar actions
    open var button1Action: (() -> Void)?
    open var button2Action: (() -> Void)?
    open var button3Action: (() -> Void)?
    open var button4Action: (() -> Void)?

    // MARK: - Subviews

    private lazy var barButton1: UIBarButtonItem = {
        let image = UIImage(systemName: "1.circle")
        let button = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(didPressButton1(_:)))
        return button
    }()

    private lazy var barButton2: UIBarButtonItem = {
        let image = UIImage(systemName: "2.circle")
        let button = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(didPressButton2(_:)))
        return button
    }()

    private lazy var barButton3: UIBarButtonItem = {
        let image = UIImage(systemName: "3.circle")
        let button = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(didPressButton3(_:)))
        return button
    }()

    private lazy var barButton4: UIBarButtonItem = {
        let image = UIImage(systemName: "4.circle")
        let button = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(didPressButton4(_:)))
        return button
    }()

    // MARK: - Lifecycle

    override open func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - View Methods

    open func setupView() {
        view.backgroundColor = .systemBackground
        navigationItem.leftBarButtonItems = [barButton1, barButton2]
        navigationItem.rightBarButtonItems = [barButton4, barButton3]
        setupNavBarActions()
    }

    // TODO: is there really any reason for this here?
    //open func setupConstraints() {}

    open func setupNavBarActions() {
        button1Action = { print("Did press button 1") }
        button2Action = { print("Did press button 2") }
        button3Action = { print("Did press button 3") }
        button4Action = { print("Did press button 4") }
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
}
