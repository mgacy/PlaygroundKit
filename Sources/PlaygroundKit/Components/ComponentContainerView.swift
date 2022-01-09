//
//  ComponentContainerView.swift
//  
//
//  Created by Mathew Gacy on 6/14/21.
//

import UIKit

open class ComponentContainerView: UIView {
    // TODO: replace with protocol
    public typealias ComponentView = UIView

    // MARK: - Appearance

    // MARK: - Subviews

    internal lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: componentViews)
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fill
        view.spacing = UIStackView.spacingUseSystem
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var componentViews: [ComponentView]

    open override var backgroundColor: UIColor? {
        didSet {
            componentViews.forEach { $0.backgroundColor = backgroundColor }
        }
    }

    override public var intrinsicContentSize: CGSize {
        let dy = directionalLayoutMargins.top + directionalLayoutMargins.bottom
        let contentHeight = stackView.intrinsicDimensionAlongAxis
        return CGSize(width: Self.noIntrinsicMetric, height: contentHeight + dy)
    }

    // MARK: - Lifecycle

    public init(componentViews: [ComponentView]) {
        self.componentViews = componentViews
        super.init(frame: CGRect.zero)
        self.configure()
    }

    override init(frame: CGRect) {
        self.componentViews = []
        super.init(frame: frame)
        self.configure()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration

    internal func configure() {
        addSubview(stackView)

        let guide = layoutMarginsGuide
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: guide.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
        ])
    }

    // MARK: - Public

    public func addComponentView(_ componentView: ComponentView) {
        stackView.addSubview(componentView)
    }
}
