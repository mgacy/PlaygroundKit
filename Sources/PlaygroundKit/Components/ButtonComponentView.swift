//
//  ButtonComponentView.swift
//  PlaygroundKit
//
//  Created by Mathew Gacy on 10/7/20.
//  Copyright © 2020 Mathew Gacy. All rights reserved.
//

import UIKit

public class ButtonComponentView: UIView {

    public var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    public var info: String? {
        didSet {
            infoLabel.text = info
        }
    }

    public var buttonTitle: String? {
        didSet {
            button.setTitle(buttonTitle, for: .normal)
        }
    }

    public var buttonAction: (() -> Void)?

    // MARK: - Appearance

    let horizontalInset: CGFloat = 16.0

    // MARK: - Subviews

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 5.0
        button.backgroundColor = button.tintColor
        //button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        button.addTarget(self, action: #selector(didPressButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var horizontalStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [button, activityIndicator, infoLabel])
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fillEqually
        view.spacing = 5.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var verticalStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleLabel, horizontalStackView])
        view.axis = .vertical
        view.alignment = .leading
        view.distribution = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override public var intrinsicContentSize: CGSize {
        return verticalStackView.intrinsicContentSize
    }

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configure()
    }

    // MARK: - Configuration

    private func configure() {
        addSubview(verticalStackView)
        setupConstraints()
    }

    private func setupConstraints() {
        let guide = self.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: horizontalInset),
            verticalStackView.topAnchor.constraint(equalTo: topAnchor, constant: horizontalInset / 2.0),
            verticalStackView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -horizontalInset),
            verticalStackView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -horizontalInset / 2.0)
        ])
    }

    // MARK: - B

    //override func layoutSubviews() {
    //    super.layoutSubviews()
    //}

    // MARK: Actions

    @objc private func didPressButton(_ sender: UIButton) {
        buttonAction?()
    }

}
