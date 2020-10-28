//
//  SegmentComponentView.swift
//  PlaygroundKit
//
//  Created by Mathew Gacy on 10/7/20.
//  Copyright © 2020 Mathew Gacy. All rights reserved.
//

import UIKit

// TODO: add optional method to convert segmentItems to titles?

public class SegmentComponentView<T>: UIView {

    public private(set) var segmentItems: [T] = [] // TODO: rename `segmentValues`?
    //var segmentTitles: [String] = []

    //public private(set) var value: T

    public var componentHandler: ((T) -> Void)?

    public var selectedSegmentIndex: Int {
        get {
            return segmentControl.selectedSegmentIndex
        }
        set {
            // FIXME: handle invalid value
            guard 0...segmentItems.count ~= newValue else { return }
            segmentControl.selectedSegmentIndex = newValue
            let value = segmentItems[newValue]
            componentHandler?(value)
        }
    }

    /// Spacing between `labelStack` and `segmentControl`
    private let componentSpacing: CGFloat = 4.0

    // MARK: - Appearance

    public var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    public var value: String? {
        didSet {
            valueLabel.text = value
        }
    }

    // MARK: - Subviews

    private lazy var segmentControl: UISegmentedControl = {
        let view = UISegmentedControl()
        view.addTarget(self, action: #selector(didChangeValue(_:)), for: .valueChanged)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let valueLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var labelStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
        view.axis = .horizontal
        view.alignment = .firstBaseline
        view.distribution = .fillEqually // ?
        view.spacing = 8.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override public var intrinsicContentSize: CGSize {
        let labelWidth = titleLabel.intrinsicContentSize.width
            + valueLabel.intrinsicContentSize.width + labelStackView.spacing
        let labelHeight = max(titleLabel.intrinsicContentSize.height, valueLabel.intrinsicContentSize.height)
        let segmentHeight = segmentControl.intrinsicContentSize.height
        let width = max (labelWidth, segmentControl.intrinsicContentSize.width)
        return CGSize(width: width + layoutMargins.width,
                      height: labelHeight + segmentHeight + layoutMargins.height + componentSpacing)
    }

    // MARK: - Lifecycle

    // TODO: add optional param for `selectedSegmentIndex: Int`?
    public convenience init?(segmentItems: [T], segmentTitles: [String]) {
        self.init(frame: CGRect.zero)
        self.segmentItems = segmentItems
        //self.segmentTitles = segmentTitles

        do {
            try updateItems(with: segmentItems, titles: segmentTitles, animated: false)
        } catch {
            return nil
        }
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration

    private func configure() {
        addSubview(labelStackView)
        //backgroundColor = .systemBackground
        // TESTING:
        //titleLabel.backgroundColor = .cyan
        //valueLabel.backgroundColor = .magenta
        //backgroundColor = .red

        addSubview(segmentControl)
        setupConstraints()
    }

    private func setupConstraints() {
        let guide = layoutMarginsGuide
        NSLayoutConstraint.activate([
            // labelStackView
            labelStackView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            labelStackView.topAnchor.constraint(equalTo: guide.topAnchor),
            labelStackView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            // segmentControl
            segmentControl.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            segmentControl.topAnchor.constraint(equalTo: labelStackView.bottomAnchor, constant: componentSpacing),
            segmentControl.trailingAnchor.constraint(equalTo: guide.trailingAnchor)
        ])
    }
    /*
    // TODO: add relativeWidthContstraint
    // TODO: update constraint once set
    public var relativeTitleWidth: CGFloat = 0.5

    private func setupConstraints2() {
        let guide = layoutMarginsGuide
        let spacing: CGFloat = 8.0
        NSLayoutConstraint.activate([
            // titleLabel
            titleLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: guide.topAnchor),
            //titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spacing),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: relativeTitleWidth, constant: -spacing),
            // valueLabel
            //valueLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            valueLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: spacing),
            valueLabel.topAnchor.constraint(equalTo: guide.topAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            // segmentControl
            segmentControl.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            segmentControl.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: spacing),
            segmentControl.trailingAnchor.constraint(equalTo: guide.trailingAnchor)
        ])
    }
    */
    // MARK: - Actions

    @objc private func didChangeValue(_ sender: UISegmentedControl) {
        let idx = sender.selectedSegmentIndex
        print("Selected Segment Index: \(idx)")
        let value = segmentItems[idx]
        componentHandler?(value)
    }

    // MARK: - C

    // TODO: add optional parameter to set selected index?
    // TODO: if selected index not given but there was already one, should we restore that selection?
    public func updateItems(with newItems: [T], titles: [String], animated: Bool = false) throws  {
        guard newItems.count == titles.count else {
            throw SegmentComponentViewError.itemCountMismatch
        }
        segmentControl.removeAllSegments()

        segmentItems = newItems
        //segmentTitles = titles

        for (idx, title) in titles.enumerated() {
            segmentControl.insertSegment(withTitle: title, at: idx, animated: animated)
        }
    }
}

// MARK: - Support CustomStringConvertible
extension SegmentComponentView where T: CustomStringConvertible {

    public convenience init(items: [T]) {
        self.init(frame: CGRect.zero)
        updateItems(with: items)
    }

    // TODO: add optional parameter to set selected index?
    // TODO: if selected index not given but there was already one, should we restore that selection?
    public func updateItems(with newItems: [T], animated: Bool = true) {
        segmentControl.removeAllSegments()
        segmentItems = newItems
        for (idx, item) in newItems.enumerated() {
            segmentControl.insertSegment(withTitle: item.description, at: idx, animated: animated)
        }
    }
}

// MARK: - Internal Types
extension SegmentComponentView {
    public enum SegmentComponentViewError: Error, CustomStringConvertible {
        case itemCountMismatch
        case unknown(message: String)

        public var description: String {
            switch self {
            case .itemCountMismatch:
                return "Count of items must match that of titles"
            case .unknown(let message):
                return message
            }
        }
    }
}
