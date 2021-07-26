//
//  ComponentContainerView.swift
//  
//
//  Created by Mathew Gacy on 6/14/21.
//

import UIKit
/*
// MARK: - Component View Protocol
public protocol ComponentViewProtocol: UIView {
    var labelSize: CGFloat { get set }
    var labelFont UIFont { get set }
}

// MARK: - Data Source
public protocol ComponentContainerDataSourceProtocol {
    var componentViews: [ComponentViewProtocol] { get }
}

open class ComponentContainerDataSource {

    public private(set) componentViews: [UIView]

    // TODO: (optionally?) provide info about size of component views?

    init(componentViews: [ComponentView]) {
        self.componentViews = componentViews
    }
}
*/
// MARK: - View

open class ComponentContainerView: UIView {
    // TODO: replace with protocol or base UIView subclass
    public typealias ComponentView = UIView

    //public var dataSource: ComponentViewDataSource

    // MARK: - Appearance

    // MARK: - Subviews

    internal lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: componentViews)
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fillEqually // or .fill
        view.spacing = UIStackView.spacingUseSystem
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var componentViews: [ComponentView]

    //public var labelSize: CGFloat { didSet { componentViews.forEach { $0.labelSize = labelSize }}
    //public var labelFont: UIFont { didSet { componentViews.forEach { $0.labelFont = labelFont }}

    //open override var backgroundColor: UIColor? {
    //    didSet {
    //        componentViews.forEach { $0.backgroundColor = backgroundColor }
    //    }
    //}

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

    // MARK: - B

    public func addComponentView(_ componentView: ComponentView) {
        stackView.addSubview(componentView)
        // ...
    }
}
