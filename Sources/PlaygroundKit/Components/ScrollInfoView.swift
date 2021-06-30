//
//  ScrollInfoView.swift
//  PlaygroundKit
//
//  Created by Mathew Gacy on 10/20/20.
//

import UIKit

open class ScrollInfoView: UIView {

    /// Controls whether it updates on `update(with:)`
    open var isActive: Bool = true

    // MARK: - Appearance

    // TODO: add setter to change label sizes?
    static var fontSize: CGFloat = 12.0

    public var labelFont: UIFont = UIFont.systemFont(ofSize: ScrollInfoView.fontSize) {
        didSet {
            frameLabel.font = labelFont
            contentSizeLabel.font = labelFont
            topContentInsetLabel.font = labelFont
            bottomContentInsetLabel.font = labelFont
            contentOffsetLabel.font = labelFont
        }
    }

    override public var intrinsicContentSize: CGSize {
        //let dx = directionalLayoutMargins.leading + directionalLayoutMargins.trailing
        //let contentWidth = stackView.intrinsicContentSize.width
        let dy = directionalLayoutMargins.top + directionalLayoutMargins.bottom
        let contentHeight = stackView.intrinsicDimensionAlongAxis
        return CGSize(width: Self.noIntrinsicMetric, height: contentHeight + dy)
        //return CGSize(width: contentWidth + dx, height: contentHeight + dy)
    }

    // MARK: - Subviews

    public lazy var frameLabel: UILabel = {
        let label = UILabel()
        label.font = labelFont
        label.text = "frame:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    public lazy var contentSizeLabel: UILabel = {
        let label = UILabel()
        label.font = labelFont
        label.text = "contentSize:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    public lazy var topContentInsetLabel: UILabel = {
        let label = UILabel()
        label.font = labelFont
        label.text = "contentInset.top:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    public lazy var bottomContentInsetLabel: UILabel = {
        let label = UILabel()
        label.font = labelFont
        label.text = "contentInset.bottom:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    public lazy var contentOffsetLabel: UILabel = {
        let label = UILabel()
        label.font = labelFont
        label.text = "contentOffset:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [frameLabel, contentSizeLabel, topContentInsetLabel,
                                                  bottomContentInsetLabel, contentOffsetLabel])
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fillEqually
        view.spacing = 5.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Lifecycle

    public convenience init() {
        self.init(frame: CGRect.zero)
    }

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
        backgroundColor = .clear
        addSubview(stackView)
        setupConstraints()
    }

    private func setupConstraints() {
        let guide = layoutMarginsGuide
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: guide.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        ])
    }
}

// MARK: - C
extension ScrollInfoView {

    open func update(with scrollView: UIScrollView) {
        guard isActive else { return }
        frameLabel.text = "frame:\t\t\t\t\(scrollView.frame)"
        contentSizeLabel.text = "contentSize:\t\t\t\(scrollView.contentSize)"
        topContentInsetLabel.text = "contentInset.top:\t\t\(scrollView.contentInset.top)"
        bottomContentInsetLabel.text = "contentInset.bottom:\t\(scrollView.contentInset.bottom)"
        contentOffsetLabel.text = "contentOffset:\t\t\t\(scrollView.contentOffset)"
    }
}

// MARK: - Helper
extension ScrollInfoView {

    public static func attach(to view: UIView) -> ScrollInfoView {
        let infoView = ScrollInfoView()
        infoView.backgroundColor = .secondarySystemBackground
        infoView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(infoView)
        NSLayoutConstraint.activate([
            infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            infoView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        return infoView
    }
}

