//
//  SwitchComponentView.swift
//  PlaygroundKit
//
//  Created by Mathew Gacy on 12/3/20.
//  Copyright © 2020 Mathew Gacy. All rights reserved.
//

import UIKit

open class SwitchComponentView: UIView {

    public var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    public var switchAction: ((Bool) -> Void)?

    // MARK: - Appearance

    // MARK: - Subviews

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var componentSwitch: UISwitch = {
        let view = UISwitch()
        view.addTarget(self, action: #selector(didToggleSwitch(_:)), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override public var intrinsicContentSize: CGSize {
        let height = titleLabel.intrinsicContentSize.height + layoutMargins.height
        let width = (titleLabel.intrinsicContentSize.width + layoutMargins.width +
                        ViewMetrics.spacing + componentSwitch.intrinsicContentSize.width)
        return CGSize(width: width, height: height)
    }

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configure()
    }

    // MARK: - Configuration

    private func configure() {
        addSubview(titleLabel)
        addSubview(componentSwitch)
        setupConstraints()
    }

    private func setupConstraints() {
        let marginsGuide = layoutMarginsGuide
        NSLayoutConstraint.activate([
            // titleLabel
            titleLabel.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: marginsGuide.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: marginsGuide.bottomAnchor),
            // componentSwitch
            componentSwitch.centerYAnchor.constraint(equalTo: marginsGuide.centerYAnchor),
            componentSwitch.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor,
                                                     constant: ViewMetrics.spacing),
            componentSwitch.trailingAnchor.constraint(equalTo: marginsGuide.trailingAnchor),
        ])
    }

    // MARK: - B

    @objc private func didToggleSwitch(_ sender: UISwitch) {
        switch sender.isOn {
        case true:
            switchAction?(true)
        case false:
            switchAction?(false)
        }
    }
}

// MARK: - Types
extension SwitchComponentView {
    public enum ViewMetrics {
        public static var spacing: CGFloat = 8.0
    }
}
